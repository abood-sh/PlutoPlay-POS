import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mek_stripe_terminal/mek_stripe_terminal.dart';
import 'package:pos/core/helpers/constants.dart';
import 'package:pos/core/helpers/shared_pref_helper.dart';
import 'package:pos/core/networking/api_error_model.dart';
import 'package:pos/core/networking/api_result.dart';
import 'package:pos/features/terminal/data/models/terminal_model.dart';
import 'package:pos/features/terminal/data/repos/terminal_repo.dart';
import 'package:pos/features/terminal/data/services/stripe_terminal_service.dart';
import 'package:pos/features/terminal/logic/cubit/terminal_state.dart';

class TerminalCubit extends Cubit<TerminalState> {
  final TerminalRepo _terminalRepo;
  final StripeTerminalService _stripeTerminalService;

  TerminalCubit(this._terminalRepo, this._stripeTerminalService)
    : super(const TerminalState.initial());

  List<TerminalModel> terminals = [];
  List<Reader> discoveredReaders = [];
  StreamSubscription<List<Reader>>? _discoverySubscription;

  /// Initialize SDK and start discovering readers
  /// This is the main entry point after login
  Future<void> initializeAndDiscoverReaders({
    required String locationId,
    bool isSimulated = false,
  }) async {
    try {
      // Step 1: Initialize SDK
      emit(const TerminalState.sdkInitializing());
      await _stripeTerminalService.initializeTerminal();
      emit(const TerminalState.sdkInitialized());

      // Save locationId for future use
      await SharedPrefHelper.setSecuredString(
        SharedPrefKeys.locationId,
        locationId,
      );

      // Small delay for UI feedback
      await Future.delayed(const Duration(milliseconds: 300));

      // Step 2: Start discovering readers
      emit(const TerminalState.discoveringReaders());

      discoveredReaders = [];

      _discoverySubscription?.cancel();

      debugPrint(
        'TerminalCubit: Starting discovery with locationId: $locationId, isSimulated: $isSimulated',
      );

      // Set a timeout for discovery
      bool hasReceivedData = false;

      _discoverySubscription = _stripeTerminalService
          .discoverReaders(locationId: locationId, isSimulated: isSimulated)
          .listen(
            (readers) {
              hasReceivedData = true;
              debugPrint(
                'TerminalCubit: Discovered ${readers.length} reader(s)',
              );
              discoveredReaders = readers;

              if (readers.isEmpty) {
                emit(const TerminalState.noReadersFound());
              } else {
                emit(TerminalState.readersDiscovered(readers));
              }
            },
            onError: (error) {
              debugPrint('TerminalCubit: Discovery error: $error');
              emit(
                TerminalState.sdkError('Failed to discover readers: $error'),
              );
            },
            onDone: () {
              debugPrint('TerminalCubit: Discovery stream completed');
              if (discoveredReaders.isEmpty) {
                emit(const TerminalState.noReadersFound());
              }
            },
          );

      // Add a safety timeout - if no data received in 10 seconds, show no readers
      Future.delayed(const Duration(seconds: 10), () {
        if (!hasReceivedData &&
            state == const TerminalState.discoveringReaders()) {
          debugPrint('TerminalCubit: Discovery timeout - no readers found');
          emit(const TerminalState.noReadersFound());
        }
      });
    } catch (e) {
      debugPrint('TerminalCubit: Error initializing SDK: $e');
      emit(TerminalState.sdkError('Failed to initialize: $e'));
    }
  }

  /// Connect to a selected reader from the discovered list
  Future<void> connectToReader(Reader reader) async {
    emit(const TerminalState.readerConnecting());

    try {
      // Stop discovery before connecting
      await _discoverySubscription?.cancel();
      _discoverySubscription = null;

      // Connect to the selected reader
      final connectedReader = await _stripeTerminalService.connectToReader(
        reader,
      );

      // Save reader info to SharedPreferences
      await _saveReaderInfo(connectedReader);

      final readerLabel = connectedReader.label ?? connectedReader.serialNumber;
      emit(TerminalState.readerConnected(readerLabel));

      // Small delay then emit terminal selected to trigger navigation
      await Future.delayed(const Duration(milliseconds: 500));
      emit(const TerminalState.terminalSelected());
    } catch (e) {
      debugPrint('TerminalCubit: Failed to connect to reader: $e');
      emit(TerminalState.readerConnectionError('Failed to connect: $e'));
    }
  }

  /// Save connected reader info to SharedPreferences
  Future<void> _saveReaderInfo(Reader reader) async {
    await SharedPrefHelper.setSecuredString(
      SharedPrefKeys.serialNumber,
      reader.serialNumber,
    );
    await SharedPrefHelper.setSecuredString(
      SharedPrefKeys.terminalLabel,
      reader.label ?? '',
    );
    await SharedPrefHelper.setSecuredString(
      SharedPrefKeys.terminalIpAddress,
      reader.ipAddress ?? '',
    );
    // For SDK readers, we use serialNumber as the ID
    await SharedPrefHelper.setSecuredString(
      SharedPrefKeys.terminalId,
      reader.serialNumber,
    );
    // Mark terminal as configured
    await SharedPrefHelper.setData(SharedPrefKeys.isTerminalConfigured, true);

    debugPrint(
      'TerminalCubit: Reader info saved - ${reader.label ?? reader.serialNumber}',
    );
  }

