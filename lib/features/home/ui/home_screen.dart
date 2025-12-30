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
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.all(16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const ScanSection(),
            verticalSpace(24.h),
            const GetCartBlocBuilder(),
            verticalSpace(24.h),
            const SummarySection(),
            const AddRfidBlocListener(),
          ],
        ),
      ),
    );
  }
}
