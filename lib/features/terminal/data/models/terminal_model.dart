import 'package:json_annotation/json_annotation.dart';

part 'terminal_model.g.dart';

@JsonSerializable()
class TerminalListResponse {
  final bool? success;
  final List<TerminalModel>? terminals;
  @JsonKey(name: 'store_id')
  final int? storeId;

  TerminalListResponse({this.success, this.terminals, this.storeId});

  factory TerminalListResponse.fromJson(Map<String, dynamic> json) =>
      _$TerminalListResponseFromJson(json);

  Map<String, dynamic> toJson() => _$TerminalListResponseToJson(this);
}

@JsonSerializable()
class TerminalModel {
  final int? id;
  @JsonKey(name: 'terminal_id')
  final String? terminalId;
  @JsonKey(name: 'serial_number')
  final String? serialNumber;
  final String? label;
  @JsonKey(name: 'device_type')
  final String? deviceType;
  @JsonKey(name: 'location_id')
  final String? locationId;
  @JsonKey(name: 'store_id')
  final int? storeId;
  @JsonKey(name: 'salesman_id')
  final int? salesmanId;
  final String? status;
  @JsonKey(name: 'ip_address')
  final String? ipAddress;
  @JsonKey(name: 'last_seen_at')
  final String? lastSeenAt;
  @JsonKey(name: 'created_at')
  final String? createdAt;
  @JsonKey(name: 'updated_at')
  final String? updatedAt;
  final TerminalStore? store;

  TerminalModel({
    this.id,
    this.terminalId,
    this.serialNumber,
    this.label,
    this.deviceType,
    this.locationId,
    this.storeId,
    this.salesmanId,
    this.status,
    this.ipAddress,
    this.lastSeenAt,
    this.createdAt,
    this.updatedAt,
    this.store,
  });

  factory TerminalModel.fromJson(Map<String, dynamic> json) =>
      _$TerminalModelFromJson(json);

  Map<String, dynamic> toJson() => _$TerminalModelToJson(this);

  bool get isOnline => status?.toLowerCase() == 'online';
}

@JsonSerializable()
class TerminalStore {
  final int? id;
  final String? name;
  final String? code;
  @JsonKey(name: 'address_line_1')
  final String? addressLine1;
  @JsonKey(name: 'address_line_2')
  final String? addressLine2;
  final String? city;
  final String? state;
  @JsonKey(name: 'zip_code')
  final String? zipCode;
  final String? phone;
  final String? email;
  @JsonKey(name: 'store_type')
  final String? storeType;

  TerminalStore({
    this.id,
    this.name,
    this.code,
    this.addressLine1,
    this.addressLine2,
    this.city,
    this.state,
    this.zipCode,
    this.phone,
    this.email,
    this.storeType,
  });

  factory TerminalStore.fromJson(Map<String, dynamic> json) =>
      _$TerminalStoreFromJson(json);

  Map<String, dynamic> toJson() => _$TerminalStoreToJson(this);
}
