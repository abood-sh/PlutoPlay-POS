// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'add_custom_item_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AddCustomItemRequest _$AddCustomItemRequestFromJson(
  Map<String, dynamic> json,
) => AddCustomItemRequest(
  name: json['name'] as String,
  price: json['price'] as num,
  quantity: (json['quantity'] as num).toInt(),
  barcode: json['barcode'] as String?,
  description: json['description'] as String?,
);

Map<String, dynamic> _$AddCustomItemRequestToJson(
  AddCustomItemRequest instance,
) => <String, dynamic>{
  'name': instance.name,
  'price': instance.price,
  'quantity': instance.quantity,
  'barcode': instance.barcode,
  'description': instance.description,
};
