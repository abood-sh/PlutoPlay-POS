import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:pos/core/networking/api_error_model.dart';
import 'package:pos/features/home/data/models/cart_model_response.dart';

part 'home_state.freezed.dart';

@freezed
class HomeState with _$HomeState {
  const factory HomeState.initial() = _Initial;

  // Cart
  const factory HomeState.getCartLoading() = GetCartLoading;
  const factory HomeState.getCartSuccess(List<CartData?>? getCartData) =
      GetCartSuccess;
  const factory HomeState.getCartError(ApiErrorModel apiErrorModel) =
      GetCartError;
  const factory HomeState.addRfidToCartError(ApiErrorModel apiErrorModel) =
      AddRfidToCartError;

  // Delete Cart Item
  const factory HomeState.deleteCartItemLoading() = DeleteCartItemLoading;
  const factory HomeState.deleteCartItemSuccess(List<CartData?>? getCartData) =
      DeleteCartItemSuccess;
  const factory HomeState.deleteCartItemError(ApiErrorModel apiErrorModel) =
      DeleteCartItemError;

  // Doctors
  // const factory HomeState.doctorsSuccess(List<Doctors?>? doctorsList) =
  //     DoctorsSuccess;
  // const factory HomeState.doctorsError() = DoctorsError;
}
