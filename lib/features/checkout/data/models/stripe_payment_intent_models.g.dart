// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'stripe_payment_intent_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CreatePaymentIntentRequest _$CreatePaymentIntentRequestFromJson(
  Map<String, dynamic> json,
) => CreatePaymentIntentRequest(
  amount: json['amount'] as num,
  terminalId: json['terminal_id'] as String,
  currency: json['currency'] as String? ?? 'usd',
  customerId: (json['customer_id'] as num?)?.toInt() ?? 4,
);

Map<String, dynamic> _$CreatePaymentIntentRequestToJson(
  CreatePaymentIntentRequest instance,
) => <String, dynamic>{
  'amount': instance.amount,
  'terminal_id': instance.terminalId,
  'currency': instance.currency,
  'customer_id': instance.customerId,
};

CreatePaymentIntentResponse _$CreatePaymentIntentResponseFromJson(
  Map<String, dynamic> json,
) => CreatePaymentIntentResponse(
  success: json['success'] as bool?,
  clientSecret: json['client_secret'] as String?,
  paymentIntentId: json['payment_intent_id'] as String?,
  message: json['message'] as String?,
);

Map<String, dynamic> _$CreatePaymentIntentResponseToJson(
  CreatePaymentIntentResponse instance,
) => <String, dynamic>{
  'success': instance.success,
  'client_secret': instance.clientSecret,
  'payment_intent_id': instance.paymentIntentId,
  'message': instance.message,
};

ConfirmStripePaymentRequest _$ConfirmStripePaymentRequestFromJson(
  Map<String, dynamic> json,
) => ConfirmStripePaymentRequest(
  paymentIntentId: json['payment_intent_id'] as String,
  paymentMethod: json['payment_method'] as String? ?? 'stripe_terminal',
  subtotal: json['subtotal'] as num,
  taxAmount: json['tax_amount'] as num? ?? 0,
  shippingCost: json['shipping_cost'] as num? ?? 0,
  discountAmount: json['discount_amount'] as num? ?? 0,
  totalAmount: json['total_amount'] as num,
  cashAmount: json['cash_amount'] as num?,
  cardAmount: json['card_amount'] as num?,
  cashReceived: json['cash_received'] as num?,
  change: json['change'] as num?,
);

Map<String, dynamic> _$ConfirmStripePaymentRequestToJson(
  ConfirmStripePaymentRequest instance,
) => <String, dynamic>{
  'payment_intent_id': instance.paymentIntentId,
  'payment_method': instance.paymentMethod,
  'subtotal': instance.subtotal,
  'tax_amount': instance.taxAmount,
  'shipping_cost': instance.shippingCost,
  'discount_amount': instance.discountAmount,
  'total_amount': instance.totalAmount,
  if (instance.cashAmount case final value?) 'cash_amount': value,
  if (instance.cardAmount case final value?) 'card_amount': value,
  if (instance.cashReceived case final value?) 'cash_received': value,
  if (instance.change case final value?) 'change': value,
};

ConfirmStripePaymentResponse _$ConfirmStripePaymentResponseFromJson(
  Map<String, dynamic> json,
) => ConfirmStripePaymentResponse(
  success: json['success'] as bool?,
  message: json['message'] as String?,
  orderId: (json['order_id'] as num?)?.toInt(),
  orderNumber: json['order_number'] as String?,
  data: json['data'] == null
      ? null
      : ConfirmPaymentData.fromJson(json['data'] as Map<String, dynamic>),
);

Map<String, dynamic> _$ConfirmStripePaymentResponseToJson(
  ConfirmStripePaymentResponse instance,
) => <String, dynamic>{
  'success': instance.success,
  'message': instance.message,
  'order_id': instance.orderId,
  'order_number': instance.orderNumber,
  'data': instance.data,
};

ConfirmPaymentData _$ConfirmPaymentDataFromJson(Map<String, dynamic> json) =>
    ConfirmPaymentData(
      orderId: (json['order_id'] as num?)?.toInt(),
      orderNumber: json['order_number'] as String?,
    );

Map<String, dynamic> _$ConfirmPaymentDataToJson(ConfirmPaymentData instance) =>
    <String, dynamic>{
      'order_id': instance.orderId,
      'order_number': instance.orderNumber,
    };

ConnectionTokenResponse _$ConnectionTokenResponseFromJson(
  Map<String, dynamic> json,
) => ConnectionTokenResponse(
  success: json['success'] as bool?,
  secret: json['secret'] as String?,
  message: json['message'] as String?,
);

Map<String, dynamic> _$ConnectionTokenResponseToJson(
  ConnectionTokenResponse instance,
) => <String, dynamic>{
  'success': instance.success,
  'secret': instance.secret,
  'message': instance.message,
};
