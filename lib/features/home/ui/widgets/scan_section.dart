import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pos/core/helpers/spacing.dart';
import 'package:pos/core/theming/colors.dart';
import 'package:pos/core/theming/styles.dart';
import 'package:pos/features/home/logic/cubit/home_cubit.dart';

class ScanSection extends StatefulWidget {
  const ScanSection({super.key});

  @override
  State<ScanSection> createState() => _ScanSectionState();
}

class _ScanSectionState extends State<ScanSection> {
  final TextEditingController _barcodeController = TextEditingController();

  @override
  void dispose() {
    _barcodeController.dispose();
    super.dispose();
  }

  void _addRfidToCart() {
    final tagId = _barcodeController.text.trim();
    if (tagId.isNotEmpty) {
      context.read<HomeCubit>().addRfidToCart(tagId);
      _barcodeController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Scan Barcode', style: TextStyles.font18DarkBlueBold),
        verticalSpace(12.h),
        TextField(
          controller: _barcodeController,
          style: TextStyle(fontSize: 50.sp),
          onSubmitted: (value) {
            _addRfidToCart();
          },
          decoration: InputDecoration(
            hintText: '[SCAN BARCODE]',
            hintStyle: TextStyles.font14GrayRegular,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.r),
              borderSide: const BorderSide(color: ColorsManager.mainBlue),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.r),
              borderSide: const BorderSide(color: ColorsManager.mainBlue),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.r),
              borderSide: const BorderSide(color: ColorsManager.mainBlue),
            ),
            contentPadding: EdgeInsets.symmetric(
              horizontal: 16.w,
              vertical: 16.h,
            ),
          ),
        ),
        verticalSpace(8.h),
        Text(
          'Focus on the input and scan the RFID tag.',
          style: TextStyles.font12GrayRegular,
        ),
        verticalSpace(16.h),
        SizedBox(
          width: double.infinity,
          child: OutlinedButton(
            onPressed: _addRfidToCart,
            style: OutlinedButton.styleFrom(
              padding: EdgeInsets.symmetric(vertical: 14.h),
              side: const BorderSide(color: ColorsManager.darkBlue),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.r),
              ),
            ),
            child: Text(
              'Enable Manual Mode',
              style: TextStyles.font14DarkBlueMedium,
            ),
          ),
        ),
        verticalSpace(12.h),
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: ColorsManager.lightBlue,
              padding: EdgeInsets.symmetric(vertical: 14.h),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.r),
              ),
            ),
            child: Text('Ready to Scan', style: TextStyles.font14WhiteSemiBold),
          ),
        ),
      ],
    );
  }
}
