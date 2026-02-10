import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mek_stripe_terminal/mek_stripe_terminal.dart';
import 'package:pos/core/helpers/constants.dart';
import 'package:pos/core/helpers/shared_pref_helper.dart';
import 'package:pos/core/networking/api_result.dart';
import 'package:pos/features/checkout/data/models/apply_discount_request.dart';
import 'package:pos/features/checkout/data/models/process_payment_request.dart';
import 'package:pos/features/checkout/data/models/process_payment_response.dart';
import 'package:pos/features/checkout/data/models/stripe_payment_intent_models.dart';
import 'package:pos/features/checkout/data/models/system_settings_response.dart';
import 'package:pos/features/checkout/data/repos/checkout_repo.dart';
import 'package:pos/features/checkout/logic/cubit/checkout_state.dart';
import 'package:pos/features/home/data/models/cart_model_response.dart';
import 'package:pos/features/terminal/data/services/stripe_terminal_service.dart';

class CheckoutCubit extends Cubit<CheckoutState> {
  final CheckoutRepo _checkoutRepo;
  final StripeTerminalService _stripeTerminalService;

  CheckoutCubit(this._checkoutRepo, this._stripeTerminalService)
    : super(const CheckoutState.initial());

  CartData? _cartData;
  DiscountSettingsSystem? _discountSettings;
  bool _isCollectingPayment = false;

  CartData? get cartData => _cartData;
  DiscountSettingsSystem? get discountSettings => _discountSettings;
  bool get isCollectingPayment => _isCollectingPayment;

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

  // Process single payment (Cash or Card)
  // Future<void> processPayment({
  //   required String paymentMethod,
  //   String? referenceNumber,
  //   num? cashAmount,
  // }) async {
  //   emit(const CheckoutState.paymentProcessing());

  //   final request = ProcessPaymentRequest(
  //     paymentMethod: paymentMethod,
  //     customerId: 4,
  //     referenceNumber: referenceNumber,
  //     amount: paymentMethod == 'cash' ? cashAmount : null,
  //   );

  //   final result = await _checkoutRepo.processPayment(request);

  //   result.when(
  //     success: (response) {
  //       if (response.data != null) {
  //         _cartData = null;
  //         emit(CheckoutState.paymentSuccess(response.data!));
  //       }
  //     },
  //     failure: (error) {
  //       emit(CheckoutState.paymentError(error));
  //     },
  //   );
  // }

  // Process split payment (Cash + Card)
  // Future<void> processSplitPayment({
  //   required num cashAmount,
  //   required num cardAmount,
  //   String? cardReferenceNumber,
  // }) async {
  //   emit(const CheckoutState.paymentProcessing());

  //   final payments = <SplitPaymentItem>[
  //     SplitPaymentItem(paymentMethod: 'cash', amount: cashAmount),
  //     SplitPaymentItem(
  //       paymentMethod: 'card',
  //       amount: cardAmount,
  //       referenceNumber: cardReferenceNumber,
  //     ),
  //   ];

  //   final request = ProcessSplitPaymentRequest(
  //     payments: payments,
  //     customerId: 4,
  //   );

  //   final result = await _checkoutRepo.processSplitPayment(request);

  //   result.when(
  //     success: (response) {
  //       if (response.data != null) {
  //         _cartData = null;
  //         emit(CheckoutState.paymentSuccess(response.data!));
  //       }
  //     },
  //     failure: (error) {
  //       emit(CheckoutState.paymentError(error));
  //     },
  //   );
  // }

