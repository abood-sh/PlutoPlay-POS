import 'package:json_annotation/json_annotation.dart';

part 'add_rfid_request_model.g.dart';

@JsonSerializable()
class AddRfidRequestModel {
  @JsonKey(name: 'tag_id')
  final String tagId;

  AddRfidRequestModel({required this.tagId});

  factory AddRfidRequestModel.fromJson(Map<String, dynamic> json) =>
      _$AddRfidRequestModelFromJson(json);

  Map<String, dynamic> toJson() => _$AddRfidRequestModelToJson(this);
}
