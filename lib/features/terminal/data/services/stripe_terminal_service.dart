import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:mek_stripe_terminal/mek_stripe_terminal.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:pos/core/networking/api_service.dart';
import 'package:pos/features/terminal/data/services/internet_reader_delegate.dart';

/// Service for managing Stripe Terminal SDK operations
/// Handles initialization, reader connection, and payment collection
class StripeTerminalService {
  final ApiService _apiService;

  StripeTerminalService(this._apiService);

  bool _isInitialized = false;
  Reader? _connectedReader;
  PosInternetReaderDelegate? _readerDelegate;
  StreamSubscription<List<Reader>>? _discoverySubscription;
  CancelableFuture<PaymentIntent>? _currentCollectPaymentMethod;

  bool get isInitialized => _isInitialized;
  Reader? get connectedReader => _connectedReader;
  bool get isConnected => _connectedReader != null;

  /// Initialize the Stripe Terminal SDK
  /// Fetches connection token from backend and initializes the SDK
  Future<void> initializeTerminal() async {
    if (_isInitialized) {
      debugPrint('StripeTerminalService: Already initialized');
      return;
    }

    try {
      await Terminal.initTerminal(
        fetchToken: _fetchConnectionToken,
        shouldPrintLogs: kDebugMode,
      );
      _isInitialized = true;
      debugPrint('StripeTerminalService: SDK initialized successfully');

      // Configure simulated card for testing (only affects simulated readers)
      if (kDebugMode) {
        // Available test cards:
        // ✅ Success: SimulatedCard.visa(), .mastercard(), .amex(), .discover()
        // ❌ Declined: SimulatedCard.chargeDeclined()
        // ❌ Insufficient Funds: SimulatedCard.chargeDeclinedInsufficientFunds()
        // ❌ Lost Card: SimulatedCard.chargeDeclinedLostCard()
        // ❌ Stolen Card: SimulatedCard.chargeDeclinedStolenCard()
        // ❌ Expired Card: SimulatedCard.chargeDeclinedExpiredCard()
        // ❌ Processing Error: SimulatedCard.chargeDeclinedProcessingError()

        await Terminal.instance.setSimulatorConfiguration(
          const SimulatorConfiguration(
            simulatedCard: SimulatedCard.fromType(SimulatedCardType.visa),
          ),
        );
        debugPrint('StripeTerminalService: Simulated card configured (Visa)');
      }
    } catch (e) {
      debugPrint('StripeTerminalService: Failed to initialize SDK: $e');
      rethrow;
    }
  }

  /// Fetch connection token from backend
  Future<String> _fetchConnectionToken() async {
    try {
      final response = await _apiService.getConnectionToken();
      if (response.secret != null && response.secret!.isNotEmpty) {
        debugPrint('StripeTerminalService: Connection token fetched');
        return response.secret!;
      }
      throw Exception('Connection token is empty');
    } catch (e) {
      debugPrint('StripeTerminalService: Failed to fetch connection token: $e');
      rethrow;
    }
  }

  /// Discover and connect to an internet reader
  /// Uses WiFi connection via InternetDiscoveryConfiguration
  Future<Reader> discoverAndConnectReader({
    required String locationId,
    bool isSimulated = false,
    Duration timeout = const Duration(seconds: 30),
  }) async {
    if (!_isInitialized) {
      await initializeTerminal();
    }

    debugPrint(
      'StripeTerminalService: Discovering readers at location: $locationId',
    );

    final completer = Completer<Reader>();

    try {
      // Create discovery configuration for internet readers
      final discoveryConfig = InternetDiscoveryConfiguration(
        isSimulated: isSimulated,
        locationId: locationId,
        timeout: timeout,
      );

      // Start discovery
      final discoveryStream = Terminal.instance.discoverReaders(
        discoveryConfig,
      );

      _discoverySubscription = discoveryStream.listen(
        (readers) async {
          debugPrint(
            'StripeTerminalService: Found ${readers.length} reader(s)',
          );

          if (readers.isNotEmpty) {
            await _discoverySubscription?.cancel();

            // Connect to the first available reader
            final reader = readers.first;
            try {
              final connectedReader = await _connectToReader(reader);
              if (!completer.isCompleted) {
                completer.complete(connectedReader);
              }
            } catch (e) {
              if (!completer.isCompleted) {
                completer.completeError(e);
              }
            }
          }
        },
        onError: (error) {
          debugPrint('StripeTerminalService: Discovery error: $error');
          if (!completer.isCompleted) {
            completer.completeError(error);
          }
        },
        onDone: () {
          debugPrint('StripeTerminalService: Discovery completed');
          if (!completer.isCompleted) {
            completer.completeError(Exception('No readers found'));
          }
        },
      );

      return await completer.future;
    } catch (e) {
      await _discoverySubscription?.cancel();
      debugPrint('StripeTerminalService: Failed to discover readers: $e');
      rethrow;
    }
  }

