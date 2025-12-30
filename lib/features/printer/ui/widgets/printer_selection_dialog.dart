import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pos/core/helpers/spacing.dart';
import 'package:pos/core/theming/colors.dart';
import 'package:pos/core/theming/styles.dart';
import 'package:pos/features/printer/data/models/printer_model.dart';
import 'package:pos/features/printer/data/printer_config.dart';

class PrinterSelectionDialog extends StatefulWidget {
  final PrinterModel? currentPrinter;

  const PrinterSelectionDialog({super.key, this.currentPrinter});

  @override
  State<PrinterSelectionDialog> createState() => _PrinterSelectionDialogState();
}

class _PrinterSelectionDialogState extends State<PrinterSelectionDialog> {
  PrinterModel? selectedPrinter;

  @override
  void initState() {
    super.initState();
    selectedPrinter = widget.currentPrinter;
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
      child: Container(
        constraints: BoxConstraints(maxWidth: 500.w, maxHeight: 600.h),
        padding: EdgeInsets.all(24.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.print, color: ColorsManager.mainBlue, size: 24.sp),
                horizontalSpace(12.w),
                Text('Select Printer', style: TextStyles.font18DarkBlueBold),
                const Spacer(),
                IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(Icons.close),
                ),
              ],
            ),
            verticalSpace(8.h),
            Text(
              'Choose a printer for this terminal',
              style: TextStyles.font14GrayRegular,
            ),
            verticalSpace(24.h),
            Expanded(
              child: ListView.separated(
                shrinkWrap: true,
                itemCount: PrinterConfig.availablePrinters.length,
                separatorBuilder: (context, index) => verticalSpace(12.h),
                itemBuilder: (context, index) {
                  final printer = PrinterConfig.availablePrinters[index];
                  final isSelected = selectedPrinter?.ip == printer.ip;

                  return InkWell(
                    onTap: () {
                      setState(() {
                        selectedPrinter = printer;
                      });
                    },
                    borderRadius: BorderRadius.circular(8.r),
                    child: Container(
                      padding: EdgeInsets.all(16.w),
                      decoration: BoxDecoration(
                        color: isSelected
                            ? ColorsManager.mainBlue.withOpacity(0.1)
                            : Colors.white,
                        border: Border.all(
                          color: isSelected
                              ? ColorsManager.mainBlue
                              : ColorsManager.lighterGray,
                          width: isSelected ? 2 : 1,
                        ),
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                      child: Row(
                        children: [
                          Container(
                            padding: EdgeInsets.all(12.w),
                            decoration: BoxDecoration(
                              color: isSelected
                                  ? ColorsManager.mainBlue
                                  : ColorsManager.lighterGray,
                              borderRadius: BorderRadius.circular(8.r),
                            ),
                            child: Icon(
                              Icons.print,
                              color: isSelected
                                  ? Colors.white
                                  : ColorsManager.gray,
                              size: 24.sp,
                            ),
                          ),
                          horizontalSpace(16.w),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  printer.name,
                                  style: TextStyles.font14DarkBlueMedium
                                      .copyWith(
                                        color: isSelected
                                            ? ColorsManager.mainBlue
                                            : ColorsManager.darkBlue,
                                      ),
                                ),
                                verticalSpace(4.h),
                                Text(
                                  printer.location,
                                  style: TextStyles.font12GrayRegular,
                                ),
                                verticalSpace(4.h),
                                Text(
                                  '${printer.ip}:${printer.port}',
                                  style: TextStyles.font12GrayRegular.copyWith(
                                    fontFamily: 'monospace',
                                  ),
                                ),
                              ],
                            ),
                          ),
                          if (isSelected)
                            Icon(
                              Icons.check_circle,
                              color: ColorsManager.mainBlue,
                              size: 24.sp,
                            ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            verticalSpace(24.h),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => Navigator.pop(context),
                    style: OutlinedButton.styleFrom(
                      padding: EdgeInsets.symmetric(vertical: 14.h),
                      side: const BorderSide(color: ColorsManager.gray),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                    ),
                    child: Text(
                      'Cancel',
                      style: TextStyles.font14DarkBlueMedium,
                    ),
                  ),
                ),
                horizontalSpace(12.w),
                Expanded(
                  child: ElevatedButton(
                    onPressed: selectedPrinter == null
                        ? null
                        : () => Navigator.pop(context, selectedPrinter),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: ColorsManager.mainBlue,
                      padding: EdgeInsets.symmetric(vertical: 14.h),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                    ),
                    child: Text(
                      'Select Printer',
                      style: TextStyles.font14WhiteSemiBold,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
