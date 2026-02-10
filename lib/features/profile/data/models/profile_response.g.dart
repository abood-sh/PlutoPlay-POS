// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profile_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProfileResponse _$ProfileResponseFromJson(Map<String, dynamic> json) =>
    ProfileResponse(
      success: json['success'] as bool?,
      data: json['data'] == null
          ? null
          : ProfileData.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ProfileResponseToJson(ProfileResponse instance) =>
    <String, dynamic>{'success': instance.success, 'data': instance.data};

ProfileData _$ProfileDataFromJson(Map<String, dynamic> json) => ProfileData(
  salesman: json['salesman'] == null
      ? null
      : ProfileSalesman.fromJson(json['salesman'] as Map<String, dynamic>),
  store: json['store'] == null
      ? null
      : ProfileStore.fromJson(json['store'] as Map<String, dynamic>),
  performance: json['performance'] == null
      ? null
      : ProfilePerformance.fromJson(
          json['performance'] as Map<String, dynamic>,
        ),
);

Map<String, dynamic> _$ProfileDataToJson(ProfileData instance) =>
    <String, dynamic>{
      'salesman': instance.salesman,
      'store': instance.store,
      'performance': instance.performance,
    };

ProfileSalesman _$ProfileSalesmanFromJson(Map<String, dynamic> json) =>
    ProfileSalesman(
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
    );

Map<String, dynamic> _$ProfileSalesmanToJson(ProfileSalesman instance) =>
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
    };

ProfileStore _$ProfileStoreFromJson(Map<String, dynamic> json) => ProfileStore(
  id: (json['id'] as num?)?.toInt(),
  name: json['name'] as String?,
  address: json['address'] as String?,
  phone: json['phone'] as String?,
  status: (json['status'] as num?)?.toInt(),
  manager: json['manager'] == null
      ? null
      : ProfileManager.fromJson(json['manager'] as Map<String, dynamic>),
);

Map<String, dynamic> _$ProfileStoreToJson(ProfileStore instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'address': instance.address,
      'phone': instance.phone,
      'status': instance.status,
      'manager': instance.manager,
    };

ProfileManager _$ProfileManagerFromJson(Map<String, dynamic> json) =>
    ProfileManager(
      id: (json['id'] as num?)?.toInt(),
      name: json['name'] as String?,
    );

Map<String, dynamic> _$ProfileManagerToJson(ProfileManager instance) =>
    <String, dynamic>{'id': instance.id, 'name': instance.name};

ProfilePerformance _$ProfilePerformanceFromJson(Map<String, dynamic> json) =>
    ProfilePerformance(
      today: json['today'] == null
          ? null
          : PerformanceToday.fromJson(json['today'] as Map<String, dynamic>),
      thisMonth: json['this_month'] == null
          ? null
          : PerformanceMonth.fromJson(
              json['this_month'] as Map<String, dynamic>,
            ),
    );

Map<String, dynamic> _$ProfilePerformanceToJson(ProfilePerformance instance) =>
    <String, dynamic>{
      'today': instance.today,
      'this_month': instance.thisMonth,
    };

PerformanceToday _$PerformanceTodayFromJson(Map<String, dynamic> json) =>
    PerformanceToday(
      ordersCount: (json['orders_count'] as num?)?.toInt(),
      totalSales: json['total_sales'] as num?,
    );

Map<String, dynamic> _$PerformanceTodayToJson(PerformanceToday instance) =>
    <String, dynamic>{
      'orders_count': instance.ordersCount,
      'total_sales': instance.totalSales,
    };

PerformanceMonth _$PerformanceMonthFromJson(Map<String, dynamic> json) =>
    PerformanceMonth(
      ordersCount: (json['orders_count'] as num?)?.toInt(),
      totalSales: _numFromJson(json['total_sales']),
      target: _numFromJson(json['target']),
      achievementPercentage: _numFromJson(json['achievement_percentage']),
    );

Map<String, dynamic> _$PerformanceMonthToJson(PerformanceMonth instance) =>
    <String, dynamic>{
      'orders_count': instance.ordersCount,
      'total_sales': instance.totalSales,
      'target': instance.target,
      'achievement_percentage': instance.achievementPercentage,
    };
