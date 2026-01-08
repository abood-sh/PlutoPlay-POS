import 'package:pos/core/networking/api_result.dart';
import 'package:pos/core/networking/api_service.dart';
import 'package:pos/features/home/data/models/add_rfid_request_model.dart';
import 'package:pos/features/home/data/models/add_custom_item_request.dart';
import 'package:pos/features/home/data/models/add_rfid_response_model.dart';
import 'package:pos/features/home/data/models/cart_model_response.dart';

import '../../../../core/networking/api_error_handler.dart';

class HomeRepo {
  final ApiService _apiService;

  HomeRepo(this._apiService);

  Future<ApiResult<CartResponseModel>> getCart() async {
    try {
      final response = await _apiService.getCart();
      return ApiResult.success(response);
    } catch (error) {
      return ApiResult.failure(ApiErrorHandler.handle(error));
    }
  }

  Future<ApiResult<AddRfidResponse>> addRfidToCart(
    AddRfidRequestModel addRfidRequestModel,
  ) async {
    try {
      final response = await _apiService.addRfidToCart(addRfidRequestModel);
      return ApiResult.success(response);
    } catch (error) {
      return ApiResult.failure(ApiErrorHandler.handle(error));
    }
  }

  Future<ApiResult<CartResponseModel>> deleteCartItem(String cartItemId) async {
    try {
      final path = '/cart/item/$cartItemId';
      final response = await _apiService.deleteCartItem(path);
      return ApiResult.success(response);
    } catch (error) {
      return ApiResult.failure(ApiErrorHandler.handle(error));
    }
  }

  Future<ApiResult<CartResponseModel>> addCustomItem(
    AddCustomItemRequest request,
  ) async {
    try {
      final response = await _apiService.addCustomItem(request);
      return ApiResult.success(response);
    } catch (error) {
      return ApiResult.failure(ApiErrorHandler.handle(error));
    }
  }
}
