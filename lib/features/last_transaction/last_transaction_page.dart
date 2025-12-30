import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pos/core/helpers/spacing.dart';
import 'package:pos/core/theming/colors.dart';
import 'package:pos/core/theming/styles.dart';

class LastTransactionPage extends StatelessWidget {
  const LastTransactionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.history, size: 64.sp, color: ColorsManager.lightGray),
          verticalSpace(16.h),
          Text('Last Transaction', style: TextStyles.font18DarkBlueBold),
          verticalSpace(8.h),
          Text('View transaction history', style: TextStyles.font14GrayRegular),
        ],
      ),
    );
  }
}
