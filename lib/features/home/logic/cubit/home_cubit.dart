import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pos/core/networking/api_result.dart';
import 'package:pos/features/home/data/models/add_rfid_request_model.dart';
import 'package:pos/features/home/data/models/add_custom_item_request.dart';
import 'package:pos/features/home/data/repos/home_repos.dart';
import 'package:pos/features/home/logic/cubit/home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final HomeRepo _homeRepo;

  // Track scanner mode (true = RFID scanner, false = manual keyboard entry)
  bool isScannerMode = true;

  HomeCubit(this._homeRepo) : super(const HomeState.initial());

  void setScannerMode(bool value) {
    isScannerMode = value;
  }

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
        emit(HomeState.addRfidToCartSuccess([addRfidToCartResponse.data]));
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

  Future<void> addCustomItem({
    required String name,
    required num price,
    required int quantity,
    String? barcode,
    String? description,
  }) async {
    emit(const HomeState.addCustomItemLoading());

    // Generate random barcode if not provided
    final finalBarcode = barcode?.isNotEmpty == true
        ? barcode
        : 'CUSTOM-${DateTime.now().millisecondsSinceEpoch}';

    final request = AddCustomItemRequest(
      name: name,
      price: price,
      quantity: quantity,
      barcode: finalBarcode,
      description: description,
    );

    final response = await _homeRepo.addCustomItem(request);

    response.when(
      success: (cartResponse) async {
        emit(HomeState.addCustomItemSuccess([cartResponse.data]));
      },
      failure: (apiErrorModel) {
        emit(HomeState.addCustomItemError(apiErrorModel));
      },
    );
  }
}
