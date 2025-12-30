import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pos/core/helpers/spacing.dart';
import 'package:pos/core/theming/colors.dart';
import 'package:pos/core/theming/styles.dart';

class DiscountPasswordDialog extends StatefulWidget {
  final bool requiresPassword;
  final num maxDiscountPercentage;
  final Future<bool> Function(String password) validatePassword;
  final Function(num discountValue) onPasswordValid;

  const DiscountPasswordDialog({
    super.key,
    required this.requiresPassword,
    required this.maxDiscountPercentage,
    required this.validatePassword,
    required this.onPasswordValid,
  });

  @override
  State<DiscountPasswordDialog> createState() => _DiscountPasswordDialogState();
}

class _DiscountPasswordDialogState extends State<DiscountPasswordDialog> {
  final _passwordController = TextEditingController();
  final _discountController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _obscurePassword = true;
  bool _isValidating = false;
  bool _passwordValidated = false;
  String? _passwordError;
  String? _discountError;

  @override
  void initState() {
    super.initState();
    // If no password required, skip to discount step
    if (!widget.requiresPassword) {
      _passwordValidated = true;
    }
  }

  @override
  void dispose() {
    _passwordController.dispose();
    _discountController.dispose();
    super.dispose();
  }

  Future<void> _validatePassword() async {
    final password = _passwordController.text;
    if (password.isEmpty) {
      setState(() {
        _passwordError = 'Password is required';
      });
      return;
    }

    setState(() {
      _isValidating = true;
      _passwordError = null;
    });

    final isValid = await widget.validatePassword(password);

    setState(() {
      _isValidating = false;
    });

    if (isValid) {
      setState(() {
        _passwordValidated = true;
      });
    } else {
      setState(() {
        _passwordError = 'Invalid password';
      });
    }
  }

  void _applyDiscount() {
    final discountText = _discountController.text;

    if (discountText.isEmpty) {
      setState(() {
        _discountError = 'Discount value is required';
      });
      return;
    }

    final discountValue = num.tryParse(discountText);
    if (discountValue == null) {
      setState(() {
        _discountError = 'Enter a valid number';
      });
      return;
    }

    if (discountValue < 0) {
      setState(() {
        _discountError = 'Discount cannot be negative';
      });
      return;
    }

    if (discountValue > widget.maxDiscountPercentage) {
      setState(() {
        _discountError = 'Max discount is ${widget.maxDiscountPercentage}%';
      });
      return;
    }

    // Clear error and apply
    setState(() {
      _discountError = null;
    });

    Navigator.of(context).pop();
    widget.onPasswordValid(discountValue);
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.r)),
      child: Container(
        padding: EdgeInsets.all(24.w),
        width: 350.w,
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              Row(
                children: [
                  Icon(
                    _passwordValidated ? Icons.discount : Icons.lock,
                    color: Colors.orange,
                    size: 28.sp,
                  ),
                  horizontalSpace(12.w),
                  Text(
                    _passwordValidated ? 'Apply Discount' : 'Enter Password',
                    style: TextStyles.font18DarkBlueBold,
                  ),
                ],
              ),
              verticalSpace(24.h),

              // Step 1: Password input (if not yet validated)
              if (!_passwordValidated) ...[
                Text(
                  'Enter Discount Password',
                  style: TextStyles.font14DarkBlueMedium,
                ),
                verticalSpace(8.h),
                TextFormField(
                  controller: _passwordController,
                  obscureText: _obscurePassword,
                  autofocus: true,
                  decoration: InputDecoration(
                    hintText: 'Password',
                    prefixIcon: const Icon(Icons.lock),
                    suffixIcon: IconButton(
                      icon: Icon(
                        _obscurePassword
                            ? Icons.visibility_off
                            : Icons.visibility,
                      ),
                      onPressed: () {
                        setState(() {
                          _obscurePassword = !_obscurePassword;
                        });
                      },
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                    errorText: _passwordError,
                  ),
                  onChanged: (_) {
                    if (_passwordError != null) {
                      setState(() {
                        _passwordError = null;
                      });
                    }
                  },
                  onFieldSubmitted: (_) => _validatePassword(),
                ),
                verticalSpace(24.h),

                // Password buttons
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () => Navigator.of(context).pop(),
                        style: OutlinedButton.styleFrom(
                          padding: EdgeInsets.symmetric(vertical: 14.h),
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
                        onPressed: _isValidating ? null : _validatePassword,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: ColorsManager.darkBlue,
                          padding: EdgeInsets.symmetric(vertical: 14.h),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.r),
                          ),
                        ),
                        child: _isValidating
                            ? SizedBox(
                                width: 20.w,
                                height: 20.h,
                                child: const CircularProgressIndicator(
                                  strokeWidth: 2,
                                  color: Colors.white,
                                ),
                              )
                            : Text(
                                'Verify',
                                style: TextStyles.font14WhiteSemiBold,
                              ),
                      ),
                    ),
                  ],
                ),
              ],

              // Step 2: Discount input (after password validated)
              if (_passwordValidated) ...[
                // Success indicator if password was required
                if (widget.requiresPassword) ...[
                  Container(
                    padding: EdgeInsets.all(12.w),
                    decoration: BoxDecoration(
                      color: Colors.green.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(8.r),
                      border: Border.all(color: Colors.green.withOpacity(0.3)),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.check_circle,
                          color: Colors.green,
                          size: 20.sp,
                        ),
                        horizontalSpace(8.w),
                        Text(
                          'Password verified',
                          style: TextStyles.font14DarkBlueMedium.copyWith(
                            color: Colors.green,
                          ),
                        ),
                      ],
                    ),
                  ),
                  verticalSpace(16.h),
                ],

                Text(
                  'Discount Percentage',
                  style: TextStyles.font14DarkBlueMedium,
                ),
                verticalSpace(8.h),
                TextFormField(
                  controller: _discountController,
                  keyboardType: TextInputType.number,
                  autofocus: true,
                  decoration: InputDecoration(
                    hintText: 'Enter discount %',
                    prefixIcon: const Icon(Icons.percent),
                    suffixText: '%',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                    helperText: 'Max: ${widget.maxDiscountPercentage}%',
                    errorText: _discountError,
                  ),
                  onChanged: (_) {
                    if (_discountError != null) {
                      setState(() {
                        _discountError = null;
                      });
                    }
                  },
                  onFieldSubmitted: (_) => _applyDiscount(),
                ),
                verticalSpace(24.h),

                // Discount buttons
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () => Navigator.of(context).pop(),
                        style: OutlinedButton.styleFrom(
                          padding: EdgeInsets.symmetric(vertical: 14.h),
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
                        onPressed: _applyDiscount,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.orange,
                          padding: EdgeInsets.symmetric(vertical: 14.h),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.r),
                          ),
                        ),
                        child: Text(
                          'Apply Discount',
                          style: TextStyles.font14WhiteSemiBold,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
