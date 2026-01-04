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
import 'package:pos/features/checkout/ui/widgets/checkout_header.dart';
import 'package:pos/features/checkout/ui/widgets/order_details_section.dart';
import 'package:pos/features/checkout/ui/widgets/order_items_section.dart';
import 'package:pos/features/checkout/ui/widgets/payment_method_section.dart';
import 'package:pos/features/checkout/ui/widgets/payment_summary_section.dart';

class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen({super.key});

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  String? _selectedMethod;
  num? _cashAmount;
  num? _cardAmount;
  String? _referenceNumber;

  void _handlePaymentMethodSelected(
    String method, {
    num? cashAmount,
    num? cardAmount,
    String? referenceNumber,
  }) {
    setState(() {
      _selectedMethod = method;
      _cashAmount = cashAmount;
      _cardAmount = cardAmount;
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
      cubit.processSplitPayment(
        cashAmount: _cashAmount!,
        cardAmount: _cardAmount!,
        cardReferenceNumber: _referenceNumber,
      );
    } else if (_selectedMethod == 'Cash') {
      cubit.processPayment(paymentMethod: 'cash', cashAmount: _cashAmount);
    } else {
      cubit.processPayment(
        paymentMethod: _selectedMethod!.toLowerCase(),
        referenceNumber: _referenceNumber,
      );
    }
  }

  num? _calculateChange(BuildContext context) {
    final cubit = context.read<CheckoutCubit>();
    final total = cubit.total;

    if (_selectedMethod == 'Cash' && _cashAmount != null) {
      if (_cashAmount! > total) {
        return _cashAmount! - total;
      }
    } else if (_selectedMethod == 'Split') {
      final cashAmount = _cashAmount ?? 0;
      final cardAmount = _cardAmount ?? 0;
      // Card covers part of total, cash covers the rest
      // Change = cash - (total - card) if cash > remaining
      final remainingAfterCard = total - cardAmount;
      if (remainingAfterCard > 0 && cashAmount > remainingAfterCard) {
        return cashAmount - remainingAfterCard;
      }
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocConsumer<CheckoutCubit, CheckoutState>(
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
              orElse: () => false,
            );
          },
          builder: (context, state) {
            final cubit = context.read<CheckoutCubit>();
            final isProcessing = state is PaymentProcessing;

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

  Widget _buildMobileLayout(BuildContext context, bool isProcessing) {
    final cubit = context.read<CheckoutCubit>();
    return Column(
      children: [
        const CheckoutHeader(),
        Expanded(
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(16.w),
              child: Column(
                children: [
                  OrderItemsSection(items: cubit.items),
                  verticalSpace(24.h),
                  OrderDetailsSection(
                    subtotal: cubit.subtotal,
                    taxAmount: cubit.taxAmount,
                    discountAmount: cubit.discountAmount,
                    total: cubit.total,
                  ),
                  verticalSpace(24.h),
                  PaymentSummarySection(
                    subtotal: cubit.subtotal,
                    taxAmount: cubit.taxAmount,
                    discountAmount: cubit.discountAmount,
                    total: cubit.total,
                  ),
                  verticalSpace(24.h),
                  PaymentMethodSection(
                    onMethodSelected: _handlePaymentMethodSelected,
                  ),
                  verticalSpace(24.h),
                  _buildPayButton(context, isProcessing),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildTabletLayout(BuildContext context, bool isProcessing) {
    final cubit = context.read<CheckoutCubit>();
    return Column(
      children: [
        const CheckoutHeader(),
        Expanded(
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(24.w),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 3,
                    child: Column(
                      children: [
                        OrderItemsSection(items: cubit.items),
                        verticalSpace(24.h),
                        OrderDetailsSection(
                          subtotal: cubit.subtotal,
                          taxAmount: cubit.taxAmount,
                          discountAmount: cubit.discountAmount,
                          total: cubit.total,
                        ),
                      ],
                    ),
                  ),
                  horizontalSpace(24.w),
                  Expanded(
                    flex: 2,
                    child: Column(
                      children: [
                        PaymentSummarySection(
                          subtotal: cubit.subtotal,
                          taxAmount: cubit.taxAmount,
                          discountAmount: cubit.discountAmount,
                          total: cubit.total,
                        ),
                        verticalSpace(24.h),
                        PaymentMethodSection(
                          onMethodSelected: _handlePaymentMethodSelected,
                        ),
                        verticalSpace(24.h),
                        _buildPayButton(context, isProcessing),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildPayButton(BuildContext context, bool isProcessing) {
    final change = _calculateChange(context);

    return Column(
      children: [
        if (change != null && change > 0) ...[
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(12.w),
            decoration: BoxDecoration(
              color: Colors.green.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8.r),
              border: Border.all(color: Colors.green),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.info_outline, color: Colors.green, size: 20.sp),
                horizontalSpace(8.w),
                Text(
                  'Give back change: \$${change.toStringAsFixed(2)}',
                  style: TextStyles.font14DarkBlueMedium.copyWith(
                    color: Colors.green,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          verticalSpace(12.h),
        ],
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: isProcessing ? null : () => _processPayment(context),
            style: ElevatedButton.styleFrom(
              backgroundColor: ColorsManager.mainBlue,
              padding: EdgeInsets.symmetric(vertical: 16.h),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.r),
              ),
            ),
            child: isProcessing
                ? SizedBox(
                    width: 24.w,
                    height: 24.h,
                    child: const CircularProgressIndicator(
                      color: Colors.white,
                      strokeWidth: 2,
                    ),
                  )
                : Text(
                    'Complete Payment',
                    style: TextStyles.font16WhiteSemiBold,
                  ),
          ),
        ),
      ],
    );
  }
}
