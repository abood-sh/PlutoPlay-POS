import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pos/core/theming/colors.dart';

/// Dialog for collecting cash portion in split payments
class CashCollectionDialog extends StatefulWidget {
  final double cashAmount;
  final double cardAmount;
  final Function(double cashReceived) onConfirm;

  const CashCollectionDialog({
    super.key,
    required this.cashAmount,
    required this.cardAmount,
    required this.onConfirm,
  });

  @override
  State<CashCollectionDialog> createState() => _CashCollectionDialogState();
}

class _CashCollectionDialogState extends State<CashCollectionDialog> {
  final _controller = TextEditingController();

  double get cashReceived => double.tryParse(_controller.text) ?? 0;
  double get change => cashReceived - widget.cashAmount;
  bool get isValid => cashReceived >= widget.cashAmount;

  @override
  void initState() {
    super.initState();
    _controller.text = widget.cashAmount.toStringAsFixed(2);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.r)),
      child: Container(
        width: 380.w,
        padding: EdgeInsets.all(24.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Header with success icon
            Row(
              children: [
                Container(
                  padding: EdgeInsets.all(8.w),
                  decoration: BoxDecoration(
                    color: Colors.green[100],
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.check_circle,
                    size: 28.sp,
                    color: Colors.green[700],
                  ),
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Card Payment Successful!',
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.bold,
                          color: Colors.green[700],
                        ),
                      ),
                      Text(
                        '\$${widget.cardAmount.toStringAsFixed(2)} charged to card',
                        style: TextStyle(
                          fontSize: 12.sp,
                          color: ColorsManager.gray,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 20.h),

            // Divider
            Divider(color: ColorsManager.lighterGray),
            SizedBox(height: 16.h),

            // Cash Collection Section
            Row(
              children: [
                Icon(Icons.payments, size: 24.sp, color: Colors.green),
                SizedBox(width: 8.w),
                Text(
                  'Collect Cash',
                  style: TextStyle(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            SizedBox(height: 16.h),

            // Amount Due
            Container(
              padding: EdgeInsets.all(16.w),
              decoration: BoxDecoration(
                color: Colors.green[50],
                borderRadius: BorderRadius.circular(12.r),
                border: Border.all(color: Colors.green[200]!),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Cash Due:', style: TextStyle(fontSize: 16.sp)),
                  Text(
                    '\$${widget.cashAmount.toStringAsFixed(2)}',
                    style: TextStyle(
                      fontSize: 24.sp,
                      fontWeight: FontWeight.bold,
                      color: Colors.green[700],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 16.h),

            // Cash Received Input
            TextField(
              controller: _controller,
              keyboardType: const TextInputType.numberWithOptions(decimal: true),
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d{0,2}')),
              ],
              style: TextStyle(fontSize: 24.sp, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
              decoration: InputDecoration(
                labelText: 'Cash Received',
                prefixText: '\$ ',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.r),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.r),
                  borderSide: BorderSide(color: ColorsManager.mainBlue, width: 2),
                ),
              ),
              onChanged: (_) => setState(() {}),
            ),
            SizedBox(height: 12.h),

            // Quick Amount Buttons
            Wrap(
              spacing: 8.w,
              runSpacing: 8.h,
              alignment: WrapAlignment.center,
              children: [
                _buildQuickButton('Exact', widget.cashAmount),
                _buildQuickButton('\$20', 20),
                _buildQuickButton('\$50', 50),
                _buildQuickButton('\$100', 100),
              ],
            ),
            SizedBox(height: 16.h),

            // Change Display
            if (isValid)
              Container(
                padding: EdgeInsets.all(16.w),
                decoration: BoxDecoration(
                  color: Colors.blue[50],
                  borderRadius: BorderRadius.circular(12.r),
                  border: Border.all(color: Colors.blue[300]!),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.reply, color: Colors.blue[700], size: 20.sp),
                        SizedBox(width: 8.w),
                        Text(
                          'Change:',
                          style: TextStyle(
                            fontSize: 16.sp,
                            color: Colors.blue[700],
                          ),
                        ),
                      ],
                    ),
                    Text(
                      '\$${change.toStringAsFixed(2)}',
                      style: TextStyle(
                        fontSize: 24.sp,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue[700],
                      ),
                    ),
                  ],
                ),
              ),

            if (!isValid)
              Container(
                padding: EdgeInsets.all(12.w),
                decoration: BoxDecoration(
                  color: Colors.red[50],
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Row(
                  children: [
                    Icon(Icons.warning, color: Colors.red[700], size: 18.sp),
                    SizedBox(width: 8.w),
                    Expanded(
                      child: Text(
                        'Amount must be at least \$${widget.cashAmount.toStringAsFixed(2)}',
                        style: TextStyle(color: Colors.red[700], fontSize: 12.sp),
                      ),
                    ),
                  ],
                ),
              ),
            SizedBox(height: 20.h),

            // Confirm Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: isValid
                    ? () {
                        Navigator.pop(context);
                        widget.onConfirm(cashReceived);
                      }
                    : null,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  disabledBackgroundColor: Colors.grey[300],
                  padding: EdgeInsets.symmetric(vertical: 16.h),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                ),
                child: Text(
                  'Complete Payment',
                  style: TextStyle(
                    fontSize: 18.sp,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildQuickButton(String label, double amount) {
    return InkWell(
      onTap: () {
        _controller.text = amount.toStringAsFixed(2);
        setState(() {});
      },
      borderRadius: BorderRadius.circular(8.r),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
        decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.circular(8.r),
          border: Border.all(color: Colors.grey[400]!),
        ),
        child: Text(
          label,
          style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w500),
        ),
      ),
    );
  }
}
