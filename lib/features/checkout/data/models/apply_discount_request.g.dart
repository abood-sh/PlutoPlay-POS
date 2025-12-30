// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'apply_discount_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ApplyDiscountRequest _$ApplyDiscountRequestFromJson(
  Map<String, dynamic> json,
) => ApplyDiscountRequest(
  type: json['type'] as String,
  value: json['value'] as num,
);

Map<String, dynamic> _$ApplyDiscountRequestToJson(
  ApplyDiscountRequest instance,
) => <String, dynamic>{'type': instance.type, 'value': instance.value};
