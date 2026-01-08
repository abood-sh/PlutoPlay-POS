import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pos/core/helpers/spacing.dart';
import 'package:pos/core/theming/colors.dart';

class PaymentMethodSection extends StatefulWidget {
  final Function(
    String method, {
    num? cashAmount,
    num? cardAmount,
    String? referenceNumber,
  })?
  onMethodSelected;

  const PaymentMethodSection({super.key, this.onMethodSelected});

  @override
  State<PaymentMethodSection> createState() => _PaymentMethodSectionState();
}

class _PaymentMethodSectionState extends State<PaymentMethodSection> {
  String? selectedMethod;
  final TextEditingController _cashController = TextEditingController();
  final TextEditingController _cardController = TextEditingController();
  final TextEditingController _referenceController = TextEditingController();

  @override
  void dispose() {
    _cashController.dispose();
    _cardController.dispose();
    _referenceController.dispose();
    super.dispose();
  }

  void _notifySelection() {
    if (widget.onMethodSelected != null && selectedMethod != null) {
      if (selectedMethod == 'Split') {
        widget.onMethodSelected!(
          selectedMethod!,
          cashAmount: num.tryParse(_cashController.text) ?? 0,
          cardAmount: num.tryParse(_cardController.text) ?? 0,
          referenceNumber: _referenceController.text.isNotEmpty
              ? _referenceController.text
              : null,
        );
      } else if (selectedMethod == 'Card') {
        widget.onMethodSelected!(
          selectedMethod!,
          referenceNumber: _referenceController.text.isNotEmpty
              ? _referenceController.text
              : null,
        );
      } else if (selectedMethod == 'Cash') {
        widget.onMethodSelected!(
          selectedMethod!,
          cashAmount: num.tryParse(_cashController.text) ?? 0,
        );
      } else {
        widget.onMethodSelected!(selectedMethod!);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: ColorsManager.lighterGray),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          // Header
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 6.h),
            decoration: BoxDecoration(
              color: ColorsManager.mainBlue,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(12.r),
                topRight: Radius.circular(12.r),
              ),
            ),
            child: Row(
              children: [
                Icon(Icons.payment, color: Colors.white, size: 20.sp),
                horizontalSpace(4.w),
                Text(
                  'Payment',
                  style: TextStyle(
                    fontSize: 30.sp,
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
          // Content - compact
          Padding(
            padding: EdgeInsets.all(8.w),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Payment method buttons - compact row
                Row(
                  children: [
                    Expanded(
                      child: _buildPaymentMethodCard(
                        'Cash',
                        Icons.payments_outlined,
                        Colors.green,
                      ),
                    ),
                    horizontalSpace(4.w),
                    Expanded(
                      child: _buildPaymentMethodCard(
                        'Card',
                        Icons.credit_card,
                        Colors.blue,
                      ),
                    ),
                    horizontalSpace(4.w),
                    Expanded(
                      child: _buildPaymentMethodCard(
                        'Split',
                        Icons.call_split,
                        Colors.orange,
                      ),
                    ),
                  ],
                ),
                // Input fields - shown directly below
                if (selectedMethod == 'Cash') ...[
                  verticalSpace(8.h),
                  _buildCashAmountField(),
                ],
                if (selectedMethod == 'Card') ...[
                  verticalSpace(8.h),
                  _buildReferenceNumberField(),
                ],
                if (selectedMethod == 'Split') ...[
                  verticalSpace(8.h),
                  _buildSplitPaymentFields(),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildReferenceNumberField() {
    return TextField(
      controller: _referenceController,
      style: TextStyle(fontSize: 13.sp),
      onChanged: (_) => _notifySelection(),
      decoration: InputDecoration(
        labelText: 'Reference Number (Optional)',
        labelStyle: TextStyle(fontSize: 12.sp, color: ColorsManager.gray),
        hintText: 'TXN-12345',
        hintStyle: TextStyle(fontSize: 11.sp, color: ColorsManager.gray),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(6.r)),
        contentPadding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
        isDense: true,
      ),
    );
  }

  Widget _buildCashAmountField() {
    return TextField(
      controller: _cashController,
      keyboardType: TextInputType.number,
      style: TextStyle(fontSize: 13.sp),
      onChanged: (_) => _notifySelection(),
      decoration: InputDecoration(
        labelText: 'Cash Amount',
        labelStyle: TextStyle(fontSize: 12.sp, color: ColorsManager.gray),
        prefixText: '\$ ',
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(6.r)),
        contentPadding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
        isDense: true,
      ),
    );
  }

  Widget _buildSplitPaymentFields() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          children: [
            Expanded(
              child: TextField(
                controller: _cashController,
                keyboardType: TextInputType.number,
                style: TextStyle(fontSize: 13.sp),
                onChanged: (_) => _notifySelection(),
                decoration: InputDecoration(
                  labelText: 'Cash',
                  labelStyle: TextStyle(
                    fontSize: 11.sp,
                    color: ColorsManager.gray,
                  ),
                  prefixText: '\$ ',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(6.r),
                  ),
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 8.w,
                    vertical: 10.h,
                  ),
                  isDense: true,
                ),
              ),
            ),
            horizontalSpace(8.w),
            Expanded(
              child: TextField(
                controller: _cardController,
                keyboardType: TextInputType.number,
                style: TextStyle(fontSize: 13.sp),
                onChanged: (_) => _notifySelection(),
                decoration: InputDecoration(
                  labelText: 'Card',
                  labelStyle: TextStyle(
                    fontSize: 11.sp,
                    color: ColorsManager.gray,
                  ),
                  prefixText: '\$ ',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(6.r),
                  ),
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 8.w,
                    vertical: 10.h,
                  ),
                  isDense: true,
                ),
              ),
            ),
          ],
        ),
        verticalSpace(8.h),
        TextField(
          controller: _referenceController,
          style: TextStyle(fontSize: 13.sp),
          onChanged: (_) => _notifySelection(),
          decoration: InputDecoration(
            labelText: 'Card Ref# (Optional)',
            labelStyle: TextStyle(fontSize: 11.sp, color: ColorsManager.gray),
            hintText: 'TXN-12345',
            hintStyle: TextStyle(fontSize: 11.sp, color: ColorsManager.gray),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(6.r),
            ),
            contentPadding: EdgeInsets.symmetric(
              horizontal: 8.w,
              vertical: 10.h,
            ),
            isDense: true,
          ),
        ),
      ],
    );
  }

  Widget _buildPaymentMethodCard(String label, IconData icon, Color color) {
    bool isSelected = selectedMethod == label;

    return GestureDetector(
      onTap: () {
        setState(() {
          selectedMethod = label;
          if (label == 'Card') {
            _cashController.clear();
            _cardController.clear();
          } else if (label == 'Cash') {
            _cardController.clear();
            _referenceController.clear();
          }
        });
        _notifySelection();
      },
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 6.w),
        decoration: BoxDecoration(
          color: isSelected ? color.withOpacity(0.1) : Colors.white,
          borderRadius: BorderRadius.circular(6.r),
          border: Border.all(
            color: isSelected ? color : ColorsManager.lighterGray,
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, color: color, size: 22.sp),
            verticalSpace(2.h),
            Text(
              label,
              style: TextStyle(
                fontSize: 11.sp,
                color: isSelected ? color : ColorsManager.darkBlue,
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            ),
          ],
        ),
      ),
    );
  }
}