  /// Discover available readers without connecting
  /// Returns a stream of discovered readers
  Stream<List<Reader>> discoverReaders({
    required String locationId,
    bool isSimulated = false,
  }) async* {
    if (!_isInitialized) {
      await initializeTerminal();
    }

    debugPrint(
      'StripeTerminalService: Starting reader discovery at location: $locationId, simulated: $isSimulated',
    );

    // Note: Don't pass timeout - causes Integer/Long cast bug in plugin
    final discoveryConfig = InternetDiscoveryConfiguration(
      isSimulated: isSimulated,
      locationId: locationId,
    );

    yield* Terminal.instance.discoverReaders(discoveryConfig);
  }

  /// Stop ongoing reader discovery
  Future<void> stopDiscovery() async {
    await _discoverySubscription?.cancel();
    _discoverySubscription = null;
    debugPrint('StripeTerminalService: Discovery stopped');
  }

  /// Connect to a specific reader (public method)
  Future<Reader> connectToReader(Reader reader) async {
    if (!_isInitialized) {
      await initializeTerminal();
    }
    return await _connectToReader(reader);
  }

  /// Connect to a specific reader using Internet configuration
  Future<Reader> _connectToReader(Reader reader) async {
    debugPrint(
      'StripeTerminalService: Connecting to reader: ${reader.label ?? reader.serialNumber}',
    );

    _readerDelegate = PosInternetReaderDelegate(
      onLog: (message) => debugPrint('ReaderDelegate: $message'),
      onDisconnected: () {
        _connectedReader = null;
        debugPrint('StripeTerminalService: Reader disconnected');
      },
    );

    final connectionConfig = InternetConnectionConfiguration(
      failIfInUse: true,
      allowCustomerCancel: true,
      readerDelegate: _readerDelegate,
    );

    final connectedReader = await Terminal.instance.connectReader(
      reader,
      configuration: connectionConfig,
    );

    _connectedReader = connectedReader;
    debugPrint(
      'StripeTerminalService: Connected to reader: ${connectedReader.label ?? connectedReader.serialNumber}',
    );

    return connectedReader;
  }

  /// Get the currently connected reader (checks with SDK)
  Future<Reader?> getConnectedReader() async {
    if (!_isInitialized) return null;
    _connectedReader = await Terminal.instance.getConnectedReader();
    return _connectedReader;
  }

  /// Disconnect from the current reader
  Future<void> disconnectReader() async {
    if (!_isInitialized || _connectedReader == null) return;

    try {
      await Terminal.instance.disconnectReader();
      _connectedReader = null;
      debugPrint('StripeTerminalService: Disconnected from reader');
    } catch (e) {
      debugPrint('StripeTerminalService: Failed to disconnect: $e');
      rethrow;
    }
  }

