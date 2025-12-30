// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'apply_discount_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ApplyDiscountResponse _$ApplyDiscountResponseFromJson(
  Map<String, dynamic> json,
) => ApplyDiscountResponse(
  success: json['success'] as bool?,
  message: json['message'] as String?,
  data: json['data'] == null
      ? null
      : CartData.fromJson(json['data'] as Map<String, dynamic>),
);

Map<String, dynamic> _$ApplyDiscountResponseToJson(
  ApplyDiscountResponse instance,
) => <String, dynamic>{
  'success': instance.success,
  'message': instance.message,
  'data': instance.data,
};