  /// Process payment through terminal (cash, card, or split)
  /// Uses cart total as amount and gets terminal_id from SharedPreferences
  Future<void> processTerminalPayment({
    required String paymentMethod, // 'cash', 'card', or 'split'
    num? amountReceived, // For cash: what customer pays
    num? cashAmount, // For split: cash portion
    num? cardAmount, // For split: card portion
  }) async {
    emit(const CheckoutState.terminalPaymentProcessing());

    // Get terminal ID from SharedPreferences
    final terminalId = await SharedPrefHelper.getSecuredString(
      SharedPrefKeys.terminalId,
    );

    if (terminalId.isEmpty) {
      emit(
        CheckoutState.terminalPaymentError(
          ProcessPaymentResponse(
            success: false,
            message: 'No terminal configured. Please select a terminal first.',
          ),
        ),
      );
      return;
    }

    // Use cart total as amount
    final amount = total;

    if (amount <= 0) {
      emit(
        CheckoutState.terminalPaymentError(
          ProcessPaymentResponse(
            success: false,
            message: 'Cart is empty. Please add items before payment.',
          ),
        ),
      );
      return;
    }

    final request = ProcessTerminalPaymentRequest(
      terminalId: terminalId,
      paymentMethod: paymentMethod,
      amount: amount,
      customerId: 4,
      amountReceived: (paymentMethod == 'cash' || paymentMethod == 'split')
          ? amountReceived
          : null,
      cashAmount: paymentMethod == 'split' ? cashAmount : null,
      cardAmount: paymentMethod == 'split' ? cardAmount : null,
    );

    final result = await _checkoutRepo.processTerminalPayment(request);

    result.when(
      success: (response) {
        if (response.isTimeout) {
          // Timeout response
          emit(CheckoutState.terminalPaymentTimeout(response));
        } else if (response.isSuccess && response.data != null) {
          // Success
          _cartData = null;
          emit(CheckoutState.terminalPaymentSuccess(response));
        } else {
          // Error (amount mismatch, etc.)
          emit(CheckoutState.terminalPaymentError(response));
        }
      },
      failure: (error) {
        emit(
          CheckoutState.terminalPaymentError(
            ProcessPaymentResponse(
              success: false,
              message: error.message ?? 'Payment failed. Please try again.',
            ),
          ),
        );
      },
    );
  }

  /// Process card payment using Stripe Terminal SDK (3-step flow)
  /// Step 1: Create Payment Intent (Backend API)
  /// Step 2: Collect Card Payment (SDK Only)
  /// Step 3: Confirm Payment (Backend API)
  Future<void> processStripeCardPayment() async {
    _isCollectingPayment = true;

    try {
      // Validate cart
      if (total <= 0) {
        emit(
          const CheckoutState.cardPaymentError(
            'Cart is empty. Please add items before payment.',
          ),
        );
        return;
      }

      // Get terminal ID from SharedPreferences
      final terminalId = await SharedPrefHelper.getSecuredString(
        SharedPrefKeys.terminalId,
      );

      if (terminalId.isEmpty) {
        emit(
          const CheckoutState.cardPaymentError(
            'No terminal configured. Please select a terminal first.',
          ),
        );
        return;
      }

      // Check if reader is connected
      final connectedReader = await _stripeTerminalService.getConnectedReader();
      if (connectedReader == null) {
        debugPrint('CheckoutCubit: No reader connected, need to reconnect');
        emit(
          const CheckoutState.cardPaymentError(
            'Card reader disconnected. Please log out and log back in to reconnect the reader.',
          ),
        );
        return;
      }

      debugPrint(
        'CheckoutCubit: Reader connected: ${connectedReader.label ?? connectedReader.serialNumber}',
      );

      // ============================================
      // Step 1: Create Payment Intent (Backend API)
      // ============================================
      emit(const CheckoutState.cardPaymentCreatingIntent());
      debugPrint('CheckoutCubit: Step 1 - Creating payment intent...');

      final createIntentRequest = CreatePaymentIntentRequest(
        amount: total,
        terminalId: terminalId,
        currency: 'usd',
        customerId: 4,
      );

      final intentResult = await _checkoutRepo.createPaymentIntent(
        createIntentRequest,
      );

      String? clientSecret;
      String? paymentIntentId;

      intentResult.when(
        success: (response) {
          if (response.isSuccess) {
            clientSecret = response.clientSecret;
            paymentIntentId = response.paymentIntentId;
            debugPrint(
              'CheckoutCubit: Payment intent created: $paymentIntentId',
            );
          } else {
            throw Exception(
              response.message ?? 'Failed to create payment intent',
            );
          }
        },
        failure: (error) {
          throw Exception(error.message ?? 'Failed to create payment intent');
        },
      );

      if (clientSecret == null || paymentIntentId == null) {
        emit(
          const CheckoutState.cardPaymentError(
            'Failed to create payment intent. Please try again.',
          ),
        );
        return;
      }

      // ============================================
      // Step 2: Collect Card Payment (SDK Only)
      // ============================================
      emit(const CheckoutState.cardPaymentCollecting());
      debugPrint('CheckoutCubit: Step 2 - Collecting payment method...');

      PaymentIntent confirmedIntent;
      try {
        // Add timeout for safety (simulated mode should complete in ~3 seconds)
        confirmedIntent = await _stripeTerminalService
            .collectPaymentMethod(clientSecret: clientSecret!)
            .timeout(
              const Duration(seconds: 60),
              onTimeout: () {
                throw Exception(
                  'Payment collection timed out. Please try again.',
                );
              },
            );
        debugPrint(
          'CheckoutCubit: Payment collected and confirmed: ${confirmedIntent.id}',
        );
      } on TerminalException catch (e) {
        if (e.code == TerminalExceptionCode.canceled) {
          emit(const CheckoutState.cardPaymentCancelled());
          return;
        }
        rethrow;
      }

      // ============================================
      // Step 3: Confirm Payment (Backend API)
      // ============================================
      emit(const CheckoutState.cardPaymentConfirming());
      debugPrint('CheckoutCubit: Step 3 - Confirming payment with backend...');

      final confirmRequest = ConfirmStripePaymentRequest(
        paymentIntentId: paymentIntentId!,
        paymentMethod: 'stripe_terminal',
        subtotal: subtotal,
        taxAmount: taxAmount,
        shippingCost: 0,
        discountAmount: discountAmount,
        totalAmount: total,
      );

      final confirmResult = await _checkoutRepo.confirmStripePayment(
        confirmRequest,
      );

      confirmResult.when(
        success: (response) {
          if (response.isSuccess) {
            debugPrint('CheckoutCubit: Payment confirmed successfully!');
            _cartData = null;

            // Create PaymentResponseData from confirm response
            final paymentData = PaymentResponseData(
              order: OrderData(
                id: response.data?.orderId ?? response.orderId,
                orderNumber: response.data?.orderNumber ?? response.orderNumber,
              ),
              paymentMethod: 'stripe_terminal',
            );

            emit(CheckoutState.cardPaymentSuccess(paymentData));
          } else {
            emit(
              CheckoutState.cardPaymentError(
                response.message ?? 'Payment confirmation failed',
              ),
            );
          }
        },
        failure: (error) {
          emit(
            CheckoutState.cardPaymentError(
              error.message ?? 'Payment confirmation failed',
            ),
          );
        },
      );
    } catch (e) {
      debugPrint('CheckoutCubit: Card payment error: $e');
      emit(CheckoutState.cardPaymentError(e.toString()));
    } finally {
      _isCollectingPayment = false;
    }
  }

