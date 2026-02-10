import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

import 'api_error_model.dart';

class ApiErrorHandler {
  static ApiErrorModel handle(dynamic error) {
    // Log the error for debugging
    debugPrint('API Error: $error');
    debugPrint('Error type: ${error.runtimeType}');

    if (error is DioException) {
      switch (error.type) {
        case DioExceptionType.connectionError:
          return ApiErrorModel(message: "Connection to server failed");
        case DioExceptionType.cancel:
          return ApiErrorModel(message: "Request to the server was cancelled");
        case DioExceptionType.connectionTimeout:
          return ApiErrorModel(message: "Connection timeout with the server");
        case DioExceptionType.unknown:
          return ApiErrorModel(
            message:
                "Connection to the server failed due to internet connection",
          );
        case DioExceptionType.receiveTimeout:
          return ApiErrorModel(
            message: "Receive timeout in connection with the server",
          );
        case DioExceptionType.badResponse:
          return _handleError(error.response?.data);
        case DioExceptionType.sendTimeout:
          return ApiErrorModel(
            message: "Send timeout in connection with the server",
          );
        default:
          return ApiErrorModel(message: "Something went wrong");
      }
    } else {
      // Print the actual error message for debugging
      debugPrint('Non-Dio Error: ${error.toString()}');
      return ApiErrorModel(message: error.toString());
    }
  }
}

ApiErrorModel _handleError(dynamic data) {
  return ApiErrorModel(
    success: data['success'] ?? false,
    message: data['message'] ?? "Unknown error occurred",
  );
}

// StripeErrors _handleStripeError(dynamic data) {
//   return StripeErrors(
//     message: data['message'] ?? "Unknown error occurred",
//     type: data['type'] ?? "Unknown type",
//   );
// }
