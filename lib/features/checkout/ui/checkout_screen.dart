import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pos/core/helpers/spacing.dart';
import 'package:pos/features/checkout/logic/cubit/checkout_cubit.dart';
import 'package:pos/features/checkout/logic/cubit/checkout_state.dart';
import 'package:pos/features/checkout/ui/widgets/checkout_header.dart';
import 'package:pos/features/checkout/ui/widgets/order_details_section.dart';
import 'package:pos/features/checkout/ui/widgets/order_items_section.dart';
import 'package:pos/features/checkout/ui/widgets/payment_method_section.dart';
import 'package:pos/features/checkout/ui/widgets/payment_summary_section.dart';

class CheckoutScreen extends StatelessWidget {
  const CheckoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocBuilder<CheckoutCubit, CheckoutState>(
          buildWhen: (previous, current) {
            // Only rebuild for loaded state, ignore discount-related states
            return current.maybeWhen(
              loaded: (_) => true,
              initial: () => true,
              orElse: () => false,
            );
          },
          builder: (context, state) {
            final cubit = context.read<CheckoutCubit>();
            // Check if cart data exists in cubit
            if (cubit.cartData != null) {
              return LayoutBuilder(
                builder: (context, constraints) {
                  bool isTablet = constraints.maxWidth > 600;

                  if (isTablet) {
                    return _buildTabletLayout(context);
                  } else {
                    return _buildMobileLayout(context);
                  }
                },
              );
            }
            return const Center(child: Text('No cart data available'));
          },
        ),
      ),
    );
  }

  Widget _buildMobileLayout(BuildContext context) {
    final cubit = context.read<CheckoutCubit>();
    return Column(
      children: [
        const CheckoutHeader(),
        Expanded(
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(16.w),
              child: Column(
                children: [
                  OrderItemsSection(items: cubit.items),
                  verticalSpace(24.h),
                  OrderDetailsSection(
                    subtotal: cubit.subtotal,
                    taxAmount: cubit.taxAmount,
                    discountAmount: cubit.discountAmount,
                    total: cubit.total,
                  ),
                  verticalSpace(24.h),
                  PaymentSummarySection(
                    subtotal: cubit.subtotal,
                    taxAmount: cubit.taxAmount,
                    discountAmount: cubit.discountAmount,
                    total: cubit.total,
                  ),
                  verticalSpace(24.h),
                  const PaymentMethodSection(),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildTabletLayout(BuildContext context) {
    final cubit = context.read<CheckoutCubit>();
    return Column(
      children: [
        const CheckoutHeader(),
        Expanded(
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(24.w),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 3,
                    child: Column(
                      children: [
                        OrderItemsSection(items: cubit.items),
                        verticalSpace(24.h),
                        OrderDetailsSection(
                          subtotal: cubit.subtotal,
                          taxAmount: cubit.taxAmount,
                          discountAmount: cubit.discountAmount,
                          total: cubit.total,
                        ),
                      ],
                    ),
                  ),
                  horizontalSpace(24.w),
                  Expanded(
                    flex: 2,
                    child: Column(
                      children: [
                        PaymentSummarySection(
                          subtotal: cubit.subtotal,
                          taxAmount: cubit.taxAmount,
                          discountAmount: cubit.discountAmount,
                          total: cubit.total,
                        ),
                        verticalSpace(24.h),
                        const PaymentMethodSection(),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
