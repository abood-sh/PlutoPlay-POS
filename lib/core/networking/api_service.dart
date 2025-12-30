import 'package:dio/dio.dart';
import 'package:pos/core/networking/api_constanta.dart';
import 'package:pos/features/checkout/data/models/apply_discount_request.dart';
import 'package:pos/features/checkout/data/models/apply_discount_response.dart';
import 'package:pos/features/checkout/data/models/system_settings_response.dart';
import 'package:pos/features/home/data/models/add_rfid_request_model.dart';
import 'package:pos/features/login/data/models/login_req_body.dart';
import 'package:retrofit/retrofit.dart';

import '../../features/login/data/models/login_res_body.dart';
import '../../features/home/data/models/cart_model_response.dart';
import '../../features/home/data/models/add_rfid_response_model.dart';

part 'api_service.g.dart';

@RestApi(baseUrl: ApiConstanta.apiBaseUrl)
abstract class ApiService {
  factory ApiService(Dio dio, {String baseUrl}) = _ApiService;

  @POST(ApiConstanta.login)
  Future<LoginResponse> login(@Body() LoginRequestBody loginRequestBody);

  @GET(ApiConstanta.cart)
  Future<CartResponseModel> getCart();

  @POST(ApiConstanta.addRFid)
  Future<AddRfidResponse> addRfidToCart(
    @Body() AddRfidRequestModel addRFidRequestModel,
  );

  @GET(ApiConstanta.systemsSettings)
  Future<SystemSettingsResponse> getSystemSettings();

  @POST(ApiConstanta.applyDiscount)
  Future<ApplyDiscountResponse> applyDiscount(
    @Body() ApplyDiscountRequest applyDiscountRequest,
  );

  @DELETE('{path}')
  Future<CartResponseModel> deleteCartItem(@Path('path') String path);
}
