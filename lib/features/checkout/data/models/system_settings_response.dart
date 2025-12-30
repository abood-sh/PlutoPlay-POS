import 'package:json_annotation/json_annotation.dart';

part 'system_settings_response.g.dart';

@JsonSerializable()
class SystemSettingsResponse {
  final bool? success;
  final SystemSettingsData? data;

  SystemSettingsResponse({this.success, this.data});

  factory SystemSettingsResponse.fromJson(Map<String, dynamic> json) =>
      _$SystemSettingsResponseFromJson(json);

  Map<String, dynamic> toJson() => _$SystemSettingsResponseToJson(this);
}

@JsonSerializable()
class SystemSettingsData {
  final GeneralSettings? general;
  final PosSettings? pos;
  final PaymentSettings? payment;
  final DiscountSettingsSystem? discount;

  SystemSettingsData({this.general, this.pos, this.payment, this.discount});

  factory SystemSettingsData.fromJson(Map<String, dynamic> json) =>
      _$SystemSettingsDataFromJson(json);

  Map<String, dynamic> toJson() => _$SystemSettingsDataToJson(this);
}

@JsonSerializable()
class GeneralSettings {
  @JsonKey(name: 'store_name')
  final String? storeName;
  final String? currency;
  final String? timezone;
  @JsonKey(name: 'date_format')
  final String? dateFormat;
  @JsonKey(name: 'time_format')
  final String? timeFormat;

  GeneralSettings({
    this.storeName,
    this.currency,
    this.timezone,
    this.dateFormat,
    this.timeFormat,
  });

  factory GeneralSettings.fromJson(Map<String, dynamic> json) =>
      _$GeneralSettingsFromJson(json);

  Map<String, dynamic> toJson() => _$GeneralSettingsToJson(this);
}

@JsonSerializable()
class PosSettings {
  @JsonKey(name: 'enable_rfid')
  final bool? enableRfid;
  @JsonKey(name: 'enable_barcode')
  final bool? enableBarcode;
  @JsonKey(name: 'enable_staxx')
  final bool? enableStaxx;
  @JsonKey(name: 'auto_print_receipt')
  final bool? autoPrintReceipt;
  @JsonKey(name: 'require_customer')
  final bool? requireCustomer;

  PosSettings({
    this.enableRfid,
    this.enableBarcode,
    this.enableStaxx,
    this.autoPrintReceipt,
    this.requireCustomer,
  });

  factory PosSettings.fromJson(Map<String, dynamic> json) =>
      _$PosSettingsFromJson(json);

  Map<String, dynamic> toJson() => _$PosSettingsToJson(this);
}

@JsonSerializable()
class PaymentSettings {
  @JsonKey(name: 'enable_cash')
  final bool? enableCash;
  @JsonKey(name: 'enable_card')
  final bool? enableCard;
  @JsonKey(name: 'enable_stripe_terminal')
  final bool? enableStripeTerminal;
  @JsonKey(name: 'enable_split_payment')
  final bool? enableSplitPayment;

  PaymentSettings({
    this.enableCash,
    this.enableCard,
    this.enableStripeTerminal,
    this.enableSplitPayment,
  });

  factory PaymentSettings.fromJson(Map<String, dynamic> json) =>
      _$PaymentSettingsFromJson(json);

  Map<String, dynamic> toJson() => _$PaymentSettingsToJson(this);
}

@JsonSerializable()
class DiscountSettingsSystem {
  @JsonKey(name: 'discount_password')
  final String? discountPassword;
  @JsonKey(name: 'max_discount_percentage')
  final num? maxDiscountPercentage;
  @JsonKey(name: 'max_discount_fixed')
  final num? maxDiscountFixed;

  DiscountSettingsSystem({
    this.discountPassword,
    this.maxDiscountPercentage,
    this.maxDiscountFixed,
  });

  factory DiscountSettingsSystem.fromJson(Map<String, dynamic> json) =>
      _$DiscountSettingsSystemFromJson(json);

  Map<String, dynamic> toJson() => _$DiscountSettingsSystemToJson(this);
}
