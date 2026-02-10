import 'package:json_annotation/json_annotation.dart';

part 'profile_response.g.dart';

/// Custom converter to handle values that can be either String or num
num? _numFromJson(dynamic value) {
  if (value == null) return null;
  if (value is num) return value;
  if (value is String) return num.tryParse(value);
  return null;
}

@JsonSerializable()
class ProfileResponse {
  final bool? success;
  final ProfileData? data;

  ProfileResponse({this.success, this.data});

  factory ProfileResponse.fromJson(Map<String, dynamic> json) =>
      _$ProfileResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ProfileResponseToJson(this);
}

@JsonSerializable()
class ProfileData {
  final ProfileSalesman? salesman;
  final ProfileStore? store;
  final ProfilePerformance? performance;

  ProfileData({this.salesman, this.store, this.performance});

  factory ProfileData.fromJson(Map<String, dynamic> json) =>
      _$ProfileDataFromJson(json);

  Map<String, dynamic> toJson() => _$ProfileDataToJson(this);
}

@JsonSerializable()
class ProfileSalesman {
  final int? id;
  @JsonKey(name: 'employee_id')
  final String? employeeId;
  final String? name;
  final String? email;
  final String? phone;
  @JsonKey(name: 'store_id')
  final int? storeId;
  @JsonKey(name: 'store_name')
  final String? storeName;
  @JsonKey(name: 'is_active')
  final bool? isActive;
  @JsonKey(name: 'commission_rate')
  final String? commissionRate;
  @JsonKey(name: 'sales_target')
  final String? salesTarget;
  @JsonKey(name: 'monthly_total_sales')
  final num? monthlyTotalSales;
  @JsonKey(name: 'yearly_total_sales')
  final num? yearlyTotalSales;
  @JsonKey(name: 'achievement_percentage')
  final num? achievementPercentage;
  @JsonKey(name: 'last_login_at')
  final String? lastLoginAt;

  ProfileSalesman({
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
  });

  factory ProfileSalesman.fromJson(Map<String, dynamic> json) =>
      _$ProfileSalesmanFromJson(json);

  Map<String, dynamic> toJson() => _$ProfileSalesmanToJson(this);

  String get displayName => name ?? email ?? 'User';
}

@JsonSerializable()
class ProfileStore {
  final int? id;
  final String? name;
  final String? address;
  final String? phone;
  final int? status;
  final ProfileManager? manager;

  ProfileStore({
    this.id,
    this.name,
    this.address,
    this.phone,
    this.status,
    this.manager,
  });

  factory ProfileStore.fromJson(Map<String, dynamic> json) =>
      _$ProfileStoreFromJson(json);

  Map<String, dynamic> toJson() => _$ProfileStoreToJson(this);
}

@JsonSerializable()
class ProfileManager {
  final int? id;
  final String? name;

  ProfileManager({this.id, this.name});

  factory ProfileManager.fromJson(Map<String, dynamic> json) =>
      _$ProfileManagerFromJson(json);

  Map<String, dynamic> toJson() => _$ProfileManagerToJson(this);
}

@JsonSerializable()
class ProfilePerformance {
  final PerformanceToday? today;
  @JsonKey(name: 'this_month')
  final PerformanceMonth? thisMonth;

  ProfilePerformance({this.today, this.thisMonth});

  factory ProfilePerformance.fromJson(Map<String, dynamic> json) =>
      _$ProfilePerformanceFromJson(json);

  Map<String, dynamic> toJson() => _$ProfilePerformanceToJson(this);
}

@JsonSerializable()
class PerformanceToday {
  @JsonKey(name: 'orders_count')
  final int? ordersCount;
  @JsonKey(name: 'total_sales')
  final num? totalSales;

  PerformanceToday({this.ordersCount, this.totalSales});

  factory PerformanceToday.fromJson(Map<String, dynamic> json) =>
      _$PerformanceTodayFromJson(json);

  Map<String, dynamic> toJson() => _$PerformanceTodayToJson(this);
}

@JsonSerializable()
class PerformanceMonth {
  @JsonKey(name: 'orders_count')
  final int? ordersCount;
  @JsonKey(name: 'total_sales', fromJson: _numFromJson)
  final num? totalSales;
  @JsonKey(fromJson: _numFromJson)
  final num? target;
  @JsonKey(name: 'achievement_percentage', fromJson: _numFromJson)
  final num? achievementPercentage;

  PerformanceMonth({
    this.ordersCount,
    this.totalSales,
    this.target,
    this.achievementPercentage,
  });

  factory PerformanceMonth.fromJson(Map<String, dynamic> json) =>
      _$PerformanceMonthFromJson(json);

  Map<String, dynamic> toJson() => _$PerformanceMonthToJson(this);
}
