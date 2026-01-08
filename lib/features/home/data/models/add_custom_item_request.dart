import 'package:json_annotation/json_annotation.dart';

part 'add_custom_item_request.g.dart';

@JsonSerializable()
class AddCustomItemRequest {
  final String name;
  final num price;
  final int quantity;
  final String? barcode;
  final String? description;

  AddCustomItemRequest({
    required this.name,
    required this.price,
    required this.quantity,
    this.barcode,
    this.description,
  });

  factory AddCustomItemRequest.fromJson(Map<String, dynamic> json) =>
      _$AddCustomItemRequestFromJson(json);

  Map<String, dynamic> toJson() => _$AddCustomItemRequestToJson(this);
}
