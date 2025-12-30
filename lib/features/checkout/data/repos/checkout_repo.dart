import 'package:pos/core/networking/api_error_handler.dart';
import 'package:pos/core/networking/api_result.dart';
import 'package:pos/core/networking/api_service.dart';
import 'package:pos/features/checkout/data/models/apply_discount_request.dart';
import 'package:pos/features/checkout/data/models/apply_discount_response.dart';
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
}
