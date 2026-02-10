import 'package:json_annotation/json_annotation.dart';

part 'process_payment_response.g.dart';

@JsonSerializable(includeIfNull: false)
class ProcessPaymentResponse {
  final bool? success;
  final String? message;
  final PaymentResponseData? data;
  final Map<String, dynamic>? errors;
  @JsonKey(name: 'cart_total')
  final num? cartTotal;
  @JsonKey(name: 'provided_amount')
  final num? providedAmount;
  @JsonKey(name: 'cash_amount')
  final num? cashAmount;
  @JsonKey(name: 'card_amount')
  final num? cardAmount;
  @JsonKey(name: 'total_payments')
  final num? totalPayments;
  final bool? timeout;

  ProcessPaymentResponse({
    this.success,
    this.message,
    this.data,
    this.errors,
    this.cartTotal,
    this.providedAmount,
    this.cashAmount,
    this.cardAmount,
    this.totalPayments,
    this.timeout,
  });

  /// Check if request was successful
  bool get isSuccess => success == true;

  /// Check if request timed out
  bool get isTimeout => timeout == true;

  factory ProcessPaymentResponse.fromJson(Map<String, dynamic> json) =>
      _$ProcessPaymentResponseFromJson(json);
}

@JsonSerializable()
class PaymentResponseData {
  final OrderData? order;
  @JsonKey(name: 'invoice_number')
  final String? invoiceNumber;
  @JsonKey(name: 'payment_method')
  final String? paymentMethod;
  @JsonKey(name: 'payments_count')
  final int? paymentsCount;
  @JsonKey(name: 'change_due')
  final num? changeDue;
  @JsonKey(name: 'amount_received')
  final num? amountReceived;
  // Additional change field for split payments
  final num? change;

  PaymentResponseData({
    this.order,
    this.invoiceNumber,
    this.paymentMethod,
    this.paymentsCount,
    this.changeDue,
    this.amountReceived,
    this.change,
  });

  factory PaymentResponseData.fromJson(Map<String, dynamic> json) =>
      _$PaymentResponseDataFromJson(json);
}

@JsonSerializable()
class OrderData {
  final int? id;
  @JsonKey(name: 'order_number')
  final String? orderNumber;
  @JsonKey(name: 'order_date')
  final String? orderDate;
  final CustomerInfo? customer;
  final SalesmanInfo? salesman;
  final StoreInfo? store;
  final String? status;
  @JsonKey(name: 'payment_status')
  final String? paymentStatus;
  final String? subtotal;
  final String? discount;
  @JsonKey(name: 'tax_amount')
  final dynamic taxAmount;
  final String? total;
  @JsonKey(name: 'order_source')
  final String? orderSource;
  @JsonKey(name: 'items_count')
  final int? itemsCount;
  final InvoiceInfo? invoice;
  final List<PaymentInfo>? payments;

  OrderData({
    this.id,
    this.orderNumber,
    this.orderDate,
    this.customer,
    this.salesman,
    this.store,
    this.status,
    this.paymentStatus,
    this.subtotal,
    this.discount,
    this.taxAmount,
    this.total,
    this.orderSource,
    this.itemsCount,
    this.invoice,
    this.payments,
  });

  factory OrderData.fromJson(Map<String, dynamic> json) =>
      _$OrderDataFromJson(json);
}

@JsonSerializable()
class CustomerInfo {
  final int? id;
  final String? name;
  final String? phone;

  CustomerInfo({this.id, this.name, this.phone});

  factory CustomerInfo.fromJson(Map<String, dynamic> json) =>
      _$CustomerInfoFromJson(json);
}

@JsonSerializable()
class SalesmanInfo {
  final int? id;
  final String? name;

  SalesmanInfo({this.id, this.name});

  factory SalesmanInfo.fromJson(Map<String, dynamic> json) =>
      _$SalesmanInfoFromJson(json);
}

@JsonSerializable()
class StoreInfo {
  final int? id;
  final String? name;

  StoreInfo({this.id, this.name});

  factory StoreInfo.fromJson(Map<String, dynamic> json) =>
      _$StoreInfoFromJson(json);
}

@JsonSerializable()
class InvoiceInfo {
  @JsonKey(name: 'invoice_number')
  final String? invoiceNumber;
  final String? status;

  InvoiceInfo({this.invoiceNumber, this.status});

  factory InvoiceInfo.fromJson(Map<String, dynamic> json) =>
      _$InvoiceInfoFromJson(json);
}

@JsonSerializable()
class PaymentInfo {
  @JsonKey(name: 'payment_method')
  final String? paymentMethod;
  final String? amount;
  final String? status;

  PaymentInfo({this.paymentMethod, this.amount, this.status});

  factory PaymentInfo.fromJson(Map<String, dynamic> json) =>
      _$PaymentInfoFromJson(json);
}
