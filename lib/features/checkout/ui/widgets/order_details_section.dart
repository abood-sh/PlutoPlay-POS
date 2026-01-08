import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pos/core/helpers/spacing.dart';
import 'package:pos/core/theming/colors.dart';
import 'package:pos/core/theming/styles.dart';
import 'package:pos/features/checkout/logic/cubit/checkout_cubit.dart';
import 'package:pos/features/checkout/logic/cubit/checkout_state.dart';
import 'package:pos/features/checkout/ui/widgets/discount_password_dialog.dart';

class OrderDetailsSection extends StatelessWidget {
  final num subtotal;
  final num taxAmount;
  final num discountAmount;
  final num total;

  const OrderDetailsSection({
    super.key,
    required this.subtotal,
    required this.taxAmount,
    required this.discountAmount,
    required this.total,
  });

  void _showDiscountDialog(BuildContext context) {
    final cubit = context.read<CheckoutCubit>();

    // First get system settings to check password requirement
    cubit.requestDiscountWithPassword();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<CheckoutCubit, CheckoutState>(
      listener: (context, state) {
        state.maybeWhen(
          passwordRequired: (settings) {
            // Determine if password is required
            final hasPassword =
                settings.discountPassword != null &&
                settings.discountPassword!.isNotEmpty;

            // Show password dialog
            showDialog(
              context: context,
              barrierDismissible: false,
              builder: (dialogContext) => DiscountPasswordDialog(
                requiresPassword: hasPassword,
                maxDiscountPercentage:
                    settings.maxDiscountPercentage?.toDouble() ?? 100,
                validatePassword: (password) =>
                    context.read<CheckoutCubit>().validatePassword(password),
                onPasswordValid: (discountValue) {
                  // Apply discount
                  context.read<CheckoutCubit>().applyDiscount(discountValue);
                },
              ),
            ).then((_) {
              // Reset state when dialog is closed (cancelled)
              context.read<CheckoutCubit>().refreshLoadedState();
            });
          },
          discountApplied: (cartData) {
            // Show success message
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Discount applied successfully'),
                backgroundColor: Colors.green,
              ),
            );
            // Refresh the loaded state
            context.read<CheckoutCubit>().refreshLoadedState();
          },
          discountError: (error) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(error.message ?? 'Failed to apply discount'),
                backgroundColor: Colors.red,
              ),
            );
            context.read<CheckoutCubit>().refreshLoadedState();
          },
          settingsError: (error) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(error.message ?? 'Failed to load settings'),
                backgroundColor: Colors.red,
              ),
            );
            context.read<CheckoutCubit>().refreshLoadedState();
          },
          orElse: () {},
        );
      },
      child: Container(
        padding: EdgeInsets.all(12.w),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8.r),
          border: Border.all(color: ColorsManager.lighterGray),
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  Icon(Icons.receipt_long, color: Colors.orange, size: 18.sp),
                  horizontalSpace(6.w),
                  Expanded(
                    child: Text(
                      'Order Details',
                      style: TextStyles.font14DarkBlueMedium.copyWith(
                        color: Colors.orange,
                        fontWeight: FontWeight.bold,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
              verticalSpace(10.h),
              _buildDetailRow(
                Icons.list,
                'Subtotal',
                '\$${subtotal.toStringAsFixed(2)}',
                false,
              ),
              verticalSpace(8.h),
              _buildDiscountRow(context),
              Divider(height: 16.h),
              _buildTotalRow(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDetailRow(
    IconData icon,
    String label,
    String value,
    bool isEditable,
  ) {
    return Row(
      children: [
        Icon(icon, color: ColorsManager.gray, size: 18.sp),
        horizontalSpace(8.w),
        Text(label, style: TextStyles.font14GrayRegular),
        const Spacer(),
        if (isEditable)
          SizedBox(
            width: 80.w,
            child: TextField(
              textAlign: TextAlign.right,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                hintText: value,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(4.r),
                  borderSide: BorderSide(color: ColorsManager.lighterGray),
                ),
                contentPadding: EdgeInsets.symmetric(
                  horizontal: 8.w,
                  vertical: 8.h,
                ),
              ),
              style: TextStyles.font14DarkBlueMedium,
            ),
          )
        else
          Text(value, style: TextStyles.font14DarkBlueMedium),
      ],
    );
  }

  Widget _buildDiscountRow(BuildContext context) {
    return Row(
      children: [
        Icon(Icons.discount, color: Colors.red, size: 18.sp),
        horizontalSpace(8.w),
        Text('Discount', style: TextStyles.font14GrayRegular),
        const Spacer(),
        // Add discount button
        BlocBuilder<CheckoutCubit, CheckoutState>(
          buildWhen: (previous, current) =>
              current is SettingsLoading || current is CheckoutLoaded,
          builder: (context, state) {
            final isLoading = state is SettingsLoading;
            return ElevatedButton.icon(
              onPressed: isLoading ? null : () => _showDiscountDialog(context),
              icon: isLoading
                  ? SizedBox(
                      width: 16.w,
                      height: 16.w,
                      child: const CircularProgressIndicator(
                        strokeWidth: 2,
                        color: Colors.white,
                      ),
                    )
                  : Icon(Icons.add, size: 16.sp),
              label: Text(
                isLoading ? 'Loading...' : 'Add',
                style: TextStyles.font12GrayRegular.copyWith(
                  color: Colors.white,
                ),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orange,
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4.r),
                ),
              ),
            );
          },
        ),
        horizontalSpace(8.w),
        Text(
          '-\$${discountAmount.toStringAsFixed(2)}',
          style: TextStyles.font14DarkBlueMedium.copyWith(color: Colors.red),
        ),
      ],
    );
  }

  Widget _buildTotalRow() {
    return Row(
      children: [
        Icon(Icons.check_circle, color: Colors.green, size: 20.sp),
        horizontalSpace(8.w),
        Text('Order Total', style: TextStyles.font18DarkBlueBold),
        const Spacer(),
        Text(
          '\$${total.toStringAsFixed(2)}',
          style: TextStyles.font18DarkBlueBold.copyWith(
            color: ColorsManager.mainBlue,
          ),
        ),
      ],
    );
  }
}
