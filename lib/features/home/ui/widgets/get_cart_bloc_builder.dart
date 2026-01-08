import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pos/core/helpers/spacing.dart';
import 'package:pos/core/theming/colors.dart';
import 'package:pos/core/theming/styles.dart';
import 'package:pos/features/home/logic/cubit/home_cubit.dart';
import 'package:pos/features/home/logic/cubit/home_state.dart';

class GetCartBlocBuilder extends StatelessWidget {
  const GetCartBlocBuilder({super.key});

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
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
            decoration: BoxDecoration(
              color: ColorsManager.darkBlue,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(12.r),
                topRight: Radius.circular(12.r),
              ),
            ),
            child: Row(
              children: [
                Icon(Icons.shopping_cart, color: Colors.white, size: 20.sp),
                horizontalSpace(8.w),
                Text('Current Sale', style: TextStyles.font16WhiteSemiBold),
                const Spacer(),
                BlocBuilder<HomeCubit, HomeState>(
                  builder: (context, state) {
                    int itemCount = 0;
                    state.maybeWhen(
                      getCartSuccess: (cartData) {
                        if (cartData != null &&
                            cartData.isNotEmpty &&
                            cartData.first != null) {
                          itemCount = cartData.first!.items?.length ?? 0;
                        }
                      },
                      addRfidToCartSuccess: (cartData) {
                        if (cartData != null &&
                            cartData.isNotEmpty &&
                            cartData.first != null) {
                          itemCount = cartData.first!.items?.length ?? 0;
                        }
                      },
                      addCustomItemSuccess: (cartData) {
                        if (cartData != null &&
                            cartData.isNotEmpty &&
                            cartData.first != null) {
                          itemCount = cartData.first!.items?.length ?? 0;
                        }
                      },
                      deleteCartItemSuccess: (cartData) {
                        if (cartData != null &&
                            cartData.isNotEmpty &&
                            cartData.first != null) {
                          itemCount = cartData.first!.items?.length ?? 0;
                        }
                      },
                      orElse: () {},
                    );
                    return Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 10.w,
                        vertical: 4.h,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                      child: Text(
                        '$itemCount items',
                        style: TextStyles.font12GrayRegular.copyWith(
                          color: Colors.white,
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
          Expanded(
            child: RefreshIndicator(
              onRefresh: () async {
                context.read<HomeCubit>().getCart();
              },
              child: BlocBuilder<HomeCubit, HomeState>(
                buildWhen: (previous, current) =>
                    current is GetCartLoading ||
                    current is GetCartSuccess ||
                    current is GetCartError ||
                    current is AddRfidToCartSuccess ||
                    current is AddCustomItemLoading ||
                    current is AddCustomItemSuccess ||
                    current is AddCustomItemError ||
                    current is DeleteCartItemLoading ||
                    current is DeleteCartItemSuccess ||
                    current is DeleteCartItemError,
                builder: (context, state) {
                  return state.maybeWhen(
                    getCartLoading: () => setupLoading(),
                    getCartSuccess: (cartData) =>
                        setupSuccess(context, cartData),
                    getCartError: (errorHandler) => setupError(context),
                    addRfidToCartSuccess: (cartData) =>
                        setupSuccess(context, cartData),
                    addCustomItemLoading: () => setupLoading(),
                    addCustomItemSuccess: (cartData) =>
                        setupSuccess(context, cartData),
                    addCustomItemError: (errorHandler) => setupError(context),
                    deleteCartItemLoading: () => setupLoading(),
                    deleteCartItemSuccess: (cartData) =>
                        setupSuccess(context, cartData),
                    deleteCartItemError: (errorHandler) => setupError(context),
                    orElse: () => _buildEmptyCart(context),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyCart(BuildContext context) {
    return ListView(
      physics: const AlwaysScrollableScrollPhysics(),
      children: [
        SizedBox(height: 100.h),
        Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.shopping_cart_outlined,
                size: 48.sp,
                color: ColorsManager.lightGray,
              ),
              verticalSpace(12.h),
              Text('Cart is empty', style: TextStyles.font14GrayRegular),
              verticalSpace(4.h),
              Text('Pull down to refresh', style: TextStyles.font12GrayRegular),
            ],
          ),
        ),
      ],
    );
  }

  Widget setupLoading() {
    return const Center(child: CircularProgressIndicator());
  }

  Widget setupSuccess(BuildContext context, cartData) {
    if (cartData == null || cartData.isEmpty || cartData.first == null) {
      return _buildEmptyCart(context);
    }

    final cart = cartData.first!;
    final items = cart.items ?? [];

    if (items.isEmpty) {
      return _buildEmptyCart(context);
    }

    return ListView.builder(
      padding: EdgeInsets.all(8.w),
      physics: const AlwaysScrollableScrollPhysics(),
      itemCount: items.length,
      itemBuilder: (context, index) {
        final item = items[index];
        return Dismissible(
          key: Key(item?.cartItemId ?? index.toString()),
          direction: DismissDirection.endToStart,
          background: Container(
            alignment: Alignment.centerRight,
            margin: EdgeInsets.symmetric(vertical: 4.h),
            padding: EdgeInsets.only(right: 20.w),
            decoration: BoxDecoration(
              color: Colors.red,
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: Icon(Icons.delete_outline, color: Colors.white, size: 24.sp),
          ),
          onDismissed: (direction) {
            if (item?.cartItemId != null) {
              context.read<HomeCubit>().deleteCartItem(item!.cartItemId!);
            }
          },
          child: Container(
            margin: EdgeInsets.symmetric(vertical: 4.h),
            padding: EdgeInsets.all(12.w),
            decoration: BoxDecoration(
              color: ColorsManager.lighterGray.withOpacity(0.3),
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: Row(
              children: [
                Container(
                  width: 40.w,
                  height: 40.w,
                  decoration: BoxDecoration(
                    color: ColorsManager.mainBlue.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  child: Center(
                    child: Text(
                      '${item?.quantity ?? 1}x',
                      style: TextStyles.font14DarkBlueMedium.copyWith(
                        color: ColorsManager.mainBlue,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                horizontalSpace(12.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        item?.productName ?? '',
                        style: TextStyles.font14DarkBlueMedium,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      verticalSpace(2.h),
                      Text(
                        '\$${item?.price ?? '0.00'}',
                        style: TextStyles.font12GrayRegular,
                      ),
                    ],
                  ),
                ),
                Text(
                  '\$${item?.subtotal ?? '0.00'}',
                  style: TextStyles.font16WhiteSemiBold.copyWith(
                    color: ColorsManager.darkBlue,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget setupError(BuildContext context) {
    return ListView(
      physics: const AlwaysScrollableScrollPhysics(),
      children: [
        SizedBox(height: 100.h),
        Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.error_outline, size: 48.sp, color: Colors.red),
              verticalSpace(12.h),
              Text('Error loading cart', style: TextStyles.font14GrayRegular),
              verticalSpace(4.h),
              Text('Pull down to refresh', style: TextStyles.font12GrayRegular),
            ],
          ),
        ),
      ],
    );
  }
}
