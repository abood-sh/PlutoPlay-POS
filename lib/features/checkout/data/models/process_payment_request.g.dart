// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'process_payment_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProcessPaymentRequest _$ProcessPaymentRequestFromJson(
  Map<String, dynamic> json,
) => ProcessPaymentRequest(
  paymentMethod: json['payment_method'] as String,
  customerId: (json['customer_id'] as num?)?.toInt() ?? 4,
  referenceNumber: json['reference_number'] as String?,
  amount: json['amount'] as num?,
);

Map<String, dynamic> _$ProcessPaymentRequestToJson(
  ProcessPaymentRequest instance,
) => <String, dynamic>{
  'payment_method': instance.paymentMethod,
  'customer_id': instance.customerId,
  if (instance.referenceNumber case final value?) 'reference_number': value,
  if (instance.amount case final value?) 'amount': value,
};

ProcessSplitPaymentRequest _$ProcessSplitPaymentRequestFromJson(
  Map<String, dynamic> json,
) => ProcessSplitPaymentRequest(
  payments: (json['payments'] as List<dynamic>)
      .map((e) => SplitPaymentItem.fromJson(e as Map<String, dynamic>))
      .toList(),
  customerId: (json['customer_id'] as num?)?.toInt() ?? 4,
);

Map<String, dynamic> _$ProcessSplitPaymentRequestToJson(
  ProcessSplitPaymentRequest instance,
) => <String, dynamic>{
  'payments': instance.payments,
  'customer_id': instance.customerId,
};

SplitPaymentItem _$SplitPaymentItemFromJson(Map<String, dynamic> json) =>
    SplitPaymentItem(
      paymentMethod: json['payment_method'] as String,
      amount: json['amount'] as num,
      referenceNumber: json['reference_number'] as String?,
    );

Map<String, dynamic> _$SplitPaymentItemToJson(SplitPaymentItem instance) =>
    <String, dynamic>{
      'payment_method': instance.paymentMethod,
      'amount': instance.amount,
      'reference_number': instance.referenceNumber,
    };

ProcessTerminalPaymentRequest _$ProcessTerminalPaymentRequestFromJson(
  Map<String, dynamic> json,
) => ProcessTerminalPaymentRequest(
  terminalId: json['terminal_id'] as String,
  paymentMethod: json['payment_method'] as String,
  amount: json['amount'] as num,
  customerId: (json['customer_id'] as num?)?.toInt() ?? 4,
  amountReceived: json['amount_received'] as num?,
  cashAmount: json['cash_amount'] as num?,
  cardAmount: json['card_amount'] as num?,
);

Map<String, dynamic> _$ProcessTerminalPaymentRequestToJson(
  ProcessTerminalPaymentRequest instance,
) => <String, dynamic>{
  'terminal_id': instance.terminalId,
  'payment_method': instance.paymentMethod,
  'amount': instance.amount,
  'customer_id': instance.customerId,
  if (instance.amountReceived case final value?) 'amount_received': value,
  if (instance.cashAmount case final value?) 'cash_amount': value,
  if (instance.cardAmount case final value?) 'card_amount': value,
};
