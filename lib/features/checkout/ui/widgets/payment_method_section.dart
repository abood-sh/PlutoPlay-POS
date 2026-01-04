import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pos/core/helpers/spacing.dart';
import 'package:pos/core/theming/colors.dart';
import 'package:pos/core/theming/styles.dart';

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
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8.r),
        border: Border.all(color: ColorsManager.lighterGray),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.payment, color: ColorsManager.darkBlue, size: 20.sp),
              horizontalSpace(3.w),
              Expanded(
                child: Text(
                  'Payment Method',
                  style: TextStyles.font16WhiteSemiBold.copyWith(
                    color: ColorsManager.darkBlue,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          verticalSpace(16.h),
          GridView.count(
            crossAxisCount: 3,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            mainAxisSpacing: 12.h,
            crossAxisSpacing: 12.w,
            childAspectRatio: 1.0,
            children: [
              _buildPaymentMethodCard('Cash', Icons.money, Colors.green),
              _buildPaymentMethodCard('Card', Icons.credit_card, Colors.blue),
              _buildPaymentMethodCard('Split', Icons.call_split, Colors.orange),
            ],
          ),
          if (selectedMethod == 'Cash') ...[
            verticalSpace(16.h),
            _buildCashAmountField(),
          ],
          if (selectedMethod == 'Card') ...[
            verticalSpace(16.h),
            _buildReferenceNumberField(),
          ],
          if (selectedMethod == 'Split') ...[
            verticalSpace(16.h),
            _buildSplitPaymentFields(),
          ],
        ],
      ),
    );
  }

  Widget _buildReferenceNumberField() {
    return TextField(
      controller: _referenceController,
      style: TextStyle(fontSize: 80.sp),
      onChanged: (_) => _notifySelection(),
      decoration: InputDecoration(
        labelText: 'Reference Number (Optional)',
        labelStyle: TextStyles.font14GrayRegular,
        hintText: 'TXN-12345',
        hintStyle: TextStyles.font12GrayRegular,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8.r)),
        contentPadding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
      ),
    );
  }

  Widget _buildCashAmountField() {
    return TextField(
      controller: _cashController,
      keyboardType: TextInputType.number,
      style: TextStyle(fontSize: 80.sp),
      onChanged: (_) => _notifySelection(),
      decoration: InputDecoration(
        labelText: 'Cash Amount',
        labelStyle: TextStyles.font14GrayRegular,
        prefixText: '\$ ',
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8.r)),
        contentPadding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
      ),
    );
  }

  Widget _buildSplitPaymentFields() {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: TextField(
                controller: _cashController,
                keyboardType: TextInputType.number,
                style: TextStyle(fontSize: 80.sp),
                onChanged: (_) => _notifySelection(),
                decoration: InputDecoration(
                  labelText: 'Cash Amount',
                  labelStyle: TextStyles.font14GrayRegular,
                  prefixText: '\$ ',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 12.w,
                    vertical: 12.h,
                  ),
                ),
              ),
            ),
            horizontalSpace(12.w),
            Expanded(
              child: TextField(
                controller: _cardController,
                keyboardType: TextInputType.number,
                style: TextStyle(fontSize: 80.sp),
                onChanged: (_) => _notifySelection(),
                decoration: InputDecoration(
                  labelText: 'Card Amount',
                  labelStyle: TextStyles.font14GrayRegular,
                  prefixText: '\$ ',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 12.w,
                    vertical: 12.h,
                  ),
                ),
              ),
            ),
          ],
        ),
        verticalSpace(12.h),
        TextField(
          controller: _referenceController,
          style: TextStyle(fontSize: 80.sp),
          onChanged: (_) => _notifySelection(),
          decoration: InputDecoration(
            labelText: 'Card Reference Number (Optional)',
            labelStyle: TextStyles.font14GrayRegular,
            hintText: 'TXN-12345',
            hintStyle: TextStyles.font12GrayRegular,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.r),
            ),
            contentPadding: EdgeInsets.symmetric(
              horizontal: 12.w,
              vertical: 12.h,
            ),
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
        decoration: BoxDecoration(
          color: isSelected ? color.withOpacity(0.1) : Colors.white,
          borderRadius: BorderRadius.circular(8.r),
          border: Border.all(
            color: isSelected ? color : ColorsManager.lighterGray,
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, color: color, size: 100.sp),
            verticalSpace(4.h),
            Text(
              label,
              style: TextStyles.font12GrayRegular.copyWith(
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
