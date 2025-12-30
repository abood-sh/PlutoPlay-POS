// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'system_settings_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SystemSettingsResponse _$SystemSettingsResponseFromJson(
  Map<String, dynamic> json,
) => SystemSettingsResponse(
  success: json['success'] as bool?,
  data: json['data'] == null
      ? null
      : SystemSettingsData.fromJson(json['data'] as Map<String, dynamic>),
);

Map<String, dynamic> _$SystemSettingsResponseToJson(
  SystemSettingsResponse instance,
) => <String, dynamic>{'success': instance.success, 'data': instance.data};

SystemSettingsData _$SystemSettingsDataFromJson(Map<String, dynamic> json) =>
    SystemSettingsData(
      general: json['general'] == null
          ? null
          : GeneralSettings.fromJson(json['general'] as Map<String, dynamic>),
      pos: json['pos'] == null
          ? null
          : PosSettings.fromJson(json['pos'] as Map<String, dynamic>),
      payment: json['payment'] == null
          ? null
          : PaymentSettings.fromJson(json['payment'] as Map<String, dynamic>),
      discount: json['discount'] == null
          ? null
          : DiscountSettingsSystem.fromJson(
              json['discount'] as Map<String, dynamic>,
            ),
    );

Map<String, dynamic> _$SystemSettingsDataToJson(SystemSettingsData instance) =>
    <String, dynamic>{
      'general': instance.general,
      'pos': instance.pos,
      'payment': instance.payment,
      'discount': instance.discount,
    };

GeneralSettings _$GeneralSettingsFromJson(Map<String, dynamic> json) =>
    GeneralSettings(
      storeName: json['store_name'] as String?,
      currency: json['currency'] as String?,
      timezone: json['timezone'] as String?,
      dateFormat: json['date_format'] as String?,
      timeFormat: json['time_format'] as String?,
    );

Map<String, dynamic> _$GeneralSettingsToJson(GeneralSettings instance) =>
    <String, dynamic>{
      'store_name': instance.storeName,
      'currency': instance.currency,
      'timezone': instance.timezone,
      'date_format': instance.dateFormat,
      'time_format': instance.timeFormat,
    };

PosSettings _$PosSettingsFromJson(Map<String, dynamic> json) => PosSettings(
  enableRfid: json['enable_rfid'] as bool?,
  enableBarcode: json['enable_barcode'] as bool?,
  enableStaxx: json['enable_staxx'] as bool?,
  autoPrintReceipt: json['auto_print_receipt'] as bool?,
  requireCustomer: json['require_customer'] as bool?,
);

Map<String, dynamic> _$PosSettingsToJson(PosSettings instance) =>
    <String, dynamic>{
      'enable_rfid': instance.enableRfid,
      'enable_barcode': instance.enableBarcode,
      'enable_staxx': instance.enableStaxx,
      'auto_print_receipt': instance.autoPrintReceipt,
      'require_customer': instance.requireCustomer,
    };

PaymentSettings _$PaymentSettingsFromJson(Map<String, dynamic> json) =>
    PaymentSettings(
      enableCash: json['enable_cash'] as bool?,
      enableCard: json['enable_card'] as bool?,
      enableStripeTerminal: json['enable_stripe_terminal'] as bool?,
      enableSplitPayment: json['enable_split_payment'] as bool?,
    );

Map<String, dynamic> _$PaymentSettingsToJson(PaymentSettings instance) =>
    <String, dynamic>{
      'enable_cash': instance.enableCash,
      'enable_card': instance.enableCard,
      'enable_stripe_terminal': instance.enableStripeTerminal,
      'enable_split_payment': instance.enableSplitPayment,
    };

DiscountSettingsSystem _$DiscountSettingsSystemFromJson(
  Map<String, dynamic> json,
) => DiscountSettingsSystem(
  discountPassword: json['discount_password'] as String?,
  maxDiscountPercentage: json['max_discount_percentage'] as num?,
  maxDiscountFixed: json['max_discount_fixed'] as num?,
);

Map<String, dynamic> _$DiscountSettingsSystemToJson(
  DiscountSettingsSystem instance,
) => <String, dynamic>{
  'discount_password': instance.discountPassword,
  'max_discount_percentage': instance.maxDiscountPercentage,
  'max_discount_fixed': instance.maxDiscountFixed,
};
