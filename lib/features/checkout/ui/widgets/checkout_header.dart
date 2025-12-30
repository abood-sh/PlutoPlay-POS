import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pos/core/theming/colors.dart';
import 'package:pos/core/theming/styles.dart';

class CheckoutHeader extends StatelessWidget {
  const CheckoutHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
      decoration: const BoxDecoration(color: ColorsManager.darkBlue),
      child: Row(
        children: [
          Image.asset(
            'assets/images/logo.png',
            height: 32.h,
            errorBuilder: (context, error, stackTrace) {
              return Icon(Icons.store, color: Colors.white, size: 32.sp);
            },
          ),
          SizedBox(width: 16.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Checkout',
                  style: TextStyles.font18DarkBlueBold.copyWith(
                    color: Colors.white,
                  ),
                ),
                Text(
                  'Complete payment and finalize order',
                  style: TextStyles.font12GrayRegular.copyWith(
                    color: Colors.white70,
                  ),
                ),
              ],
            ),
          ),
          OutlinedButton.icon(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back, color: Colors.white),
            label: Text('Back to POS', style: TextStyles.font14WhiteSemiBold),
            style: OutlinedButton.styleFrom(
              side: const BorderSide(color: Colors.white),
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
            ),
          ),
        ],
      ),
    );
  }
}
