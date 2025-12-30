// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_res_body.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LoginResponse _$LoginResponseFromJson(Map<String, dynamic> json) =>
    LoginResponse(
      success: json['success'] as bool?,
      message: json['message'] as String?,
      userData: json['data'] == null
          ? null
          : UserData.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$LoginResponseToJson(LoginResponse instance) =>
    <String, dynamic>{
      'success': instance.success,
      'message': instance.message,
      'data': instance.userData,
    };

UserData _$UserDataFromJson(Map<String, dynamic> json) => UserData(
  token: json['token'] as String?,
  salesmanData: json['salesman'] == null
      ? null
      : SalesmanData.fromJson(json['salesman'] as Map<String, dynamic>),
  storeData: json['store'] == null
      ? null
      : StoreData.fromJson(json['store'] as Map<String, dynamic>),
  deviceId: json['device_id'] as String?,
  tokenExpiresAt: json['token_expires_at'] as String?,
);

Map<String, dynamic> _$UserDataToJson(UserData instance) => <String, dynamic>{
  'token': instance.token,
  'salesman': instance.salesmanData,
  'store': instance.storeData,
  'device_id': instance.deviceId,
  'token_expires_at': instance.tokenExpiresAt,
};

SalesmanData _$SalesmanDataFromJson(Map<String, dynamic> json) => SalesmanData(
  id: (json['id'] as num?)?.toInt(),
  employeeId: json['employee_id'] as String?,
  name: json['name'] as String?,
  email: json['email'] as String?,
  phone: json['phone'] as String?,
  storeId: (json['store_id'] as num?)?.toInt(),
  storeName: json['store_name'] as String?,
  isActive: json['is_active'] as bool?,
  commissionRate: json['commission_rate'] as String?,
  salesTarget: json['sales_target'] as String?,
  monthlyTotalSales: json['monthly_total_sales'] as num?,
  yearlyTotalSales: json['yearly_total_sales'] as num?,
  achievementPercentage: json['achievement_percentage'] as num?,
  lastLoginAt: json['last_login_at'] as String?,
  discountSettings: json['discount_settings'] == null
      ? null
      : DiscountSettings.fromJson(
          json['discount_settings'] as Map<String, dynamic>,
        ),
);

Map<String, dynamic> _$SalesmanDataToJson(SalesmanData instance) =>
    <String, dynamic>{
      'id': instance.id,
      'employee_id': instance.employeeId,
      'name': instance.name,
      'email': instance.email,
      'phone': instance.phone,
      'store_id': instance.storeId,
      'store_name': instance.storeName,
      'is_active': instance.isActive,
      'commission_rate': instance.commissionRate,
      'sales_target': instance.salesTarget,
      'monthly_total_sales': instance.monthlyTotalSales,
      'yearly_total_sales': instance.yearlyTotalSales,
      'achievement_percentage': instance.achievementPercentage,
      'last_login_at': instance.lastLoginAt,
      'discount_settings': instance.discountSettings,
    };

DiscountSettings _$DiscountSettingsFromJson(Map<String, dynamic> json) =>
    DiscountSettings(
      canApplyDiscount: json['can_apply_discount'] as bool?,
      discountPassword: json['discount_password'] as String?,
      maxDiscountPercentage: json['max_discount_percentage'] as num?,
      maxDiscountFixed: json['max_discount_fixed'] as num?,
    );

Map<String, dynamic> _$DiscountSettingsToJson(DiscountSettings instance) =>
    <String, dynamic>{
      'can_apply_discount': instance.canApplyDiscount,
      'discount_password': instance.discountPassword,
      'max_discount_percentage': instance.maxDiscountPercentage,
      'max_discount_fixed': instance.maxDiscountFixed,
    };

StoreData _$StoreDataFromJson(Map<String, dynamic> json) => StoreData(
  id: (json['id'] as num?)?.toInt(),
  name: json['name'] as String?,
  address: json['address'] as String?,
  phone: json['phone'] as String?,
  status: (json['status'] as num?)?.toInt(),
  manager: json['manager'] == null
      ? null
      : ManagerData.fromJson(json['manager'] as Map<String, dynamic>),
);

Map<String, dynamic> _$StoreDataToJson(StoreData instance) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'address': instance.address,
  'phone': instance.phone,
  'status': instance.status,
  'manager': instance.manager,
};

ManagerData _$ManagerDataFromJson(Map<String, dynamic> json) => ManagerData(
  id: (json['id'] as num?)?.toInt(),
  name: json['name'] as String?,
);

Map<String, dynamic> _$ManagerDataToJson(ManagerData instance) =>
    <String, dynamic>{'id': instance.id, 'name': instance.name};
