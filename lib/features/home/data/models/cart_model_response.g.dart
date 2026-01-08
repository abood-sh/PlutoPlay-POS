// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cart_model_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CartResponseModel _$CartResponseModelFromJson(Map<String, dynamic> json) =>
    CartResponseModel(
      success: json['success'] as bool?,
      data: json['data'] == null
          ? null
          : CartData.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$CartResponseModelToJson(CartResponseModel instance) =>
    <String, dynamic>{'success': instance.success, 'data': instance.data};

CartData _$CartDataFromJson(Map<String, dynamic> json) => CartData(
  items: (json['items'] as List<dynamic>?)
      ?.map((e) => CartItemModel.fromJson(e as Map<String, dynamic>))
      .toList(),
  customerId: json['customer_id'] as String?,
  subtotal: json['subtotal'] as num?,
  discountAmount: json['discount_amount'] as num?,
  discountType: json['discount_type'] as String?,
  discountValue: json['discount_value'] as num?,
  taxAmount: json['tax_amount'] as num?,
  taxRate: json['tax_rate'] as num?,
  total: json['total'] as num?,
  itemsCount: (json['items_count'] as num?)?.toInt(),
);

Map<String, dynamic> _$CartDataToJson(CartData instance) => <String, dynamic>{
  'items': instance.items,
  'customer_id': instance.customerId,
  'subtotal': instance.subtotal,
  'discount_amount': instance.discountAmount,
  'discount_type': instance.discountType,
  'discount_value': instance.discountValue,
  'tax_amount': instance.taxAmount,
  'tax_rate': instance.taxRate,
  'total': instance.total,
  'items_count': instance.itemsCount,
};

CartItemModel _$CartItemModelFromJson(Map<String, dynamic> json) =>
    CartItemModel(
      cartItemId: json['cart_item_id'] as String?,
      type: json['type'] as String?,
      productName: json['product_name'] as String?,
      price: CartItemModel._numToString(json['price']),
      quantity: (json['quantity'] as num?)?.toInt(),
      subtotal: CartItemModel._numToString(json['subtotal']),
      rfidTagId: json['rfid_tag_id'] as String?,
      conditionType: json['condition_type'] as String?,
    );

Map<String, dynamic> _$CartItemModelToJson(CartItemModel instance) =>
    <String, dynamic>{
      'type': instance.type,
      'cart_item_id': instance.cartItemId,
      'product_name': instance.productName,
      'price': instance.price,
      'quantity': instance.quantity,
      'subtotal': instance.subtotal,
      'rfid_tag_id': instance.rfidTagId,
      'condition_type': instance.conditionType,
    };
