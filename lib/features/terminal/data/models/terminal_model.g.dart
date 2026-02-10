// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'terminal_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TerminalListResponse _$TerminalListResponseFromJson(
  Map<String, dynamic> json,
) => TerminalListResponse(
  success: json['success'] as bool?,
  terminals: (json['terminals'] as List<dynamic>?)
      ?.map((e) => TerminalModel.fromJson(e as Map<String, dynamic>))
      .toList(),
  storeId: (json['store_id'] as num?)?.toInt(),
);

Map<String, dynamic> _$TerminalListResponseToJson(
  TerminalListResponse instance,
) => <String, dynamic>{
  'success': instance.success,
  'terminals': instance.terminals,
  'store_id': instance.storeId,
};

TerminalModel _$TerminalModelFromJson(Map<String, dynamic> json) =>
    TerminalModel(
      id: (json['id'] as num?)?.toInt(),
      terminalId: json['terminal_id'] as String?,
      serialNumber: json['serial_number'] as String?,
      label: json['label'] as String?,
      deviceType: json['device_type'] as String?,
      locationId: json['location_id'] as String?,
      storeId: (json['store_id'] as num?)?.toInt(),
      salesmanId: (json['salesman_id'] as num?)?.toInt(),
      status: json['status'] as String?,
      ipAddress: json['ip_address'] as String?,
      lastSeenAt: json['last_seen_at'] as String?,
      createdAt: json['created_at'] as String?,
      updatedAt: json['updated_at'] as String?,
      store: json['store'] == null
          ? null
          : TerminalStore.fromJson(json['store'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$TerminalModelToJson(TerminalModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'terminal_id': instance.terminalId,
      'serial_number': instance.serialNumber,
      'label': instance.label,
      'device_type': instance.deviceType,
      'location_id': instance.locationId,
      'store_id': instance.storeId,
      'salesman_id': instance.salesmanId,
      'status': instance.status,
      'ip_address': instance.ipAddress,
      'last_seen_at': instance.lastSeenAt,
      'created_at': instance.createdAt,
      'updated_at': instance.updatedAt,
      'store': instance.store,
    };

TerminalStore _$TerminalStoreFromJson(Map<String, dynamic> json) =>
    TerminalStore(
      id: (json['id'] as num?)?.toInt(),
      name: json['name'] as String?,
      code: json['code'] as String?,
      addressLine1: json['address_line_1'] as String?,
      addressLine2: json['address_line_2'] as String?,
      city: json['city'] as String?,
      state: json['state'] as String?,
      zipCode: json['zip_code'] as String?,
      phone: json['phone'] as String?,
      email: json['email'] as String?,
      storeType: json['store_type'] as String?,
    );

Map<String, dynamic> _$TerminalStoreToJson(TerminalStore instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'code': instance.code,
      'address_line_1': instance.addressLine1,
      'address_line_2': instance.addressLine2,
      'city': instance.city,
      'state': instance.state,
      'zip_code': instance.zipCode,
      'phone': instance.phone,
      'email': instance.email,
      'store_type': instance.storeType,
    };
