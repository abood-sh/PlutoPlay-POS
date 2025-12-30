import 'package:json_annotation/json_annotation.dart';
part 'login_req_body.g.dart';

@JsonSerializable()
class LoginRequestBody {
  final String email;
  final String password;
  @JsonKey(name: 'device_name')
  final String deviceName;
  @JsonKey(name: 'device_id')
  final String deviceId;

  LoginRequestBody({
    required this.email,
    required this.password,
    required this.deviceName,
    required this.deviceId,
  });

  Map<String, dynamic> toJson() => _$LoginRequestBodyToJson(this);

  factory LoginRequestBody.fromJson(Map<String, dynamic> json) =>
      _$LoginRequestBodyFromJson(json);
}
