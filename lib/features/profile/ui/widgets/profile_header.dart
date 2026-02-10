import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pos/core/helpers/spacing.dart';
import 'package:pos/core/theming/colors.dart';
import 'package:pos/core/theming/styles.dart';
import 'package:pos/features/profile/data/models/profile_response.dart';

class ProfileHeader extends StatelessWidget {
  final ProfileSalesman? salesman;
  final ProfileStore? store;

  const ProfileHeader({super.key, this.salesman, this.store});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isTablet = constraints.maxWidth > 600;

        return Container(
          padding: EdgeInsets.all(16.w),
          decoration: BoxDecoration(
            color: ColorsManager.lightBlue,
            borderRadius: BorderRadius.circular(12.r),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: isTablet ? 32.r : 24.r,
                backgroundColor: ColorsManager.mainBlue,
                child: Icon(
                  Icons.person,
                  size: isTablet ? 32.sp : 24.sp,
                  color: Colors.white,
                ),
              ),
              horizontalSpace(16.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      salesman?.displayName ?? 'User',
                      style: TextStyles.font18DarkBlueBold,
                    ),
                    verticalSpace(4.h),
                    Text(
                      salesman?.email ?? '',
                      style: TextStyles.font14GrayRegular,
                    ),
                    if (store?.name != null) ...[
                      verticalSpace(4.h),
                      Row(
                        children: [
                          Icon(
                            Icons.store,
                            size: 14.sp,
                            color: ColorsManager.gray,
                          ),
                          horizontalSpace(4.w),
                          Text(
                            store!.name!,
                            style: TextStyles.font12GrayRegular,
                          ),
                        ],
                      ),
                    ],
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
