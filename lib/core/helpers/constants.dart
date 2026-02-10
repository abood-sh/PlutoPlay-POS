bool isLoggedInUser = false;
bool isConnectedToInternet = false;

class SharedPrefKeys {
  static const String userToken = 'userToken';
  static const String discountPassword = 'discountPassword';
  static const themeKey = 'theme_mode';

  // Terminal keys
  static const String terminalId = 'terminalId';
  static const String serialNumber = 'serialNumber';
  static const String locationId = 'locationId';
  static const String terminalIpAddress = 'terminalIpAddress';
  static const String terminalLabel = 'terminalLabel';
  static const String isTerminalConfigured = 'isTerminalConfigured';

  // Device ID from login
  static const String deviceId = 'deviceId';
}
