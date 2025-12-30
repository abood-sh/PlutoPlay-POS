import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pos/core/helpers/spacing.dart';
import 'package:pos/core/theming/colors.dart';
import 'package:pos/core/theming/styles.dart';

class RefundPage extends StatelessWidget {
  const RefundPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.refresh, size: 64.sp, color: ColorsManager.lightGray),
          verticalSpace(16.h),
          Text('Refund Page', style: TextStyles.font18DarkBlueBold),
          verticalSpace(8.h),
          Text('Process refunds here', style: TextStyles.font14GrayRegular),
        ],
      ),
    );
  }
}
