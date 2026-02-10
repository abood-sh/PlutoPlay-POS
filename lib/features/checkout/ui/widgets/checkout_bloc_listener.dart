import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pos/core/helpers/extension.dart';
import 'package:pos/core/helpers/spacing.dart';
import 'package:pos/core/routing/routers.dart';
import 'package:pos/core/theming/styles.dart';
import 'package:pos/features/checkout/data/models/process_payment_response.dart';
import 'package:pos/features/checkout/logic/cubit/checkout_cubit.dart';
import 'package:pos/features/checkout/logic/cubit/checkout_state.dart';

class CheckoutBlocListener extends StatelessWidget {
  const CheckoutBlocListener({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<CheckoutCubit, CheckoutState>(
      listenWhen: (previous, current) =>
          current is TerminalPaymentProcessing ||
          current is TerminalPaymentSuccess ||
          current is TerminalPaymentError ||
          current is TerminalPaymentTimeout,
      listener: (context, state) {
        state.whenOrNull(
          terminalPaymentSuccess: (response) {
            _showSuccessDialog(context, response);
          },
          terminalPaymentError: (response) {
            _showErrorDialog(context, response);
          },
          terminalPaymentTimeout: (response) {
            _showTimeoutDialog(context, response);
          },
        );
      },
      child: const SizedBox.shrink(),
    );
  }

  void _showSuccessDialog(BuildContext context, ProcessPaymentResponse response) {
    final data = response.data;
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
              response.message ?? 'Payment processed successfully',
              style: TextStyles.font14GrayRegular,
              textAlign: TextAlign.center,
            ),
            verticalSpace(12.h),
            if (data?.order?.orderNumber != null) ...[
              Text(
                'Order: ${data!.order!.orderNumber}',
                style: TextStyles.font14DarkBlueMedium,
              ),
              verticalSpace(4.h),
            ],
            if (data?.invoiceNumber != null) ...[
              Text(
                'Invoice: ${data!.invoiceNumber}',
                style: TextStyles.font14GrayRegular,
              ),
              verticalSpace(8.h),
            ],
            if (data?.order?.total != null) ...[
              Text(
                'Total: \$${data!.order!.total}',
                style: TextStyles.font18DarkBlueBold,
              ),
              verticalSpace(8.h),
            ],
            // Show change due for cash payments
            if (data?.changeDue != null && data!.changeDue! > 0) ...[
              Container(
                padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 16.w),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.green.shade600, Colors.green.shade400],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Column(
                  children: [
                    Text(
                      'CHANGE DUE',
                      style: TextStyle(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w600,
                        color: Colors.white.withOpacity(0.9),
                        letterSpacing: 1.2,
                      ),
                    ),
                    verticalSpace(4.h),
                    Text(
                      '\$${data.changeDue!.toStringAsFixed(2)}',
                      style: TextStyle(
                        fontSize: 28.sp,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ],
        ),
        actions: [
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                Navigator.pop(dialogContext);
                context.pushNamedAndRemoveUntil(Routers.navigationBar);
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

  void _showErrorDialog(BuildContext context, ProcessPaymentResponse response) {
    // Build error details
    String errorDetails = response.message ?? 'Payment failed';
    
    // Add amount mismatch details if present
    if (response.errors != null && response.errors!.containsKey('amount')) {
      final amountErrors = response.errors!['amount'] as List?;
      if (amountErrors != null && amountErrors.isNotEmpty) {
        errorDetails = amountErrors.first.toString();
      }
    }

    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.r),
        ),
        icon: Icon(Icons.error, color: Colors.red, size: 64.sp),
        title: Text(
          'Payment Failed',
          style: TextStyles.font18DarkBlueBold,
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              errorDetails,
              style: TextStyles.font14GrayRegular,
              textAlign: TextAlign.center,
            ),
            // Show cart total vs provided amount for mismatch errors
            if (response.cartTotal != null && response.providedAmount != null) ...[
              verticalSpace(12.h),
              Container(
                padding: EdgeInsets.all(12.w),
                decoration: BoxDecoration(
                  color: Colors.red.shade50,
                  borderRadius: BorderRadius.circular(8.r),
                  border: Border.all(color: Colors.red.shade200),
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Cart Total:', style: TextStyles.font14DarkBlueMedium),
                        Text('\$${response.cartTotal}', style: TextStyles.font14DarkBlueMedium),
                      ],
                    ),
                    verticalSpace(4.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Provided:', style: TextStyles.font14GrayRegular),
                        Text('\$${response.providedAmount}', 
                          style: TextStyle(
                            fontSize: 14.sp,
                            color: Colors.red,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
            // Show split payment details for split mismatch
            if (response.cashAmount != null && response.cardAmount != null) ...[
              verticalSpace(12.h),
              Container(
                padding: EdgeInsets.all(12.w),
                decoration: BoxDecoration(
                  color: Colors.red.shade50,
                  borderRadius: BorderRadius.circular(8.r),
                  border: Border.all(color: Colors.red.shade200),
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Cart Total:', style: TextStyles.font14DarkBlueMedium),
                        Text('\$${response.cartTotal}', style: TextStyles.font14DarkBlueMedium),
                      ],
                    ),
                    verticalSpace(4.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Cash:', style: TextStyles.font14GrayRegular),
                        Text('\$${response.cashAmount}', style: TextStyles.font14GrayRegular),
                      ],
                    ),
                    verticalSpace(4.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Card:', style: TextStyles.font14GrayRegular),
                        Text('\$${response.cardAmount}', style: TextStyles.font14GrayRegular),
                      ],
                    ),
                    if (response.totalPayments != null) ...[
                      verticalSpace(4.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Total Payments:', style: TextStyles.font14DarkBlueMedium),
                          Text('\$${response.totalPayments}', 
                            style: TextStyle(
                              fontSize: 14.sp,
                              color: Colors.red,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ],
                ),
              ),
            ],
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(dialogContext);
            },
            child: Text('OK', style: TextStyles.font14BlueSemiBold),
          ),
        ],
      ),
    );
  }

  void _showTimeoutDialog(BuildContext context, ProcessPaymentResponse response) {
    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.r),
        ),
        icon: Icon(Icons.access_time, color: Colors.orange, size: 64.sp),
        title: Text(
          'Payment Timeout',
          style: TextStyles.font18DarkBlueBold,
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              response.message ?? 'Payment timeout after maximum attempts',
              style: TextStyles.font14GrayRegular,
              textAlign: TextAlign.center,
            ),
            verticalSpace(12.h),
            Text(
              'Please try again or use a different payment method.',
              style: TextStyles.font14GrayRegular,
              textAlign: TextAlign.center,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(dialogContext);
            },
            child: Text('OK', style: TextStyles.font14BlueSemiBold),
          ),
        ],
      ),
    );
  }
}
