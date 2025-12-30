// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_req_body.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LoginRequestBody _$LoginRequestBodyFromJson(Map<String, dynamic> json) =>
    LoginRequestBody(
      email: json['email'] as String,
      password: json['password'] as String,
      deviceName: json['device_name'] as String,
      deviceId: json['device_id'] as String,
    );

Map<String, dynamic> _$LoginRequestBodyToJson(LoginRequestBody instance) =>
    <String, dynamic>{
      'email': instance.email,
      'password': instance.password,
      'device_name': instance.deviceName,
      'device_id': instance.deviceId,
    };
