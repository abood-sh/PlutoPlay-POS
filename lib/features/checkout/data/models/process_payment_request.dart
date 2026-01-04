import 'package:json_annotation/json_annotation.dart';

part 'process_payment_request.g.dart';

@JsonSerializable(includeIfNull: false)
class ProcessPaymentRequest {
  @JsonKey(name: 'payment_method')
  final String paymentMethod;
  @JsonKey(name: 'customer_id')
  final int customerId;
  @JsonKey(name: 'reference_number')
  final String? referenceNumber;
  final num? amount;

  ProcessPaymentRequest({
    required this.paymentMethod,
    this.customerId = 4,
    this.referenceNumber,
    this.amount,
  });

  Map<String, dynamic> toJson() => _$ProcessPaymentRequestToJson(this);
}

@JsonSerializable()
class ProcessSplitPaymentRequest {
  final List<SplitPaymentItem> payments;
  @JsonKey(name: 'customer_id')
  final int customerId;

  ProcessSplitPaymentRequest({required this.payments, this.customerId = 4});

  Map<String, dynamic> toJson() => _$ProcessSplitPaymentRequestToJson(this);
}

@JsonSerializable()
class SplitPaymentItem {
  @JsonKey(name: 'payment_method')
  final String paymentMethod;
  final num amount;
  @JsonKey(name: 'reference_number')
  final String? referenceNumber;

  SplitPaymentItem({
    required this.paymentMethod,
    required this.amount,
    this.referenceNumber,
  });

  factory SplitPaymentItem.fromJson(Map<String, dynamic> json) =>
      _$SplitPaymentItemFromJson(json);

  Map<String, dynamic> toJson() => _$SplitPaymentItemToJson(this);
}
