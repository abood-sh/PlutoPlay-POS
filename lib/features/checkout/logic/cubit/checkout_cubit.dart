import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pos/core/helpers/constants.dart';
import 'package:pos/core/helpers/shared_pref_helper.dart';
import 'package:pos/core/networking/api_result.dart';
import 'package:pos/features/checkout/data/models/apply_discount_request.dart';
import 'package:pos/features/checkout/data/models/system_settings_response.dart';
import 'package:pos/features/checkout/data/repos/checkout_repo.dart';
import 'package:pos/features/checkout/logic/cubit/checkout_state.dart';
import 'package:pos/features/home/data/models/cart_model_response.dart';

class CheckoutCubit extends Cubit<CheckoutState> {
  final CheckoutRepo _checkoutRepo;

  CheckoutCubit(this._checkoutRepo) : super(const CheckoutState.initial());

  CartData? _cartData;
  DiscountSettingsSystem? _discountSettings;

  CartData? get cartData => _cartData;
  DiscountSettingsSystem? get discountSettings => _discountSettings;

  void setCartData(CartData cartData) {
    _cartData = cartData;
    emit(CheckoutState.loaded(cartData));
  }

  // Calculate subtotal from items
  num get subtotal => _cartData?.subtotal ?? 0;

  // Calculate tax
  num get taxAmount => _cartData?.taxAmount ?? 0;

  // Calculate discount
  num get discountAmount => _cartData?.discountAmount ?? 0;

  // Calculate total
  num get total => _cartData?.total ?? 0;

  // Get items count
  int get itemsCount => _cartData?.itemsCount ?? _cartData?.items?.length ?? 0;

  // Get cart items
  List<CartItemModel> get items => _cartData?.items ?? [];

  // Get system settings to check discount password
  Future<void> getSystemSettings() async {
    emit(const CheckoutState.settingsLoading());

    final result = await _checkoutRepo.getSystemSettings();

    result.when(
      success: (response) async {
        _discountSettings = response.data?.discount;
        if (_discountSettings != null) {
          // Save discount password to SharedPreferences
          await _saveDiscountPassword(_discountSettings!.discountPassword);
          emit(CheckoutState.settingsLoaded(_discountSettings!));
        }
      },
      failure: (error) {
        emit(CheckoutState.settingsError(error));
      },
    );
  }

  // Save discount password to SharedPreferences
  Future<void> _saveDiscountPassword(String? password) async {
    if (password != null && password.isNotEmpty) {
      await SharedPrefHelper.setSecuredString(
        SharedPrefKeys.discountPassword,
        password,
      );
    }
  }

  // Check if password is required and validate
  Future<void> requestDiscountWithPassword() async {
    emit(const CheckoutState.settingsLoading());

    // First get system settings to check password
    final result = await _checkoutRepo.getSystemSettings();

    result.when(
      success: (response) async {
        _discountSettings = response.data?.discount;
        if (_discountSettings != null) {
          // Save discount password to SharedPreferences
          await _saveDiscountPassword(_discountSettings!.discountPassword);
          // Emit password required state with settings
          emit(CheckoutState.passwordRequired(_discountSettings!));
        }
      },
      failure: (error) {
        emit(CheckoutState.settingsError(error));
      },
    );
  }

  // Validate entered password against saved password in SharedPreferences
  Future<bool> validatePassword(String enteredPassword) async {
    // Get saved password from SharedPreferences
    final savedPassword = await SharedPrefHelper.getSecuredString(
      SharedPrefKeys.discountPassword,
    );

    if (savedPassword.isEmpty) {
      // No password required
      return true;
    }
    return enteredPassword == savedPassword;
  }

  // Apply discount after password validation
  Future<void> applyDiscount(num discountValue) async {
    emit(const CheckoutState.discountApplying());

    final request = ApplyDiscountRequest(
      type: 'percentage',
      value: discountValue,
    );

    final result = await _checkoutRepo.applyDiscount(request);

    result.when(
      success: (response) {
        if (response.data != null) {
          _cartData = response.data;
          emit(CheckoutState.discountApplied(_cartData!));
        }
      },
      failure: (error) {
        emit(CheckoutState.discountError(error));
      },
    );
  }

  // Re-emit loaded state to refresh UI
  void refreshLoadedState() {
    if (_cartData != null) {
      emit(CheckoutState.loaded(_cartData!));
    }
  }
}
