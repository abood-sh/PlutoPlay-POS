// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'add_rfid_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AddRfidResponse _$AddRfidResponseFromJson(Map<String, dynamic> json) =>
    AddRfidResponse(
      success: json['success'] as bool?,
      message: json['message'] as String?,
      data: json['data'] == null
          ? null
          : CartData.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$AddRfidResponseToJson(AddRfidResponse instance) =>
    <String, dynamic>{
      'success': instance.success,
      'message': instance.message,
      'data': instance.data,
    };
