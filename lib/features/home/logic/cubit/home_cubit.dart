import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pos/core/networking/api_service.dart';
import 'package:pos/core/networking/api_result.dart';
import 'package:pos/features/home/data/models/add_rfid_request_model.dart';
import 'package:pos/features/home/data/models/cart_model_response.dart';
import 'package:pos/features/home/data/repos/home_repos.dart';
import 'package:pos/features/home/logic/cubit/home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final HomeRepo _homeRepo;

  HomeCubit(this._homeRepo) : super(const HomeState.initial());

  void getCart() async {
    emit(const HomeState.getCartLoading());
    final response = await _homeRepo.getCart();

    response.when(
      success: (getCartResponse) async {
        emit(HomeState.getCartSuccess([getCartResponse.data]));
      },
      failure: (apiErrorModel) {
        emit(HomeState.getCartError(apiErrorModel));
      },
    );
  }

  Future<void> addRfidToCart(String tagId) async {
    final response = await _homeRepo.addRfidToCart(
      AddRfidRequestModel(tagId: tagId),
    );

    response.when(
      success: (addRfidToCartResponse) async {
        emit(HomeState.getCartSuccess([addRfidToCartResponse.data]));
      },
      failure: (apiErrorModel) {
        emit(HomeState.addRfidToCartError(apiErrorModel));
      },
    );
  }

  Future<void> deleteCartItem(String cartItemId) async {
    emit(const HomeState.deleteCartItemLoading());
    final response = await _homeRepo.deleteCartItem(cartItemId);

    response.when(
      success: (deleteCartItemResponse) async {
        emit(HomeState.deleteCartItemSuccess([deleteCartItemResponse.data]));
      },
      failure: (apiErrorModel) {
        emit(HomeState.deleteCartItemError(apiErrorModel));
      },
    );
  }
}
