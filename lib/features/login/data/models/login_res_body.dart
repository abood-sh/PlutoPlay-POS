import 'package:json_annotation/json_annotation.dart';
part 'login_res_body.g.dart';

@JsonSerializable()
class LoginResponse {
  bool? success;
  String? message;
  @JsonKey(name: 'data')
  UserData? userData;

  LoginResponse({this.success, this.message, this.userData});

  factory LoginResponse.fromJson(Map<String, dynamic> json) =>
      _$LoginResponseFromJson(json);
}

@JsonSerializable()
class UserData {
  String? token;
  @JsonKey(name: 'salesman')
  SalesmanData? salesmanData;
  @JsonKey(name: 'store')
  StoreData? storeData;
  @JsonKey(name: 'device_id')
  String? deviceId;
  @JsonKey(name: 'token_expires_at')
  String? tokenExpiresAt;

  UserData({
    this.token,
    this.salesmanData,
    this.storeData,
    this.deviceId,
    this.tokenExpiresAt,
  });

  factory UserData.fromJson(Map<String, dynamic> json) =>
      _$UserDataFromJson(json);
}

@JsonSerializable()
class SalesmanData {
  int? id;
  @JsonKey(name: 'employee_id')
  String? employeeId;
  String? name;
  String? email;
  String? phone;
  @JsonKey(name: 'store_id')
  int? storeId;
  @JsonKey(name: 'store_name')
  String? storeName;
  @JsonKey(name: 'is_active')
  bool? isActive;
  @JsonKey(name: 'commission_rate')
  String? commissionRate;
  @JsonKey(name: 'sales_target')
  String? salesTarget;
  @JsonKey(name: 'monthly_total_sales')
  num? monthlyTotalSales;
  @JsonKey(name: 'yearly_total_sales')
  num? yearlyTotalSales;
  @JsonKey(name: 'achievement_percentage')
  num? achievementPercentage;
  @JsonKey(name: 'last_login_at')
  String? lastLoginAt;
  @JsonKey(name: 'discount_settings')
  DiscountSettings? discountSettings;

  SalesmanData({
    this.id,
    this.employeeId,
    this.name,
    this.email,
    this.phone,
    this.storeId,
    this.storeName,
    this.isActive,
    this.commissionRate,
    this.salesTarget,
    this.monthlyTotalSales,
    this.yearlyTotalSales,
    this.achievementPercentage,
    this.lastLoginAt,
    this.discountSettings,
  });

  factory SalesmanData.fromJson(Map<String, dynamic> json) =>
      _$SalesmanDataFromJson(json);
}

@JsonSerializable()
class DiscountSettings {
  @JsonKey(name: 'can_apply_discount')
  bool? canApplyDiscount;
  @JsonKey(name: 'discount_password')
  String? discountPassword;
  @JsonKey(name: 'max_discount_percentage')
  num? maxDiscountPercentage;
  @JsonKey(name: 'max_discount_fixed')
  num? maxDiscountFixed;

  DiscountSettings({
    this.canApplyDiscount,
    this.discountPassword,
    this.maxDiscountPercentage,
    this.maxDiscountFixed,
  });

  factory DiscountSettings.fromJson(Map<String, dynamic> json) =>
      _$DiscountSettingsFromJson(json);
}

@JsonSerializable()
class StoreData {
  int? id;
  String? name;
  String? address;
  String? phone;
  int? status;
  ManagerData? manager;

  StoreData({
    this.id,
    this.name,
    this.address,
    this.phone,
    this.status,
    this.manager,
  });

  factory StoreData.fromJson(Map<String, dynamic> json) =>
      _$StoreDataFromJson(json);
}

@JsonSerializable()
class ManagerData {
  int? id;
  String? name;

  ManagerData({this.id, this.name});

  factory ManagerData.fromJson(Map<String, dynamic> json) =>
      _$ManagerDataFromJson(json);
}
