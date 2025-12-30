import 'package:json_annotation/json_annotation.dart';
import 'package:pos/features/home/data/models/cart_model_response.dart';

part 'apply_discount_response.g.dart';

@JsonSerializable()
class ApplyDiscountResponse {
  final bool? success;
  final String? message;
  final CartData? data;

  ApplyDiscountResponse({this.success, this.message, this.data});

  factory ApplyDiscountResponse.fromJson(Map<String, dynamic> json) =>
      _$ApplyDiscountResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ApplyDiscountResponseToJson(this);
}
