import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pos/core/helpers/spacing.dart';
import 'package:pos/features/home/ui/widgets/add_rfid_bloc_listener.dart';
import 'package:pos/features/home/ui/widgets/get_cart_bloc_builder.dart';
import 'package:pos/features/home/ui/widgets/scan_section.dart';
import 'package:pos/features/home/ui/widgets/summary_section.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isTablet = constraints.maxWidth > 600;

        if (isTablet) {
          return Padding(
            padding: EdgeInsets.all(16.w),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 2,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const ScanSection(),
                      verticalSpace(16.h),
                      const Expanded(child: GetCartBlocBuilder()),
                    ],
                  ),
                ),
                horizontalSpace(16.w),
                Expanded(
                  flex: 1,
                  child: Column(
                    children: [const Spacer(), const SummarySection()],
                  ),
                ),
                const AddRfidBlocListener(),
              ],
            ),
          );
        }

        return Padding(
          padding: EdgeInsets.all(16.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const ScanSection(),
              verticalSpace(16.h),
              const Expanded(child: GetCartBlocBuilder()),
              verticalSpace(16.h),
              const SummarySection(),
              const AddRfidBlocListener(),
            ],
          ),
        );
      },
    );
  }
}