  /// Cancel card payment collection
  Future<void> cancelCardPayment() async {
    if (_isCollectingPayment) {
      await _stripeTerminalService.cancelCollectPaymentMethod();
      _isCollectingPayment = false;
      emit(const CheckoutState.cardPaymentCancelled());
    }
  }

  /// Process split payment (Card via Stripe Terminal SDK + Cash)
  /// Step 1: Create Payment Intent for card amount (Backend API)
  /// Step 2: Collect Card Payment (SDK Only)
  /// Step 3: Emit success state to collect cash
  /// Step 4: Confirm full payment (Backend API)
  Future<void> processSplitPayment({
    required num cashAmount,
    required num cardAmount,
  }) async {
    _isCollectingPayment = true;

    try {
      // Validate amounts
      if (cashAmount <= 0 || cardAmount <= 0) {
        emit(
          const CheckoutState.cardPaymentError(
            'Both cash and card amounts must be greater than zero.',
          ),
        );
        return;
      }

      // Validate total matches cart total
      final expectedTotal = total;
      if ((cashAmount + cardAmount - expectedTotal).abs() > 0.01) {
        emit(
          CheckoutState.cardPaymentError(
            'Cash (\$${cashAmount.toStringAsFixed(2)}) + Card (\$${cardAmount.toStringAsFixed(2)}) must equal order total \$${expectedTotal.toStringAsFixed(2)}',
          ),
        );
        return;
      }

      // Card minimum is $0.50 for Stripe
      if (cardAmount < 0.50) {
        emit(
          const CheckoutState.cardPaymentError(
            'Card amount must be at least \$0.50',
          ),
        );
        return;
      }

      // Get terminal ID from SharedPreferences
      final terminalId = await SharedPrefHelper.getSecuredString(
        SharedPrefKeys.terminalId,
      );

      if (terminalId.isEmpty) {
        emit(
          const CheckoutState.cardPaymentError(
            'No terminal configured. Please select a terminal first.',
          ),
        );
        return;
      }

      // Check if reader is connected
      final connectedReader = await _stripeTerminalService.getConnectedReader();
      if (connectedReader == null) {
        emit(
          const CheckoutState.cardPaymentError(
            'Card reader disconnected. Please log out and log back in to reconnect the reader.',
          ),
        );
        return;
      }

      debugPrint(
        'SplitPayment: Starting split payment - Cash: \$${cashAmount.toStringAsFixed(2)}, Card: \$${cardAmount.toStringAsFixed(2)}',
      );

      // ============================================
      // Step 1: Create Payment Intent for card amount
      // ============================================
      emit(const CheckoutState.cardPaymentCreatingIntent());
      debugPrint('SplitPayment: Step 1 - Creating payment intent for card portion...');

      final createIntentRequest = CreatePaymentIntentRequest(
        amount: cardAmount,
        terminalId: terminalId,
        currency: 'usd',
        customerId: 4,
      );

      final intentResult = await _checkoutRepo.createPaymentIntent(
        createIntentRequest,
      );

      String? clientSecret;
      String? paymentIntentId;

      intentResult.when(
        success: (response) {
          if (response.isSuccess) {
            clientSecret = response.clientSecret;
            paymentIntentId = response.paymentIntentId;
            debugPrint(
              'SplitPayment: Payment intent created: $paymentIntentId',
            );
          } else {
            throw Exception(
              response.message ?? 'Failed to create payment intent',
            );
          }
        },
        failure: (error) {
          throw Exception(error.message ?? 'Failed to create payment intent');
        },
      );

      if (clientSecret == null || paymentIntentId == null) {
        emit(
          const CheckoutState.cardPaymentError(
            'Failed to create payment intent. Please try again.',
          ),
        );
        return;
      }

      // ============================================
      // Step 2: Collect Card Payment (SDK Only)
      // ============================================
      emit(const CheckoutState.cardPaymentCollecting());
      debugPrint('SplitPayment: Step 2 - Collecting card payment...');

      PaymentIntent confirmedIntent;
      try {
        confirmedIntent = await _stripeTerminalService
            .collectPaymentMethod(clientSecret: clientSecret!)
            .timeout(
              const Duration(seconds: 60),
              onTimeout: () {
                throw Exception(
                  'Payment collection timed out. Please try again.',
                );
              },
            );
        debugPrint(
          'SplitPayment: Card payment collected: ${confirmedIntent.id}',
        );
      } on TerminalException catch (e) {
        if (e.code == TerminalExceptionCode.canceled) {
          emit(const CheckoutState.cardPaymentCancelled());
          return;
        }
        rethrow;
      }

      // ============================================
      // Step 3: Card portion successful, now collect cash
      // ============================================
      debugPrint('SplitPayment: Card portion complete, need to collect cash...');
      emit(CheckoutState.splitPaymentCardSuccess(
        cardAmount: cardAmount,
        cashAmount: cashAmount,
        paymentIntentId: paymentIntentId!,
      ));

    } catch (e) {
      debugPrint('SplitPayment Error: $e');
      emit(CheckoutState.cardPaymentError(e.toString()));
    } finally {
      _isCollectingPayment = false;
    }
  }

