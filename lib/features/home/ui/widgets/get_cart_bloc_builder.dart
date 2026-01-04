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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Current Sale', style: TextStyles.font18DarkBlueBold),
        BlocBuilder<HomeCubit, HomeState>(
          buildWhen: (previous, current) =>
              current is GetCartLoading ||
              current is GetCartSuccess ||
              current is GetCartError ||
              current is DeleteCartItemLoading ||
              current is DeleteCartItemSuccess ||
              current is DeleteCartItemError,
          builder: (context, state) {
            return state.maybeWhen(
              getCartLoading: () {
                return setupLoading();
              },
              getCartSuccess: (cartData) {
                return setupSuccess(context, cartData);
              },
              getCartError: (errorHandler) {
                return setupError();
              },
              deleteCartItemLoading: () {
                return setupLoading();
              },
              deleteCartItemSuccess: (cartData) {
                return setupSuccess(context, cartData);
              },
              deleteCartItemError: (errorHandler) {
                return setupError();
              },
              orElse: () {
                return const SizedBox.shrink();
              },
            );
          },
        ),
      ],
    );
  }

  Widget setupLoading() {
    return const Center(child: CircularProgressIndicator());
  }

  Widget setupSuccess(BuildContext context, cartData) {
    if (cartData == null || cartData.isEmpty || cartData.first == null) {
      return const Center(child: Text('Cart is empty'));
    }

    final cart = cartData.first!;
    final items = cart.items ?? [];

    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: items.length,
      separatorBuilder: (context, index) => verticalSpace(12.h),
      itemBuilder: (context, index) {
        final item = items[index];
        return Dismissible(
          key: Key(item?.cartItemId ?? index.toString()),
          direction: DismissDirection.endToStart,
          background: Container(
            alignment: Alignment.centerRight,
            padding: EdgeInsets.only(right: 20.w),
            decoration: BoxDecoration(
              color: Colors.red,
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: Icon(Icons.delete, color: Colors.white, size: 100.sp),
          ),
          onDismissed: (direction) {
            if (item?.cartItemId != null) {
              context.read<HomeCubit>().deleteCartItem(item!.cartItemId!);
            }
          },
          child: Container(
            padding: EdgeInsets.all(16.w),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: ColorsManager.lighterGray),
              borderRadius: BorderRadius.circular(8.r),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 4,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Icon(
                    Icons.shopping_cart,
                    color: ColorsManager.gray,
                    size: 100.sp,
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
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      verticalSpace(4.h),
                      Text(
                        'Qty: ${item?.quantity ?? 0} x \$${item?.price ?? '0.00'}',
                        style: TextStyles.font12GrayRegular,
                      ),
                    ],
                  ),
                ),
                horizontalSpace(12.w),
                Text(
                  '\$${item?.subtotal ?? '0.00'}',
                  style: TextStyles.font18DarkBlueBold,
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget setupError() {
    return const Center(child: Text('Error loading cart'));
  }
}
