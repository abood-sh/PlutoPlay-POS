import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:pos/core/networking/api_error_model.dart';
import 'package:pos/features/checkout/data/models/process_payment_response.dart';
import 'package:pos/features/checkout/data/models/system_settings_response.dart';
import 'package:pos/features/home/data/models/cart_model_response.dart';

part 'checkout_state.freezed.dart';

@freezed
class CheckoutState with _$CheckoutState {
  const factory CheckoutState.initial() = _Initial;
  const factory CheckoutState.loaded(CartData cartData) = CheckoutLoaded;
  const factory CheckoutState.processing() = CheckoutProcessing;
  const factory CheckoutState.success() = CheckoutSuccess;
  const factory CheckoutState.error(String message) = CheckoutError;

  // System Settings states
  const factory CheckoutState.settingsLoading() = SettingsLoading;
  const factory CheckoutState.settingsLoaded(DiscountSettingsSystem settings) =
      SettingsLoaded;
  const factory CheckoutState.settingsError(ApiErrorModel error) =
      SettingsError;

  // Discount states
  const factory CheckoutState.discountApplying() = DiscountApplying;
  const factory CheckoutState.discountApplied(CartData cartData) =
      DiscountApplied;
  const factory CheckoutState.discountError(ApiErrorModel error) =
      DiscountError;

  // Password validation
  const factory CheckoutState.passwordRequired(
    DiscountSettingsSystem settings,
  ) = PasswordRequired;
  const factory CheckoutState.passwordValid() = PasswordValid;
  const factory CheckoutState.passwordInvalid() = PasswordInvalid;

  // Payment states
  const factory CheckoutState.paymentProcessing() = PaymentProcessing;
  const factory CheckoutState.paymentSuccess(PaymentResponseData data) =
      PaymentSuccess;
  const factory CheckoutState.paymentError(ApiErrorModel error) = PaymentError;

  // Terminal payment states
  const factory CheckoutState.terminalPaymentProcessing() =
      TerminalPaymentProcessing;
  const factory CheckoutState.terminalPaymentSuccess(
    ProcessPaymentResponse response,
  ) = TerminalPaymentSuccess;
  const factory CheckoutState.terminalPaymentError(
    ProcessPaymentResponse response,
  ) = TerminalPaymentError;
  const factory CheckoutState.terminalPaymentTimeout(
    ProcessPaymentResponse response,
  ) = TerminalPaymentTimeout;

  // Stripe Terminal 3-step card payment states
  const factory CheckoutState.cardPaymentCreatingIntent() =
      CardPaymentCreatingIntent;
  const factory CheckoutState.cardPaymentCollecting() = CardPaymentCollecting;
  const factory CheckoutState.cardPaymentConfirming() = CardPaymentConfirming;
  const factory CheckoutState.cardPaymentSuccess(PaymentResponseData data) =
      CardPaymentSuccess;
  const factory CheckoutState.cardPaymentError(String message) =
      CardPaymentError;
  const factory CheckoutState.cardPaymentCancelled() = CardPaymentCancelled;

  // Split Payment states (Card via SDK + Cash)
  const factory CheckoutState.splitPaymentCardSuccess({
    required num cardAmount,
    required num cashAmount,
    required String paymentIntentId,
  }) = SplitPaymentCardSuccess;
  const factory CheckoutState.splitPaymentComplete(PaymentResponseData data) =
      SplitPaymentComplete;
}
