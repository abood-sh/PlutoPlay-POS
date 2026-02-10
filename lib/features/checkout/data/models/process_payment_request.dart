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

/// Request model for processing payment through terminal
/// Supports cash, card, and split payments with extended timeout
@JsonSerializable(includeIfNull: false)
class ProcessTerminalPaymentRequest {
  @JsonKey(name: 'terminal_id')
  final String terminalId;
  @JsonKey(name: 'payment_method')
  final String paymentMethod;
  final num amount;
  @JsonKey(name: 'customer_id')
  final int customerId;
  @JsonKey(name: 'amount_received')
  final num? amountReceived;
  @JsonKey(name: 'cash_amount')
  final num? cashAmount;
  @JsonKey(name: 'card_amount')
  final num? cardAmount;

  ProcessTerminalPaymentRequest({
    required this.terminalId,
    required this.paymentMethod,
    required this.amount,
    this.customerId = 4,
    this.amountReceived,
    this.cashAmount,
    this.cardAmount,
  });

  Map<String, dynamic> toJson() => _$ProcessTerminalPaymentRequestToJson(this);
}
