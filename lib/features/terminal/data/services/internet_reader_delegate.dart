import 'package:mek_stripe_terminal/mek_stripe_terminal.dart';

/// Internet Reader Delegate for handling WiFi-connected reader events
class PosInternetReaderDelegate extends InternetReaderDelegate {
  final Function(String)? onLog;
  final Function()? onDisconnected;

  PosInternetReaderDelegate({this.onLog, this.onDisconnected});

  @override
  void onDisconnect(DisconnectReason reason) {
    onLog?.call('Reader disconnected: ${reason.name}');
    onDisconnected?.call();
  }
}
