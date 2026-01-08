import 'package:json_annotation/json_annotation.dart';

part 'cart_model_response.g.dart';

@JsonSerializable()
class CartResponseModel {
  final bool? success;
  final CartData? data;

  CartResponseModel({this.success, this.data});

  factory CartResponseModel.fromJson(Map<String, dynamic> json) =>
      _$CartResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$CartResponseModelToJson(this);
}

@JsonSerializable()
class CartData {
  final List<CartItemModel>? items;

  @JsonKey(name: 'customer_id')
  final String? customerId;

  final num? subtotal;

  @JsonKey(name: 'discount_amount')
  final num? discountAmount;

  @JsonKey(name: 'discount_type')
  final String? discountType;

  @JsonKey(name: 'discount_value')
  final num? discountValue;

  @JsonKey(name: 'tax_amount')
  final num? taxAmount;

  @JsonKey(name: 'tax_rate')
  final num? taxRate;

  final num? total;

  @JsonKey(name: 'items_count')
  final int? itemsCount;

  CartData({
    this.items,
    this.customerId,
    this.subtotal,
    this.discountAmount,
    this.discountType,
    this.discountValue,
    this.taxAmount,
    this.taxRate,
    this.total,
    this.itemsCount,
  });

  factory CartData.fromJson(Map<String, dynamic> json) =>
      _$CartDataFromJson(json);

  Map<String, dynamic> toJson() => _$CartDataToJson(this);
}

@JsonSerializable()
class CartItemModel {
  final String? type;

  @JsonKey(name: 'cart_item_id')
  final String? cartItemId;

  @JsonKey(name: 'product_name')
  final String? productName;

  @JsonKey(fromJson: _numToString)
  final String? price;

  final int? quantity;

  @JsonKey(fromJson: _numToString)
  final String? subtotal;

  @JsonKey(name: 'rfid_tag_id')
  final String? rfidTagId;

  @JsonKey(name: 'condition_type')
  final String? conditionType;

  CartItemModel({
    this.cartItemId,
    this.type,
    this.productName,
    this.price,
    this.quantity,
    this.subtotal,
    this.rfidTagId,
    this.conditionType,
  });

  factory CartItemModel.fromJson(Map<String, dynamic> json) =>
      _$CartItemModelFromJson(json);

  Map<String, dynamic> toJson() => _$CartItemModelToJson(this);

  static String? _numToString(dynamic value) {
    if (value == null) return null;
    return value.toString();
  }
}
