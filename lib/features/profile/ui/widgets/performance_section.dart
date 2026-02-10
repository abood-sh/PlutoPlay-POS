import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pos/core/helpers/spacing.dart';
import 'package:pos/core/theming/styles.dart';
import 'package:pos/features/profile/data/models/profile_response.dart';
import 'package:pos/features/profile/ui/widgets/performance_card.dart';

class PerformanceSection extends StatelessWidget {
  final ProfilePerformance performance;

  const PerformanceSection({super.key, required this.performance});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Performance', style: TextStyles.font18DarkBlueBold),
        verticalSpace(12.h),
        Row(
          children: [
            Expanded(
              child: PerformanceCard(
                title: 'Today',
                orders: performance.today?.ordersCount ?? 0,
                sales: performance.today?.totalSales?.toDouble() ?? 0,
              ),
            ),
            horizontalSpace(12.w),
            Expanded(
              child: PerformanceCard(
                title: 'This Month',
                orders: performance.thisMonth?.ordersCount ?? 0,
                sales:
                    double.tryParse(
                      (performance.thisMonth?.totalSales ?? '0').toString(),
                    ) ??
                    0,
                target: double.tryParse(
                  (performance.thisMonth?.target ?? '0').toString(),
                ),
                achievement: performance.thisMonth?.achievementPercentage
                    ?.toDouble(),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
