import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pos/core/helpers/spacing.dart';
import 'package:pos/core/theming/colors.dart';
import 'package:pos/core/theming/styles.dart';

class PaymentSummarySection extends StatelessWidget {
  final num subtotal;
  final num taxAmount;
  final num discountAmount;
  final num total;

  const PaymentSummarySection({
    super.key,
    required this.subtotal,
    required this.taxAmount,
    required this.discountAmount,
    required this.total,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: ColorsManager.darkBlue,
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.credit_card, color: Colors.white, size: 20.sp),
              horizontalSpace(8.w),
              Text('Payment Summary', style: TextStyles.font16WhiteSemiBold),
            ],
          ),
          verticalSpace(16.h),
          _buildSummaryRow(
            'Subtotal:',
            '\$${subtotal.toStringAsFixed(2)}',
            false,
          ),
          verticalSpace(12.h),
          _buildSummaryRow(
            'Discount:',
            '-\$${discountAmount.toStringAsFixed(2)}',
            true,
          ),
          verticalSpace(12.h),
          _buildSummaryRow('Shipping:', '\$0.00', false),
          verticalSpace(12.h),
          _buildSummaryRow('Installation:', '\$0.00', false),
          verticalSpace(12.h),
          _buildSummaryRow('Tax:', '\$${taxAmount.toStringAsFixed(2)}', false),
          const Divider(height: 24, color: Colors.white24),
          _buildTotalRow(),
        ],
      ),
    );
  }

  Widget _buildSummaryRow(String label, String value, bool isDiscount) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyles.font14WhiteSemiBold.copyWith(
            color: isDiscount ? Colors.red.shade300 : Colors.white70,
          ),
        ),
        Text(
          value,
          style: TextStyles.font14WhiteSemiBold.copyWith(
            color: isDiscount ? Colors.red.shade300 : Colors.white,
          ),
        ),
      ],
    );
  }

  Widget _buildTotalRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'TOTAL DUE:',
          style: TextStyles.font13DarkBlueRegular.copyWith(color: Colors.white),
        ),
        Text(
          '\$${total.toStringAsFixed(2)}',
          style: TextStyles.font18DarkBlueBold.copyWith(
            color: Colors.white,
            fontSize: 24.sp,
          ),
        ),
      ],
    );
  }
}
