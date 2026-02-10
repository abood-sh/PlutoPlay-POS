import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import '../helpers/constants.dart';
import '../helpers/shared_pref_helper.dart';

class DioFactory {
  /// private constructor as I don't want to allow creating an instance of this class
  DioFactory._();

  static Dio? dio;
  static Dio? _terminalDio;

  static Dio getDio() {
    Duration timeOut = const Duration(seconds: 30);

    if (dio == null) {
      dio = Dio();
      dio!
        ..options.connectTimeout = timeOut
        ..options.receiveTimeout = timeOut;
      addDioHeaders();
      addDioInterceptor();
      return dio!;
    } else {
      return dio!;
    }
  }

  /// Get Dio instance with extended timeout for terminal payment operations
  /// Terminal card payments can take up to 5 minutes while waiting for customer
  static Dio getTerminalDio() {
    const Duration terminalTimeout = Duration(minutes: 5);

    if (_terminalDio == null) {
      _terminalDio = Dio();
      _terminalDio!
        ..options.connectTimeout = const Duration(seconds: 30)
        ..options.receiveTimeout = terminalTimeout
        ..options.sendTimeout = const Duration(seconds: 30);
      _terminalDio!.options.headers = {'Accept': 'application/json'};
      _addTerminalDioInterceptor();
      return _terminalDio!;
    } else {
      return _terminalDio!;
    }
  }

  static void _addTerminalDioInterceptor() {
    // Add interceptor to dynamically add auth token and device ID for each request
    _terminalDio?.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          final token = await SharedPrefHelper.getSecuredString(
            SharedPrefKeys.userToken,
          );
          final deviceId = await SharedPrefHelper.getSecuredString(
            SharedPrefKeys.deviceId,
          );
          if (token.isNotEmpty) {
            options.headers['Authorization'] = 'Bearer $token';
          }
          if (deviceId.isNotEmpty) {
            options.headers['X-Device-Id'] = deviceId;
          }
          handler.next(options);
        },
      ),
    );
    _terminalDio?.interceptors.add(
      PrettyDioLogger(
        requestBody: true,
        requestHeader: true,
        responseHeader: true,
      ),
    );
  }

  /// Update terminal Dio token after login
  static void setTerminalToken(String token) {
    _terminalDio?.options.headers['Authorization'] = 'Bearer $token';
  }

  static void addDioHeaders() async {
    final token = await SharedPrefHelper.getSecuredString(
      SharedPrefKeys.userToken,
    );
    final deviceId = await SharedPrefHelper.getSecuredString(
      SharedPrefKeys.deviceId,
    );

    dio?.options.headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
      if (deviceId.isNotEmpty) 'X-Device-Id': deviceId,
    };
  }

  static void setTokenIntoHeaderAfterLogin(String token, {String? deviceId}) {
    dio?.options.headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
      if (deviceId != null && deviceId.isNotEmpty) 'X-Device-Id': deviceId,
    };
  }

  /// Update headers with device ID after it's saved
  static void setDeviceIdIntoHeader(String deviceId) {
    if (deviceId.isNotEmpty) {
      dio?.options.headers['X-Device-Id'] = deviceId;
    }
  }

  static void removeTokenFromHeader() {
    dio?.options.headers.remove('Authorization');
  }

  static void addDioInterceptor() {
    dio?.interceptors.add(
      PrettyDioLogger(
        requestBody: true,
        requestHeader: true,
        responseHeader: true,
      ),
    );
  }
}