  /// Complete split payment after cash is collected
  /// Step 4: Confirm full payment with backend
  Future<void> completeSplitPayment({
    required num cashAmount,
    required num cardAmount,
    required num cashReceived,
    required String paymentIntentId,
  }) async {
    try {
      emit(const CheckoutState.cardPaymentConfirming());
      debugPrint('SplitPayment: Step 4 - Confirming payment with backend...');

      final change = cashReceived - cashAmount;

      final confirmRequest = ConfirmStripePaymentRequest(
        paymentIntentId: paymentIntentId,
        paymentMethod: 'split',
        subtotal: subtotal,
        taxAmount: taxAmount,
        shippingCost: 0,
        discountAmount: discountAmount,
        totalAmount: total,
        cashAmount: cashAmount,
        cardAmount: cardAmount,
        cashReceived: cashReceived,
        change: change,
      );

      final confirmResult = await _checkoutRepo.confirmStripePayment(
        confirmRequest,
      );

      confirmResult.when(
        success: (response) {
          if (response.isSuccess) {
            debugPrint('SplitPayment: Payment confirmed successfully!');
            _cartData = null;

            final paymentData = PaymentResponseData(
              order: OrderData(
                id: response.data?.orderId ?? response.orderId,
                orderNumber: response.data?.orderNumber ?? response.orderNumber,
              ),
              paymentMethod: 'split',
              change: change > 0 ? change : null,
            );

            emit(CheckoutState.splitPaymentComplete(paymentData));
          } else {
            emit(
              CheckoutState.cardPaymentError(
                response.message ?? 'Payment confirmation failed',
              ),
            );
          }
        },
        failure: (error) {
          emit(
            CheckoutState.cardPaymentError(
              error.message ?? 'Payment confirmation failed',
            ),
          );
        },
      );
    } catch (e) {
      debugPrint('SplitPayment Complete Error: $e');
      emit(CheckoutState.cardPaymentError(e.toString()));
    }
  }
}
