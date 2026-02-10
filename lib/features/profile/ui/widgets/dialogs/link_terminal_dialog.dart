import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pos/core/helpers/spacing.dart';
import 'package:pos/core/theming/colors.dart';
import 'package:pos/core/theming/styles.dart';

class LinkTerminalDialog extends StatelessWidget {
  const LinkTerminalDialog({super.key});

  static Future<void> show(BuildContext context) async {
    await showDialog(
      context: context,
      builder: (dialogContext) => const LinkTerminalDialog(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
      title: Text('Link Terminal', style: TextStyles.font18DarkBlueBold),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.devices, size: 48.sp, color: ColorsManager.mainBlue),
          verticalSpace(16.h),
          Text(
            'Search for available payment terminals',
            style: TextStyles.font14GrayRegular,
            textAlign: TextAlign.center,
          ),
          verticalSpace(16.h),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Searching for terminals...')),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: ColorsManager.mainBlue,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.r),
                ),
              ),
              child: Text(
                'Scan Devices',
                style: TextStyles.font14WhiteSemiBold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
