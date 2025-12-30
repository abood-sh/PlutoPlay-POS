import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pos/core/helpers/spacing.dart';
import 'package:pos/core/theming/colors.dart';
import 'package:pos/core/theming/styles.dart';

class PaymentMethodSection extends StatefulWidget {
  const PaymentMethodSection({super.key});

  @override
  State<PaymentMethodSection> createState() => _PaymentMethodSectionState();
}

class _PaymentMethodSectionState extends State<PaymentMethodSection> {
  String? selectedMethod;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8.r),
        border: Border.all(color: ColorsManager.lighterGray),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.payment, color: ColorsManager.darkBlue, size: 20.sp),
              horizontalSpace(3.w),
              Expanded(
                child: Text(
                  'Payment Method',
                  style: TextStyles.font16WhiteSemiBold.copyWith(
                    color: ColorsManager.darkBlue,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          verticalSpace(16.h),
          GridView.count(
            crossAxisCount: 3,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            mainAxisSpacing: 12.h,
            crossAxisSpacing: 12.w,
            childAspectRatio: 1.0,
            children: [
              _buildPaymentMethodCard('Cash', Icons.money, Colors.green),
              // _buildPaymentMethodCard(
              //   'COD',
              //   Icons.local_shipping,
              //   Colors.orange,
              // ),
              _buildPaymentMethodCard('Card', Icons.credit_card, Colors.blue),
              // _buildPaymentMethodCard(
              //   'Zelle',
              //   Icons.currency_exchange,
              //   Colors.purple,
              // ),
              // _buildPaymentMethodCard('Check', Icons.receipt, Colors.teal),
              // _buildPaymentMethodCard(
              //   'Bank Transfer',
              //   Icons.account_balance,
              //   Colors.red,
              // ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPaymentMethodCard(String label, IconData icon, Color color) {
    bool isSelected = selectedMethod == label;

    return GestureDetector(
      onTap: () {
        setState(() {
          selectedMethod = label;
        });
      },
      child: Container(
        decoration: BoxDecoration(
          color: isSelected ? color.withOpacity(0.1) : Colors.white,
          borderRadius: BorderRadius.circular(8.r),
          border: Border.all(
            color: isSelected ? color : ColorsManager.lighterGray,
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, color: color, size: 24.sp),
            verticalSpace(4.h),
            Text(
              label,
              style: TextStyles.font12GrayRegular.copyWith(
                color: isSelected ? color : ColorsManager.darkBlue,
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            ),
          ],
        ),
      ),
    );
  }
}
