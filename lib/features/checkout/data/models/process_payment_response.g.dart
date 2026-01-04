// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'process_payment_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProcessPaymentResponse _$ProcessPaymentResponseFromJson(
  Map<String, dynamic> json,
) => ProcessPaymentResponse(
  success: json['success'] as bool?,
  message: json['message'] as String?,
  data: json['data'] == null
      ? null
      : PaymentResponseData.fromJson(json['data'] as Map<String, dynamic>),
);

Map<String, dynamic> _$ProcessPaymentResponseToJson(
  ProcessPaymentResponse instance,
) => <String, dynamic>{
  'success': instance.success,
  'message': instance.message,
  'data': instance.data,
};

PaymentResponseData _$PaymentResponseDataFromJson(Map<String, dynamic> json) =>
    PaymentResponseData(
      order: json['order'] == null
          ? null
          : OrderData.fromJson(json['order'] as Map<String, dynamic>),
      invoiceNumber: json['invoice_number'] as String?,
      paymentMethod: json['payment_method'] as String?,
      paymentsCount: (json['payments_count'] as num?)?.toInt(),
    );

Map<String, dynamic> _$PaymentResponseDataToJson(
  PaymentResponseData instance,
) => <String, dynamic>{
  'order': instance.order,
  'invoice_number': instance.invoiceNumber,
  'payment_method': instance.paymentMethod,
  'payments_count': instance.paymentsCount,
};

OrderData _$OrderDataFromJson(Map<String, dynamic> json) => OrderData(
  id: (json['id'] as num?)?.toInt(),
  orderNumber: json['order_number'] as String?,
  orderDate: json['order_date'] as String?,
  customer: json['customer'] == null
      ? null
      : CustomerInfo.fromJson(json['customer'] as Map<String, dynamic>),
  salesman: json['salesman'] == null
      ? null
      : SalesmanInfo.fromJson(json['salesman'] as Map<String, dynamic>),
  store: json['store'] == null
      ? null
      : StoreInfo.fromJson(json['store'] as Map<String, dynamic>),
  status: json['status'] as String?,
  paymentStatus: json['payment_status'] as String?,
  subtotal: json['subtotal'] as String?,
  discount: json['discount'] as String?,
  taxAmount: json['tax_amount'],
  total: json['total'] as String?,
  orderSource: json['order_source'] as String?,
  itemsCount: (json['items_count'] as num?)?.toInt(),
  invoice: json['invoice'] == null
      ? null
      : InvoiceInfo.fromJson(json['invoice'] as Map<String, dynamic>),
  payments: (json['payments'] as List<dynamic>?)
      ?.map((e) => PaymentInfo.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$OrderDataToJson(OrderData instance) => <String, dynamic>{
  'id': instance.id,
  'order_number': instance.orderNumber,
  'order_date': instance.orderDate,
  'customer': instance.customer,
  'salesman': instance.salesman,
  'store': instance.store,
  'status': instance.status,
  'payment_status': instance.paymentStatus,
  'subtotal': instance.subtotal,
  'discount': instance.discount,
  'tax_amount': instance.taxAmount,
  'total': instance.total,
  'order_source': instance.orderSource,
  'items_count': instance.itemsCount,
  'invoice': instance.invoice,
  'payments': instance.payments,
};

CustomerInfo _$CustomerInfoFromJson(Map<String, dynamic> json) => CustomerInfo(
  id: (json['id'] as num?)?.toInt(),
  name: json['name'] as String?,
  phone: json['phone'] as String?,
);

Map<String, dynamic> _$CustomerInfoToJson(CustomerInfo instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'phone': instance.phone,
    };

SalesmanInfo _$SalesmanInfoFromJson(Map<String, dynamic> json) => SalesmanInfo(
  id: (json['id'] as num?)?.toInt(),
  name: json['name'] as String?,
);

Map<String, dynamic> _$SalesmanInfoToJson(SalesmanInfo instance) =>
    <String, dynamic>{'id': instance.id, 'name': instance.name};

StoreInfo _$StoreInfoFromJson(Map<String, dynamic> json) =>
    StoreInfo(id: (json['id'] as num?)?.toInt(), name: json['name'] as String?);

Map<String, dynamic> _$StoreInfoToJson(StoreInfo instance) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
};

InvoiceInfo _$InvoiceInfoFromJson(Map<String, dynamic> json) => InvoiceInfo(
  invoiceNumber: json['invoice_number'] as String?,
  status: json['status'] as String?,
);

Map<String, dynamic> _$InvoiceInfoToJson(InvoiceInfo instance) =>
    <String, dynamic>{
      'invoice_number': instance.invoiceNumber,
      'status': instance.status,
    };

PaymentInfo _$PaymentInfoFromJson(Map<String, dynamic> json) => PaymentInfo(
  paymentMethod: json['payment_method'] as String?,
  amount: json['amount'] as String?,
  status: json['status'] as String?,
);

Map<String, dynamic> _$PaymentInfoToJson(PaymentInfo instance) =>
    <String, dynamic>{
      'payment_method': instance.paymentMethod,
      'amount': instance.amount,
      'status': instance.status,
    };
