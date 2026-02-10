import 'package:json_annotation/json_annotation.dart';

part 'stripe_payment_intent_models.g.dart';

/// Request model for creating a payment intent
/// POST /stripe/terminal/create-payment-intent
@JsonSerializable()
class CreatePaymentIntentRequest {
  final num amount;
  @JsonKey(name: 'terminal_id')
  final String terminalId;
  final String currency;
  @JsonKey(name: 'customer_id')
  final int customerId;

  CreatePaymentIntentRequest({
    required this.amount,
    required this.terminalId,
    this.currency = 'usd',
    this.customerId = 4,
  });

  factory CreatePaymentIntentRequest.fromJson(Map<String, dynamic> json) =>
      _$CreatePaymentIntentRequestFromJson(json);

  Map<String, dynamic> toJson() => _$CreatePaymentIntentRequestToJson(this);
}

/// Response model for creating a payment intent
@JsonSerializable()
class CreatePaymentIntentResponse {
  final bool? success;
  @JsonKey(name: 'client_secret')
  final String? clientSecret;
  @JsonKey(name: 'payment_intent_id')
  final String? paymentIntentId;
  final String? message;

  CreatePaymentIntentResponse({
    this.success,
    this.clientSecret,
    this.paymentIntentId,
    this.message,
  });

  factory CreatePaymentIntentResponse.fromJson(Map<String, dynamic> json) =>
      _$CreatePaymentIntentResponseFromJson(json);

  bool get isSuccess => success == true && clientSecret != null;
}

/// Request model for confirming payment
/// POST /checkout/confirm
@JsonSerializable()
class ConfirmStripePaymentRequest {
  @JsonKey(name: 'payment_intent_id')
  final String paymentIntentId;
  @JsonKey(name: 'payment_method')
  final String paymentMethod;
  final num subtotal;
  @JsonKey(name: 'tax_amount')
  final num taxAmount;
  @JsonKey(name: 'shipping_cost')
  final num shippingCost;
  @JsonKey(name: 'discount_amount')
  final num discountAmount;
  @JsonKey(name: 'total_amount')
  final num totalAmount;
  
  // Split payment fields
  @JsonKey(name: 'cash_amount', includeIfNull: false)
  final num? cashAmount;
  @JsonKey(name: 'card_amount', includeIfNull: false)
  final num? cardAmount;
  @JsonKey(name: 'cash_received', includeIfNull: false)
  final num? cashReceived;
  @JsonKey(includeIfNull: false)
  final num? change;

  ConfirmStripePaymentRequest({
    required this.paymentIntentId,
    this.paymentMethod = 'stripe_terminal',
    required this.subtotal,
    this.taxAmount = 0,
    this.shippingCost = 0,
    this.discountAmount = 0,
    required this.totalAmount,
    this.cashAmount,
    this.cardAmount,
    this.cashReceived,
    this.change,
  });

  factory ConfirmStripePaymentRequest.fromJson(Map<String, dynamic> json) =>
      _$ConfirmStripePaymentRequestFromJson(json);

  Map<String, dynamic> toJson() => _$ConfirmStripePaymentRequestToJson(this);
}

/// Response model for confirming payment
@JsonSerializable()
class ConfirmStripePaymentResponse {
  final bool? success;
  final String? message;
  @JsonKey(name: 'order_id')
  final int? orderId;
  @JsonKey(name: 'order_number')
  final String? orderNumber;
  final ConfirmPaymentData? data;

  ConfirmStripePaymentResponse({
    this.success,
    this.message,
    this.orderId,
    this.orderNumber,
    this.data,
  });

  factory ConfirmStripePaymentResponse.fromJson(Map<String, dynamic> json) =>
      _$ConfirmStripePaymentResponseFromJson(json);

  bool get isSuccess => success == true;
}

@JsonSerializable()
class ConfirmPaymentData {
  @JsonKey(name: 'order_id')
  final int? orderId;
  @JsonKey(name: 'order_number')
  final String? orderNumber;

  ConfirmPaymentData({this.orderId, this.orderNumber});

  factory ConfirmPaymentData.fromJson(Map<String, dynamic> json) =>
      _$ConfirmPaymentDataFromJson(json);
}

/// Response model for connection token
@JsonSerializable()
class ConnectionTokenResponse {
  final bool? success;
  final String? secret;
  final String? message;

  ConnectionTokenResponse({this.success, this.secret, this.message});

  factory ConnectionTokenResponse.fromJson(Map<String, dynamic> json) =>
      _$ConnectionTokenResponseFromJson(json);
}
