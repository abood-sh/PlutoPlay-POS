import 'package:dio/dio.dart';
import 'package:pos/core/networking/api_constanta.dart';
import 'package:pos/core/networking/api_error_handler.dart';
import 'package:pos/core/networking/api_result.dart';
import 'package:pos/core/networking/api_service.dart';
import 'package:pos/core/networking/dio_factory.dart';
import 'package:pos/features/checkout/data/models/apply_discount_request.dart';
import 'package:pos/features/checkout/data/models/apply_discount_response.dart';
import 'package:pos/features/checkout/data/models/process_payment_request.dart';
import 'package:pos/features/checkout/data/models/process_payment_response.dart';
import 'package:pos/features/checkout/data/models/stripe_payment_intent_models.dart';
import 'package:pos/features/checkout/data/models/system_settings_response.dart';

class CheckoutRepo {
  final ApiService _apiService;

  CheckoutRepo(this._apiService);

  Future<ApiResult<SystemSettingsResponse>> getSystemSettings() async {
    try {
      final response = await _apiService.getSystemSettings();
      return ApiResult.success(response);
    } catch (error) {
      return ApiResult.failure(ApiErrorHandler.handle(error));
    }
  }

  Future<ApiResult<ApplyDiscountResponse>> applyDiscount(
    ApplyDiscountRequest request,
  ) async {
    try {
      final response = await _apiService.applyDiscount(request);
      return ApiResult.success(response);
    } catch (error) {
      return ApiResult.failure(ApiErrorHandler.handle(error));
    }
  }

  // Future<ApiResult<ProcessPaymentResponse>> processPayment(
  //   ProcessPaymentRequest request,
  // ) async {
  //   try {
  //     final response = await _apiService.processPayment(request);
  //     return ApiResult.success(response);
  //   } catch (error) {
  //     return ApiResult.failure(ApiErrorHandler.handle(error));
  //   }
  // }

  // Future<ApiResult<ProcessPaymentResponse>> processSplitPayment(
  //   ProcessSplitPaymentRequest request,
  // ) async {
  //   try {
  //     final response = await _apiService.processSplitPayment(request);
  //     return ApiResult.success(response);
  //   } catch (error) {
  //     return ApiResult.failure(ApiErrorHandler.handle(error));
  //   }
  // }

  /// Process payment through terminal with extended timeout (5 minutes)
  /// Supports cash, card, and split payments
  Future<ApiResult<ProcessPaymentResponse>> processTerminalPayment(
    ProcessTerminalPaymentRequest request,
  ) async {
    try {
      // Use terminal Dio with extended timeout for card payments
      final terminalDio = DioFactory.getTerminalDio();

      final response = await terminalDio.post(
        '${ApiConstanta.apiBaseUrl}${ApiConstanta.paymentTerminal}',
        data: request.toJson(),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final paymentResponse = ProcessPaymentResponse.fromJson(response.data);
        return ApiResult.success(paymentResponse);
      } else {
        // Handle non-success status codes
        final paymentResponse = ProcessPaymentResponse.fromJson(response.data);
        return ApiResult.success(paymentResponse);
      }
    } on DioException catch (error) {
      // Check if response has data (API returned error with body)
      if (error.response?.data != null) {
        try {
          final paymentResponse = ProcessPaymentResponse.fromJson(
            error.response!.data as Map<String, dynamic>,
          );
          // Return as success so we can handle the error response in cubit
          return ApiResult.success(paymentResponse);
        } catch (_) {
          return ApiResult.failure(ApiErrorHandler.handle(error));
        }
      }
      return ApiResult.failure(ApiErrorHandler.handle(error));
    } catch (error) {
      return ApiResult.failure(ApiErrorHandler.handle(error));
    }
  }

  /// Create a payment intent for Stripe Terminal
  /// Step 1 of 3-step card payment flow
  Future<ApiResult<CreatePaymentIntentResponse>> createPaymentIntent(
    CreatePaymentIntentRequest request,
  ) async {
    try {
      final response = await _apiService.createPaymentIntent(request);
      return ApiResult.success(response);
    } catch (error) {
      return ApiResult.failure(ApiErrorHandler.handle(error));
    }
  }

  /// Confirm payment with backend after SDK collection
  /// Step 3 of 3-step card payment flow
  Future<ApiResult<ConfirmStripePaymentResponse>> confirmStripePayment(
    ConfirmStripePaymentRequest request,
  ) async {
    try {
      final response = await _apiService.confirmStripePayment(request);
      return ApiResult.success(response);
    } catch (error) {
      return ApiResult.failure(ApiErrorHandler.handle(error));
    }
  }
}
