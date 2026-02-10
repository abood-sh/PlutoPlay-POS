import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pos/core/helpers/extension.dart';
import 'package:pos/core/helpers/spacing.dart';
import 'package:pos/core/routing/routers.dart';
import 'package:pos/core/services/printer_service.dart';
import 'package:pos/core/theming/colors.dart';
import 'package:pos/core/theming/styles.dart';
import 'package:pos/features/checkout/logic/cubit/checkout_cubit.dart';
import 'package:pos/features/checkout/logic/cubit/checkout_state.dart';
import 'package:pos/features/checkout/ui/widgets/cash_collection_dialog.dart';
import 'package:pos/features/checkout/ui/widgets/checkout_bloc_listener.dart';
import 'package:pos/features/checkout/ui/widgets/order_details_section.dart';
import 'package:pos/features/checkout/ui/widgets/order_items_section.dart';
import 'package:pos/features/checkout/ui/widgets/payment_method_section.dart';

class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen({super.key});

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  String? _selectedMethod;
  num? _cashAmount;
  num? _cardAmount;
  num? _amountReceived;
  String? _referenceNumber;

  void _handlePaymentMethodSelected(
    String method, {
    num? cashAmount,
    num? cardAmount,
    num? amountReceived,
    String? referenceNumber,
  }) {
    setState(() {
      _selectedMethod = method;
      _cashAmount = cashAmount;
      _cardAmount = cardAmount;
      _amountReceived = amountReceived;
      _referenceNumber = referenceNumber;
    });
  }

  void _processPayment(BuildContext context) {
    if (_selectedMethod == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please select a payment method'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    final cubit = context.read<CheckoutCubit>();
    final cartTotal = cubit.total;

    if (_selectedMethod == 'Split') {
      if (_cashAmount == null ||
          _cardAmount == null ||
          _cashAmount == 0 ||
          _cardAmount == 0) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Please enter both cash and card amounts'),
            backgroundColor: Colors.red,
          ),
        );
        return;
      }
      // Validate: cash_amount + card_amount must equal cart total
      final totalPayment = _cashAmount! + _cardAmount!;
      if (totalPayment != cartTotal) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Cash (\$${_cashAmount?.toStringAsFixed(2)}) + Card (\$${_cardAmount?.toStringAsFixed(2)}) = \$${totalPayment.toStringAsFixed(2)} must equal order total \$${cartTotal.toStringAsFixed(2)}',
            ),
            backgroundColor: Colors.red,
          ),
        );
        return;
      }
      // Use new split payment flow: process card via SDK first, then collect cash
      cubit.processSplitPayment(
        cashAmount: _cashAmount!.toDouble(),
        cardAmount: _cardAmount!.toDouble(),
      );
    } else if (_selectedMethod == 'Cash') {
      // Validate amount received >= cart total
      if (_amountReceived == null || _amountReceived! < cartTotal) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Amount received (\$${_amountReceived?.toStringAsFixed(2) ?? '0.00'}) must be at least \$${cartTotal.toStringAsFixed(2)}',
            ),
            backgroundColor: Colors.red,
          ),
        );
        return;
      }
      cubit.processTerminalPayment(
        paymentMethod: 'cash',
        amountReceived: _amountReceived,
      );
    } else {
      // Card payment - use 3-step Stripe Terminal flow
      cubit.processStripeCardPayment();
    }
  }

  num? _calculateChange(BuildContext context) {
    final cubit = context.read<CheckoutCubit>();
    final total = cubit.total;

    if (_selectedMethod == 'Cash') {
      final amountReceived = _amountReceived ?? 0;
      // Change = amount_received - order_total
      if (amountReceived > total) {
        return amountReceived - total;
      }
    } else if (_selectedMethod == 'Split') {
      final cashAmount = _cashAmount ?? 0;
      final amountReceived = _amountReceived ?? 0;
      // Change = amount_received - cash_amount (what customer overpays in cash)
      if (amountReceived > cashAmount) {
        return amountReceived - cashAmount;
      }
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: Stack(
          children: [
            BlocConsumer<CheckoutCubit, CheckoutState>(
              listener: (context, state) {
                state.maybeWhen(
                  paymentSuccess: (data) {
                    _printAndShowSuccessDialog(context, data);
                  },
                  paymentError: (error) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(error.message ?? 'Payment failed'),
                        backgroundColor: Colors.red,
                      ),
                    );
                  },
                  terminalPaymentSuccess: (response) {
                    if (response.data != null) {
                      _printAndShowSuccessDialog(context, response.data);
                    }
                  },
                  // Handle 3-step card payment states
                  cardPaymentSuccess: (data) {
                    _printAndShowSuccessDialog(context, data);
                  },
                  cardPaymentError: (message) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(message),
                        backgroundColor: Colors.red,
                      ),
                    );
                  },
                  cardPaymentCancelled: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Payment cancelled'),
                        backgroundColor: Colors.orange,
                      ),
                    );
                  },
                  // Handle split payment states
                  splitPaymentCardSuccess: (cardAmount, cashAmount, paymentIntentId) {
                    // Card portion successful, now show cash collection dialog
                    _showCashCollectionDialog(
                      context,
                      cashAmount: cashAmount.toDouble(),
                      cardAmount: cardAmount.toDouble(),
                      paymentIntentId: paymentIntentId,
                    );
                  },
                  splitPaymentComplete: (data) {
                    _printAndShowSuccessDialog(context, data);
                  },
                  orElse: () {},
                );
              },
              buildWhen: (previous, current) {
                return current.maybeWhen(
                  loaded: (_) => true,
                  initial: () => true,
                  paymentProcessing: () => true,
                  paymentError: (_) => true,
                  paymentSuccess: (_) => true,
                  terminalPaymentProcessing: () => true,
                  terminalPaymentSuccess: (_) => true,
                  terminalPaymentError: (_) => true,
                  terminalPaymentTimeout: (_) => true,
                  // Card payment states
                  cardPaymentCreatingIntent: () => true,
                  cardPaymentCollecting: () => true,
                  cardPaymentConfirming: () => true,
                  cardPaymentSuccess: (_) => true,
                  cardPaymentError: (_) => true,
                  cardPaymentCancelled: () => true,
                  // Split payment states
                  splitPaymentCardSuccess: (_, __, ___) => true,
                  splitPaymentComplete: (_) => true,
                  orElse: () => false,
                );
              },
              builder: (context, state) {
                final cubit = context.read<CheckoutCubit>();
                final isProcessing =
                    state is PaymentProcessing ||
                    state is TerminalPaymentProcessing ||
                    state is CardPaymentCreatingIntent ||
                    state is CardPaymentCollecting ||
                    state is CardPaymentConfirming ||
                    state is SplitPaymentCardSuccess;

                if (cubit.cartData != null) {
                  return LayoutBuilder(
                    builder: (context, constraints) {
                      bool isTablet = constraints.maxWidth > 600;

                      if (isTablet) {
                        return _buildTabletLayout(context, isProcessing);
                      } else {
                        return _buildMobileLayout(context, isProcessing);
                      }
                    },
                  );
                }
                return const Center(child: Text('No cart data available'));
              },
            ),
            const CheckoutBlocListener(),
          ],
        ),
      ),
    );
  }

  Future<void> _printAndShowSuccessDialog(
    BuildContext context,
    dynamic data,
  ) async {
    // Get cart items for printing
    final cubit = context.read<CheckoutCubit>();
    final cartItems = cubit.items
        .map(
          (item) => {
            'name': item.productName ?? 'Unknown',
            'quantity': item.quantity ?? 1,
            'subtotal': double.tryParse(item.subtotal ?? '0') ?? 0.0,
          },
        )
        .toList();

    // Print invoice in background
    PrinterService.printOrderInvoice(
      paymentData: data,
      cartItems: cartItems,
    ).then((result) {
      if (mounted && result['success'] != true) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(result['message'] ?? 'Print failed'),
            backgroundColor: Colors.orange,
          ),
        );
      }
    });

    // Show success dialog immediately
    _showPaymentSuccessDialog(context, data);
  }

  void _showPaymentSuccessDialog(BuildContext context, dynamic data) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (dialogContext) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.r),
        ),
        icon: Icon(Icons.check_circle, color: Colors.green, size: 64.sp),
        title: Text(
          'Payment Successful!',
          style: TextStyles.font18DarkBlueBold,
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Order: ${data.order?.orderNumber ?? 'N/A'}',
              style: TextStyles.font14DarkBlueMedium,
            ),
            verticalSpace(8.h),
            Text(
              'Invoice: ${data.invoiceNumber ?? 'N/A'}',
              style: TextStyles.font14GrayRegular,
            ),
            verticalSpace(8.h),
            Text(
              'Total: \$${data.order?.total ?? '0.00'}',
              style: TextStyles.font18DarkBlueBold,
            ),
          ],
        ),
        actions: [
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                Navigator.pop(dialogContext);
                context.pushNamedAndRemoveUntil(Routers.navigationBar);
                // Navigator.pushNamedAndRemoveUntil(
                //   context,
                //   Routes.mainScreen,
                //   (route) => false,
                // );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                padding: EdgeInsets.symmetric(vertical: 12.h),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.r),
                ),
              ),
              child: Text('Done', style: TextStyles.font14WhiteSemiBold),
            ),
          ),
        ],
      ),
    );
  }

  void _showCashCollectionDialog(
    BuildContext context, {
    required double cashAmount,
    required double cardAmount,
    required String paymentIntentId,
  }) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (dialogContext) => CashCollectionDialog(
        cashAmount: cashAmount,
        cardAmount: cardAmount,
        onConfirm: (cashReceived) {
          // Complete the split payment with cash details
          final cubit = context.read<CheckoutCubit>();
          cubit.completeSplitPayment(
            cashAmount: cashAmount,
            cardAmount: cardAmount,
            cashReceived: cashReceived,
            paymentIntentId: paymentIntentId,
          );
        },
      ),
    );
  }

  Widget _buildMobileLayout(BuildContext context, bool isProcessing) {
    final cubit = context.read<CheckoutCubit>();
    return Padding(
      padding: EdgeInsets.all(12.w),
      child: CustomScrollView(
        slivers: [
          // Back button row
          SliverToBoxAdapter(
            child: Row(
              children: [
                IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: Icon(Icons.arrow_back, size: 24.sp),
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                ),
                horizontalSpace(8.w),
                Text('Checkout', style: TextStyles.font18DarkBlueBold),
              ],
            ),
          ),
          SliverToBoxAdapter(child: verticalSpace(8.h)),
          // Order Items
          SliverToBoxAdapter(
            child: SizedBox(
              height: 200.h,
              child: OrderItemsSection(items: cubit.items),
            ),
          ),
          SliverToBoxAdapter(child: verticalSpace(8.h)),
          // Order Details
          SliverToBoxAdapter(
            child: OrderDetailsSection(
              subtotal: cubit.subtotal,
              taxAmount: cubit.taxAmount,
              discountAmount: cubit.discountAmount,
              total: cubit.total,
            ),
          ),
          SliverToBoxAdapter(child: verticalSpace(8.h)),
          // Payment Method
          SliverToBoxAdapter(
            child: SizedBox(
              height: 200.h,
              child: PaymentMethodSection(
                orderTotal: cubit.total,
                onMethodSelected: _handlePaymentMethodSelected,
              ),
            ),
          ),
          SliverToBoxAdapter(child: verticalSpace(8.h)),
          // Pay Button
          SliverToBoxAdapter(child: _buildPayButton(context, isProcessing)),
        ],
      ),
    );
  }

  Widget _buildTabletLayout(BuildContext context, bool isProcessing) {
    final cubit = context.read<CheckoutCubit>();
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
      child: Column(
        children: [
          // Minimal back button row
          Row(
            children: [
              IconButton(
                onPressed: () => Navigator.pop(context),
                icon: Icon(Icons.arrow_back, size: 22.sp),
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(),
              ),
              horizontalSpace(8.w),
              Text('Checkout', style: TextStyles.font18DarkBlueBold),
            ],
          ),
          verticalSpace(8.h),
          // Main content in horizontal layout
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Left: Order Items (largest section)
                Expanded(flex: 3, child: OrderItemsSection(items: cubit.items)),
                horizontalSpace(12.w),
                // Right: Order Details + Payment stacked - fully scrollable
                Expanded(
                  flex: 2,
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        // Order Details (compact)
                        OrderDetailsSection(
                          subtotal: cubit.subtotal,
                          taxAmount: cubit.taxAmount,
                          discountAmount: cubit.discountAmount,
                          total: cubit.total,
                        ),
                        verticalSpace(8.h),
                        // Payment section
                        SizedBox(
                          height: 220.h,
                          child: PaymentMethodSection(
                            orderTotal: cubit.total,
                            onMethodSelected: _handlePaymentMethodSelected,
                          ),
                        ),
                        verticalSpace(8.h),
                        // Pay button with change display
                        _buildPayButton(context, isProcessing),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPayButton(BuildContext context, bool isProcessing) {
    final change = _calculateChange(context);
    final state = context.watch<CheckoutCubit>().state;

    // Determine the status text based on card payment state
    String getStatusText() {
      return state.maybeWhen(
        cardPaymentCreatingIntent: () => 'Creating payment...',
        cardPaymentCollecting: () => 'Insert, tap or swipe card...',
        cardPaymentConfirming: () => 'Confirming payment...',
        terminalPaymentProcessing: () => _selectedMethod == 'Card'
            ? 'Waiting for customer...'
            : 'Processing...',
        orElse: () => 'Processing...',
      );
    }

    // Check if we can cancel (only during card collection)
    final canCancel = state.maybeWhen(
      cardPaymentCollecting: () => true,
      orElse: () => false,
    );

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (change != null && change > 0) ...[
          Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 20.w),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.green.shade600, Colors.green.shade400],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(12.r),
              boxShadow: [
                BoxShadow(
                  color: Colors.green.withOpacity(0.3),
                  blurRadius: 8,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.attach_money, color: Colors.white, size: 28.sp),
                    horizontalSpace(8.w),
                    Text(
                      'CHANGE DUE',
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w600,
                        color: Colors.white.withOpacity(0.9),
                        letterSpacing: 1.2,
                      ),
                    ),
                  ],
                ),
                verticalSpace(8.h),
                Text(
                  '\$${change.toStringAsFixed(2)}',
                  style: TextStyle(
                    fontSize: 36.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
          verticalSpace(10.h),
        ],
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: isProcessing ? null : () => _processPayment(context),
            style: ElevatedButton.styleFrom(
              backgroundColor: ColorsManager.mainBlue,
              padding: EdgeInsets.symmetric(vertical: 14.h),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.r),
              ),
            ),
            child: isProcessing
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 20.w,
                        height: 20.h,
                        child: const CircularProgressIndicator(
                          color: Colors.white,
                          strokeWidth: 2,
                        ),
                      ),
                      horizontalSpace(12.w),
                      Text(
                        getStatusText(),
                        style: TextStyles.font16WhiteSemiBold,
                      ),
                    ],
                  )
                : Text(
                    'Complete Payment',
                    style: TextStyles.font16WhiteSemiBold,
                  ),
          ),
        ),
        // Cancel button for card collection
        if (canCancel) ...[
          verticalSpace(8.h),
          SizedBox(
            width: double.infinity,
            child: OutlinedButton(
              onPressed: () {
                context.read<CheckoutCubit>().cancelCardPayment();
              },
              style: OutlinedButton.styleFrom(
                side: const BorderSide(color: Colors.red),
                padding: EdgeInsets.symmetric(vertical: 12.h),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.r),
                ),
              ),
              child: Text(
                'Cancel Payment',
                style: TextStyles.font14BlueSemiBold.copyWith(
                  color: Colors.red,
                ),
              ),
            ),
          ),
        ],
      ],
    );
  }
}