  /// Refresh reader discovery
  Future<void> refreshDiscovery() async {
    final locationId = await SharedPrefHelper.getSecuredString(
      SharedPrefKeys.locationId,
    );

    if (locationId.isEmpty) {
      emit(TerminalState.sdkError('No location ID configured'));
      return;
    }

    await initializeAndDiscoverReaders(locationId: locationId);
  }

  /// Stop reader discovery
  Future<void> stopDiscovery() async {
    await _discoverySubscription?.cancel();
    _discoverySubscription = null;
    await _stripeTerminalService.stopDiscovery();
  }

  // ============================================
  // Legacy methods (for backward compatibility)
  // ============================================

  void fetchTerminals(String deviceId) async {
    emit(const TerminalState.loading());

    final response = await _terminalRepo.getTerminals(deviceId);

    response.when(
      success: (terminalListResponse) {
        terminals = terminalListResponse.terminals ?? [];
        emit(TerminalState.success(terminalListResponse));
      },
      failure: (apiErrorModel) {
        emit(TerminalState.error(apiErrorModel));
      },
    );
  }

  Future<void> selectTerminal(TerminalModel terminal) async {
    emit(const TerminalState.loading());

    try {
      // Save terminal data securely
      await SharedPrefHelper.setSecuredString(
        SharedPrefKeys.terminalId,
        terminal.terminalId ?? '',
      );
      await SharedPrefHelper.setSecuredString(
        SharedPrefKeys.serialNumber,
        terminal.serialNumber ?? '',
      );
      await SharedPrefHelper.setSecuredString(
        SharedPrefKeys.locationId,
        terminal.locationId ?? '',
      );
      await SharedPrefHelper.setSecuredString(
        SharedPrefKeys.terminalIpAddress,
        terminal.ipAddress ?? '',
      );
      await SharedPrefHelper.setSecuredString(
        SharedPrefKeys.terminalLabel,
        terminal.label ?? '',
      );

      // Mark terminal as configured
      await SharedPrefHelper.setData(SharedPrefKeys.isTerminalConfigured, true);

      // Initialize SDK and connect to reader
      await _initializeAndConnectReader(terminal);
    } catch (e) {
      debugPrint('TerminalCubit: Error selecting terminal: $e');
      emit(
        TerminalState.error(
          ApiErrorModel(message: 'Failed to save terminal data: $e'),
        ),
      );
    }
  }

  /// Initialize Stripe Terminal SDK and connect to the reader
  Future<void> _initializeAndConnectReader(TerminalModel terminal) async {
    try {
      // Step 1: Initialize SDK
      emit(const TerminalState.sdkInitializing());
      await _stripeTerminalService.initializeTerminal();
      emit(const TerminalState.sdkInitialized());

      // Step 2: Connect to reader via WiFi/Internet
      emit(const TerminalState.readerConnecting());

      final locationId = terminal.locationId;
      if (locationId == null || locationId.isEmpty) {
        emit(
          const TerminalState.readerConnectionError(
            'Location ID is required for WiFi connection',
          ),
        );
        return;
      }

      final connectedReader = await _stripeTerminalService
          .discoverAndConnectReader(locationId: locationId, isSimulated: false);

      final readerLabel = connectedReader.label ?? connectedReader.serialNumber;
      emit(TerminalState.readerConnected(readerLabel));

      // Small delay then emit terminal selected to trigger navigation
      await Future.delayed(const Duration(milliseconds: 500));
      emit(const TerminalState.terminalSelected());
    } catch (e) {
      debugPrint('TerminalCubit: SDK/Reader error: $e');
      emit(
        TerminalState.readerConnectionError('Failed to connect to reader: $e'),
      );
    }
  }

  /// Check if reader is still connected
  Future<bool> isReaderConnected() async {
    final reader = await _stripeTerminalService.getConnectedReader();
    return reader != null;
  }

  /// Reconnect to saved terminal if disconnected
  Future<void> reconnectToSavedTerminal() async {
    try {
      final locationId = await SharedPrefHelper.getSecuredString(
        SharedPrefKeys.locationId,
      );

      if (locationId.isEmpty) {
        debugPrint('TerminalCubit: No saved location ID for reconnection');
        return;
      }

      emit(const TerminalState.readerConnecting());

      await _stripeTerminalService.discoverAndConnectReader(
        locationId: locationId,
        isSimulated: false,
      );

      final reader = await _stripeTerminalService.getConnectedReader();
      final readerLabel = reader?.label ?? reader?.serialNumber ?? 'Unknown';
      emit(TerminalState.readerConnected(readerLabel));
    } catch (e) {
      debugPrint('TerminalCubit: Reconnection failed: $e');
      emit(TerminalState.readerConnectionError('Reconnection failed: $e'));
    }
  }

  @override
  Future<void> close() {
    _discoverySubscription?.cancel();
    _stripeTerminalService.dispose();
    return super.close();
  }
}
