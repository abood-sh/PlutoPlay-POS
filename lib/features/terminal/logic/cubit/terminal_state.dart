import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:mek_stripe_terminal/mek_stripe_terminal.dart';
import 'package:pos/core/networking/api_error_model.dart';

part 'terminal_state.freezed.dart';

@freezed
class TerminalState<T> with _$TerminalState<T> {
  const factory TerminalState.initial() = _Initial;
  const factory TerminalState.loading() = Loading;
  const factory TerminalState.success(T data) = Success<T>;
  const factory TerminalState.terminalSelected() = TerminalSelected;
  const factory TerminalState.error(ApiErrorModel apiErrorModel) = Error;

  // SDK initialization states
  const factory TerminalState.sdkInitializing() = SdkInitializing;
  const factory TerminalState.sdkInitialized() = SdkInitialized;
  const factory TerminalState.sdkError(String message) = SdkError;

  // Reader discovery states (SDK)
  const factory TerminalState.discoveringReaders() = DiscoveringReaders;
  const factory TerminalState.readersDiscovered(List<Reader> readers) =
      ReadersDiscovered;
  const factory TerminalState.noReadersFound() = NoReadersFound;

  // Reader connection states
  const factory TerminalState.readerConnecting() = ReaderConnecting;
  const factory TerminalState.readerConnected(String readerLabel) =
      ReaderConnected;
  const factory TerminalState.readerConnectionError(String message) =
      ReaderConnectionError;
}