  /// Collect payment method from the connected reader
  /// This is Step 2 of the 3-step payment flow
  /// Returns the PaymentIntent with payment method attached
  Future<PaymentIntent> collectPaymentMethod({
    required String clientSecret,
  }) async {
    if (!_isInitialized) {
      throw Exception('Terminal SDK not initialized');
    }

    // Request location permissions (required by Stripe Terminal SDK)
    await _requestLocationPermissions();

    final connectedReader = await getConnectedReader();
    if (connectedReader == null) {
      throw Exception('No reader connected. Please connect a reader first.');
    }

    debugPrint('StripeTerminalService: Collecting payment method...');

    try {
      return await _doCollectPaymentMethod(clientSecret);
    } on TerminalException catch (e) {
      _currentCollectPaymentMethod = null;

      // Handle specific terminal errors with user-friendly messages
      if (e.code == TerminalExceptionCode.sessionExpired) {
        debugPrint('StripeTerminalService: Session expired');
        throw Exception(
          'Payment session expired. Please go back and try again.',
        );
      }

      if (e.code == TerminalExceptionCode.notConnectedToReader) {
        debugPrint('StripeTerminalService: No reader connected');
        throw Exception(
          'Reader disconnected. Please reconnect to a reader and try again.',
        );
      }

      debugPrint(
        'StripeTerminalService: Terminal error: ${e.code} - ${e.message}',
      );
      rethrow;
    } catch (e) {
      _currentCollectPaymentMethod = null;
      debugPrint('StripeTerminalService: Failed to collect payment: $e');
      rethrow;
    }
  }

  /// Internal method to collect payment (can be retried)
  Future<PaymentIntent> _doCollectPaymentMethod(String clientSecret) async {
    // First, retrieve the payment intent from Stripe
    final paymentIntent = await Terminal.instance.retrievePaymentIntent(
      clientSecret,
    );

    debugPrint(
      'StripeTerminalService: Payment intent retrieved: ${paymentIntent.id}',
    );

    // Collect the payment method from the reader (returns CancelableFuture)
    _currentCollectPaymentMethod = Terminal.instance.collectPaymentMethod(
      paymentIntent,
      skipTipping: true,
    );

    final processablePaymentIntent = await _currentCollectPaymentMethod!;
    _currentCollectPaymentMethod = null;

    debugPrint(
      'StripeTerminalService: Payment method collected: ${processablePaymentIntent.id}',
    );

    // Confirm the payment intent (this processes the payment on Stripe)
    final confirmFuture = Terminal.instance.confirmPaymentIntent(
      processablePaymentIntent,
    );
    final confirmedPaymentIntent = await confirmFuture;

    debugPrint(
      'StripeTerminalService: Payment intent confirmed: ${confirmedPaymentIntent.id}, status: ${confirmedPaymentIntent.status}',
    );

    return confirmedPaymentIntent;
  }

  /// Cancel the current payment collection
  Future<void> cancelCollectPaymentMethod() async {
    if (_currentCollectPaymentMethod != null) {
      try {
        await _currentCollectPaymentMethod!.cancel();
        debugPrint('StripeTerminalService: Payment collection cancelled');
      } catch (e) {
        debugPrint(
          'StripeTerminalService: Failed to cancel payment collection: $e',
        );
        // Don't rethrow - cancellation failures are not critical
      } finally {
        _currentCollectPaymentMethod = null;
      }
    }
  }

  /// Request location permissions required by Stripe Terminal SDK
  Future<void> _requestLocationPermissions() async {
    // Check and request location permission
    var locationStatus = await Permission.locationWhenInUse.status;

    if (locationStatus.isDenied) {
      debugPrint('StripeTerminalService: Requesting location permission...');
      locationStatus = await Permission.locationWhenInUse.request();
    }

    if (locationStatus.isPermanentlyDenied) {
      debugPrint(
        'StripeTerminalService: Location permission permanently denied',
      );
      throw Exception(
        'Location permission is required for card payments. Please enable it in app settings.',
      );
    }

    if (!locationStatus.isGranted) {
      debugPrint('StripeTerminalService: Location permission not granted');
      throw Exception(
        'Location permission is required to process card payments.',
      );
    }

    debugPrint('StripeTerminalService: Location permission granted');
  }

  /// Dispose of resources
  void dispose() {
    _discoverySubscription?.cancel();
  }
}
