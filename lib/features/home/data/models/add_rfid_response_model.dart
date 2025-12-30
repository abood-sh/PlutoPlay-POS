import 'package:json_annotation/json_annotation.dart';
import 'cart_model_response.dart';

part 'add_rfid_response_model.g.dart';

@JsonSerializable()
class AddRfidResponse {
  final bool? success;
  final String? message;
  final CartData? data;

  AddRfidResponse({this.success, this.message, this.data});

  factory AddRfidResponse.fromJson(Map<String, dynamic> json) =>
      _$AddRfidResponseFromJson(json);

  Map<String, dynamic> toJson() => _$AddRfidResponseToJson(this);
}
