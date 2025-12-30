import 'package:json_annotation/json_annotation.dart';

part 'apply_discount_request.g.dart';

@JsonSerializable()
class ApplyDiscountRequest {
  final String type;
  final num value;

  ApplyDiscountRequest({required this.type, required this.value});

  factory ApplyDiscountRequest.fromJson(Map<String, dynamic> json) =>
      _$ApplyDiscountRequestFromJson(json);

  Map<String, dynamic> toJson() => _$ApplyDiscountRequestToJson(this);
}
