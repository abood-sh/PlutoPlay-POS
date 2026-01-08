import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pos/core/helpers/extension.dart';
import 'package:pos/core/helpers/spacing.dart';
import 'package:pos/core/theming/colors.dart';
import 'package:pos/core/theming/styles.dart';
import 'package:pos/features/home/logic/cubit/home_cubit.dart';
import 'package:pos/features/home/logic/cubit/home_state.dart';
import 'package:pos/features/home/data/models/cart_model_response.dart';

class SummarySection extends StatelessWidget {
  const SummarySection({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      buildWhen: (previous, current) =>
          current is GetCartSuccess ||
          current is GetCartLoading ||
          current is AddRfidToCartSuccess ||
          current is AddCustomItemSuccess ||
          current is DeleteCartItemSuccess,
      builder: (context, state) {
        return state.maybeWhen(
          getCartSuccess: (cartData) {
            if (cartData == null ||
                cartData.isEmpty ||
                cartData.first == null) {
              return _buildSummaryContent(0, 0, 0, context, null);
            }
            final cart = cartData.first!;
            return _buildSummaryContent(
              cart.subtotal ?? 0,
              cart.taxAmount ?? 0,
              cart.total ?? 0,
              context,
              cart,
            );
          },
          addRfidToCartSuccess: (cartData) {
            if (cartData == null ||
                cartData.isEmpty ||
                cartData.first == null) {
              return _buildSummaryContent(0, 0, 0, context, null);
            }
            final cart = cartData.first!;
            return _buildSummaryContent(
              cart.subtotal ?? 0,
              cart.taxAmount ?? 0,
              cart.total ?? 0,
              context,
              cart,
            );
          },
          addCustomItemSuccess: (cartData) {
            if (cartData == null ||
                cartData.isEmpty ||
                cartData.first == null) {
              return _buildSummaryContent(0, 0, 0, context, null);
            }
            final cart = cartData.first!;
            return _buildSummaryContent(
              cart.subtotal ?? 0,
              cart.taxAmount ?? 0,
              cart.total ?? 0,
              context,
              cart,
            );
          },
          deleteCartItemSuccess: (cartData) {
            if (cartData == null ||
                cartData.isEmpty ||
                cartData.first == null) {
              return _buildSummaryContent(0, 0, 0, context, null);
            }
            final cart = cartData.first!;
            return _buildSummaryContent(
              cart.subtotal ?? 0,
              cart.taxAmount ?? 0,
              cart.total ?? 0,
              context,
              cart,
            );
          },
          orElse: () => _buildSummaryContent(0, 0, 0, context, null),
        );
      },
    );
  }

  Widget _buildSummaryContent(
    num subtotal,
    num tax,
    num total,
    BuildContext context,
    CartData? cartData,
  ) {
    final hasItems = cartData != null && (cartData.items?.isNotEmpty ?? false);

    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: ColorsManager.lighterGray),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          // Price breakdown
          _buildPriceRow('Subtotal', subtotal),
          verticalSpace(8.h),
          _buildPriceRow('Tax', tax),
          verticalSpace(8.h),
          Divider(color: ColorsManager.lighterGray, height: 1),
          verticalSpace(12.h),
          // Total
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Total', style: TextStyles.font18DarkBlueBold),
              Text(
                '\$${total.toStringAsFixed(2)}',
                style: TextStyles.font24BlueBold,
              ),
            ],
          ),
          verticalSpace(16.h),
          // Checkout button
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: hasItems
                  ? () {
                      context.pushNamed('/checkoutScreen', arguments: cartData);
                    }
                  : null,
              style: ElevatedButton.styleFrom(
                backgroundColor: hasItems
                    ? Colors.green
                    : ColorsManager.lightGray,
                padding: EdgeInsets.symmetric(vertical: 16.h),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.r),
                ),
                elevation: hasItems ? 2 : 0,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.payment, color: Colors.white, size: 20.sp),
                  horizontalSpace(8.w),
                  Text(
                    'Proceed to Checkout',
                    style: TextStyles.font16WhiteSemiBold,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPriceRow(String label, num value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: TextStyles.font14GrayRegular),
        Text(
          '\$${value.toStringAsFixed(2)}',
          style: TextStyles.font14DarkBlueMedium,
        ),
      ],
    );
  }
}
