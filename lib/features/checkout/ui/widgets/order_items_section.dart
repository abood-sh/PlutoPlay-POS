import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pos/core/helpers/spacing.dart';
import 'package:pos/core/theming/colors.dart';
import 'package:pos/core/theming/styles.dart';
import 'package:pos/features/home/data/models/cart_model_response.dart';

class OrderItemsSection extends StatelessWidget {
  final List<CartItemModel> items;

  const OrderItemsSection({super.key, required this.items});

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
                Icon(Icons.receipt_long, color: Colors.white, size: 20.sp),
                horizontalSpace(8.w),
                Text('Order Items', style: TextStyles.font16WhiteSemiBold),
                const Spacer(),
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 10.w,
                    vertical: 4.h,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  child: Text(
                    '${items.length} ${items.length == 1 ? 'item' : 'items'}',
                    style: TextStyles.font12GrayRegular.copyWith(
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
          if (items.isEmpty)
            Expanded(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.shopping_cart_outlined,
                      size: 48.sp,
                      color: ColorsManager.lightGray,
                    ),
                    verticalSpace(8.h),
                    Text(
                      'No items in cart',
                      style: TextStyles.font14GrayRegular,
                    ),
                  ],
                ),
              ),
            )
          else
            Expanded(
              child: ListView.builder(
                padding: EdgeInsets.all(8.w),
                physics: const AlwaysScrollableScrollPhysics(),
                itemCount: items.length,
                itemBuilder: (context, index) {
                  return _buildOrderItem(items[index]);
                },
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildOrderItem(CartItemModel item) {
    final price = double.tryParse(item.price ?? '0') ?? 0;
    final subtotal = double.tryParse(item.subtotal ?? '0') ?? 0;

    return Container(
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
                '${item.quantity ?? 1}x',
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
                  item.productName ?? 'Unknown Product',
                  style: TextStyles.font14DarkBlueMedium,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                verticalSpace(2.h),
                Text(
                  '\$${price.toStringAsFixed(2)}',
                  style: TextStyles.font12GrayRegular,
                ),
              ],
            ),
          ),
          Text(
            '\$${subtotal.toStringAsFixed(2)}',
            style: TextStyles.font16WhiteSemiBold.copyWith(
              color: ColorsManager.darkBlue,
            ),
          ),
        ],
      ),
    );
  }
}
