import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pos/core/helpers/spacing.dart';
import 'package:pos/core/theming/colors.dart';
import 'package:pos/core/theming/styles.dart';

class PerformanceCard extends StatelessWidget {
  final String title;
  final int orders;
  final double sales;
  final double? target;
  final double? achievement;

  const PerformanceCard({
    super.key,
    required this.title,
    required this.orders,
    required this.sales,
    this.target,
    this.achievement,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: ColorsManager.white,
        border: Border.all(color: ColorsManager.lighterGray),
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: TextStyles.font14GrayRegular),
          verticalSpace(8.h),
          Text(
            '\$${sales.toStringAsFixed(2)}',
            style: TextStyles.font18DarkBlueBold.copyWith(
              color: ColorsManager.mainBlue,
            ),
          ),
          verticalSpace(4.h),
          Text('$orders orders', style: TextStyles.font12GrayRegular),
          if (target != null && achievement != null) ...[
            verticalSpace(8.h),
            LinearProgressIndicator(
              value: (achievement! / 100).clamp(0.0, 1.0),
              backgroundColor: ColorsManager.lighterGray,
              valueColor: AlwaysStoppedAnimation<Color>(
                achievement! >= 100
                    ? ColorsManager.green
                    : ColorsManager.mainBlue,
              ),
            ),
            verticalSpace(4.h),
            Text(
              '${achievement!.toStringAsFixed(0)}% of target',
              style: TextStyles.font12GrayRegular,
            ),
          ],
        ],
      ),
    );
  }
}
