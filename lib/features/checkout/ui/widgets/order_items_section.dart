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
              Icon(Icons.shopping_cart, color: Colors.orange, size: 20.sp),
              horizontalSpace(8.w),
              Text(
                'Order Items',
                style: TextStyles.font16WhiteSemiBold.copyWith(
                  color: Colors.orange,
                ),
              ),
              horizontalSpace(8.w),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 2.h),
                decoration: BoxDecoration(
                  color: Colors.orange,
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
          verticalSpace(16.h),
          if (items.isEmpty)
            Center(
              child: Text(
                'No items in cart',
                style: TextStyles.font14DarkBlueMedium,
              ),
            )
          else
            ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: items.length,
              separatorBuilder: (context, index) => verticalSpace(8.h),
              itemBuilder: (context, index) {
                return _buildOrderItem(items[index]);
              },
            ),
        ],
      ),
    );
  }

  Widget _buildOrderItem(CartItemModel item) {
    final price = double.tryParse(item.price ?? '0') ?? 0;
    final subtotal = double.tryParse(item.subtotal ?? '0') ?? 0;

    return Container(
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: ColorsManager.lighterGray.withOpacity(0.3),
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
            decoration: BoxDecoration(
              color: ColorsManager.darkBlue,
              borderRadius: BorderRadius.circular(4.r),
            ),
            child: Text(
              item.type ?? 'Product',
              style: TextStyles.font12GrayRegular.copyWith(color: Colors.white),
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
                ),
                verticalSpace(4.h),
                if (item.rfidTagId != null)
                  Text(
                    'RFID: ${item.rfidTagId}',
                    style: TextStyles.font12GrayRegular,
                  ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                '\$${subtotal.toStringAsFixed(2)}',
                style: TextStyles.font18DarkBlueBold.copyWith(
                  color: Colors.orange,
                ),
              ),
              verticalSpace(4.h),
              Text(
                'Qty: ${item.quantity ?? 0} x \$${price.toStringAsFixed(2)}',
                style: TextStyles.font12GrayRegular,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
