import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pos/core/helpers/extension.dart';
import 'package:pos/core/helpers/spacing.dart';
import 'package:pos/core/theming/colors.dart';
import 'package:pos/core/theming/styles.dart';
import 'package:pos/features/home/logic/cubit/home_cubit.dart';
import 'package:pos/features/home/logic/cubit/home_state.dart';
import 'package:pos/core/services/printer_service.dart';
import 'package:pos/features/home/data/models/cart_model_response.dart';

class SummarySection extends StatefulWidget {
  const SummarySection({super.key});

  @override
  State<SummarySection> createState() => _SummarySectionState();
}

class _SummarySectionState extends State<SummarySection> {
  bool _isPrinting = false;

  Future<void> _handlePrint(CartData cartData) async {
    if (_isPrinting) return;

    setState(() {
      _isPrinting = true;
    });

    try {
      // Format cart items for printing
      final items =
          cartData.items?.map((item) {
            return {
              'name': item.productName ?? 'Unknown',
              'quantity': item.quantity ?? 0,
              'subtotal': double.tryParse(item.subtotal ?? '0') ?? 0.0,
            };
          }).toList() ??
          [];

      // Call printer service
      final result = await PrinterService.printInvoice(
        items: items,
        subtotal: (cartData.subtotal ?? 0).toDouble(),
        tax: (cartData.taxAmount ?? 0).toDouble(),
        discount: (cartData.discountAmount ?? 0).toDouble(),
        total: (cartData.total ?? 0).toDouble(),
      );

      if (!mounted) return;

      // Show result message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(result['message'] ?? 'Print completed'),
          backgroundColor: result['success'] == true
              ? Colors.green
              : Colors.red,
          duration: const Duration(seconds: 3),
        ),
      );
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Print error: $e'),
          backgroundColor: Colors.red,
          duration: const Duration(seconds: 3),
        ),
      );
    } finally {
      if (mounted) {
        setState(() {
          _isPrinting = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      buildWhen: (previous, current) =>
          current is GetCartSuccess || current is GetCartLoading,
      builder: (context, state) {
        return state.maybeWhen(
          getCartSuccess: (cartData) {
            if (cartData == null ||
                cartData.isEmpty ||
                cartData.first == null) {
              return _buildSummaryContent(0, 0, 0, context, null);
            }
            final cart = cartData.first!;
            return _buildSummaryContent(
              cart.subtotal ?? 0,
              cart.taxAmount ?? 0,
              cart.total ?? 0,
              context,
              cart,
            );
          },
          orElse: () => _buildSummaryContent(0, 0, 0, context, null),
        );
      },
    );
  }

  Widget _buildSummaryContent(
    num subtotal,
    num tax,
    num total,
    BuildContext context,
    CartData? cartData,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Summary', style: TextStyles.font18DarkBlueBold),
        verticalSpace(12.h),
        Row(
          children: [
            Expanded(
              child: _buildSummaryCard(
                'Subtotal',
                '\$${subtotal.toStringAsFixed(2)}',
              ),
            ),
            horizontalSpace(12.w),
            Expanded(
              child: _buildSummaryCard('Tax', '\$${tax.toStringAsFixed(2)}'),
            ),
            horizontalSpace(12.w),
            Expanded(
              child: _buildSummaryCard(
                'Total',
                '\$${total.toStringAsFixed(2)}',
              ),
            ),
          ],
        ),
        verticalSpace(16.h),
        verticalSpace(12.h),

        // Print button
        // if (cartData != null && (cartData.items?.isNotEmpty ?? false))
        //   SizedBox(
        //     width: double.infinity,
        //     child: ElevatedButton.icon(
        //       onPressed: _isPrinting ? null : () => _handlePrint(cartData),
        //       icon: _isPrinting
        //           ? SizedBox(
        //               width: 16.w,
        //               height: 16.w,
        //               child: const CircularProgressIndicator(
        //                 strokeWidth: 2,
        //                 valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
        //               ),
        //             )
        //           : Icon(Icons.print, size: 100.w),
        //       label: Text(
        //         _isPrinting ? 'Printing...' : 'Test Print',
        //         style: TextStyles.font14WhiteSemiBold,
        //       ),
        //       style: ElevatedButton.styleFrom(
        //         backgroundColor: ColorsManager.darkBlue,
        //         padding: EdgeInsets.symmetric(vertical: 14.h),
        //         shape: RoundedRectangleBorder(
        //           borderRadius: BorderRadius.circular(8.r),
        //         ),
        //       ),
        //     ),
        //   ),
        if (cartData != null && (cartData.items?.isNotEmpty ?? false))
          verticalSpace(12.h),
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: cartData != null && (cartData.items?.isNotEmpty ?? false)
                ? () {
                    context.pushNamed('/checkoutScreen', arguments: cartData);
                  }
                : null,
            style: ElevatedButton.styleFrom(
              backgroundColor: ColorsManager.black,
              padding: EdgeInsets.symmetric(vertical: 14.h),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.r),
              ),
            ),
            child: Text('Checkout', style: TextStyles.font14WhiteSemiBold),
          ),
        ),
      ],
    );
  }

  Widget _buildSummaryCard(String label, String value) {
    return Container(
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        border: Border.all(color: ColorsManager.lighterGray),
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Column(
        children: [
          Text(label, style: TextStyles.font12GrayRegular),
          verticalSpace(4.h),
          Text(
            value,
            style: TextStyles.font16WhiteSemiBold.copyWith(
              color: ColorsManager.darkBlue,
            ),
          ),
        ],
      ),
    );
  }
}
