// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'home_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$HomeState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is HomeState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'HomeState()';
}


}

/// @nodoc
class $HomeStateCopyWith<$Res>  {
$HomeStateCopyWith(HomeState _, $Res Function(HomeState) __);
}


/// Adds pattern-matching-related methods to [HomeState].
extension HomeStatePatterns on HomeState {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( _Initial value)?  initial,TResult Function( GetCartLoading value)?  getCartLoading,TResult Function( GetCartSuccess value)?  getCartSuccess,TResult Function( GetCartError value)?  getCartError,TResult Function( AddRfidToCartError value)?  addRfidToCartError,TResult Function( DeleteCartItemLoading value)?  deleteCartItemLoading,TResult Function( DeleteCartItemSuccess value)?  deleteCartItemSuccess,TResult Function( DeleteCartItemError value)?  deleteCartItemError,required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial(_that);case GetCartLoading() when getCartLoading != null:
return getCartLoading(_that);case GetCartSuccess() when getCartSuccess != null:
return getCartSuccess(_that);case GetCartError() when getCartError != null:
return getCartError(_that);case AddRfidToCartError() when addRfidToCartError != null:
return addRfidToCartError(_that);case DeleteCartItemLoading() when deleteCartItemLoading != null:
return deleteCartItemLoading(_that);case DeleteCartItemSuccess() when deleteCartItemSuccess != null:
return deleteCartItemSuccess(_that);case DeleteCartItemError() when deleteCartItemError != null:
return deleteCartItemError(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( _Initial value)  initial,required TResult Function( GetCartLoading value)  getCartLoading,required TResult Function( GetCartSuccess value)  getCartSuccess,required TResult Function( GetCartError value)  getCartError,required TResult Function( AddRfidToCartError value)  addRfidToCartError,required TResult Function( DeleteCartItemLoading value)  deleteCartItemLoading,required TResult Function( DeleteCartItemSuccess value)  deleteCartItemSuccess,required TResult Function( DeleteCartItemError value)  deleteCartItemError,}){
final _that = this;
switch (_that) {
case _Initial():
return initial(_that);case GetCartLoading():
return getCartLoading(_that);case GetCartSuccess():
return getCartSuccess(_that);case GetCartError():
return getCartError(_that);case AddRfidToCartError():
return addRfidToCartError(_that);case DeleteCartItemLoading():
return deleteCartItemLoading(_that);case DeleteCartItemSuccess():
return deleteCartItemSuccess(_that);case DeleteCartItemError():
return deleteCartItemError(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( _Initial value)?  initial,TResult? Function( GetCartLoading value)?  getCartLoading,TResult? Function( GetCartSuccess value)?  getCartSuccess,TResult? Function( GetCartError value)?  getCartError,TResult? Function( AddRfidToCartError value)?  addRfidToCartError,TResult? Function( DeleteCartItemLoading value)?  deleteCartItemLoading,TResult? Function( DeleteCartItemSuccess value)?  deleteCartItemSuccess,TResult? Function( DeleteCartItemError value)?  deleteCartItemError,}){
final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial(_that);case GetCartLoading() when getCartLoading != null:
return getCartLoading(_that);case GetCartSuccess() when getCartSuccess != null:
return getCartSuccess(_that);case GetCartError() when getCartError != null:
return getCartError(_that);case AddRfidToCartError() when addRfidToCartError != null:
return addRfidToCartError(_that);case DeleteCartItemLoading() when deleteCartItemLoading != null:
return deleteCartItemLoading(_that);case DeleteCartItemSuccess() when deleteCartItemSuccess != null:
return deleteCartItemSuccess(_that);case DeleteCartItemError() when deleteCartItemError != null:
return deleteCartItemError(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  initial,TResult Function()?  getCartLoading,TResult Function( List<CartData?>? getCartData)?  getCartSuccess,TResult Function( ApiErrorModel apiErrorModel)?  getCartError,TResult Function( ApiErrorModel apiErrorModel)?  addRfidToCartError,TResult Function()?  deleteCartItemLoading,TResult Function( List<CartData?>? getCartData)?  deleteCartItemSuccess,TResult Function( ApiErrorModel apiErrorModel)?  deleteCartItemError,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial();case GetCartLoading() when getCartLoading != null:
return getCartLoading();case GetCartSuccess() when getCartSuccess != null:
return getCartSuccess(_that.getCartData);case GetCartError() when getCartError != null:
return getCartError(_that.apiErrorModel);case AddRfidToCartError() when addRfidToCartError != null:
return addRfidToCartError(_that.apiErrorModel);case DeleteCartItemLoading() when deleteCartItemLoading != null:
return deleteCartItemLoading();case DeleteCartItemSuccess() when deleteCartItemSuccess != null:
return deleteCartItemSuccess(_that.getCartData);case DeleteCartItemError() when deleteCartItemError != null:
return deleteCartItemError(_that.apiErrorModel);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  initial,required TResult Function()  getCartLoading,required TResult Function( List<CartData?>? getCartData)  getCartSuccess,required TResult Function( ApiErrorModel apiErrorModel)  getCartError,required TResult Function( ApiErrorModel apiErrorModel)  addRfidToCartError,required TResult Function()  deleteCartItemLoading,required TResult Function( List<CartData?>? getCartData)  deleteCartItemSuccess,required TResult Function( ApiErrorModel apiErrorModel)  deleteCartItemError,}) {final _that = this;
switch (_that) {
case _Initial():
return initial();case GetCartLoading():
return getCartLoading();case GetCartSuccess():
return getCartSuccess(_that.getCartData);case GetCartError():
return getCartError(_that.apiErrorModel);case AddRfidToCartError():
return addRfidToCartError(_that.apiErrorModel);case DeleteCartItemLoading():
return deleteCartItemLoading();case DeleteCartItemSuccess():
return deleteCartItemSuccess(_that.getCartData);case DeleteCartItemError():
return deleteCartItemError(_that.apiErrorModel);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  initial,TResult? Function()?  getCartLoading,TResult? Function( List<CartData?>? getCartData)?  getCartSuccess,TResult? Function( ApiErrorModel apiErrorModel)?  getCartError,TResult? Function( ApiErrorModel apiErrorModel)?  addRfidToCartError,TResult? Function()?  deleteCartItemLoading,TResult? Function( List<CartData?>? getCartData)?  deleteCartItemSuccess,TResult? Function( ApiErrorModel apiErrorModel)?  deleteCartItemError,}) {final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial();case GetCartLoading() when getCartLoading != null:
return getCartLoading();case GetCartSuccess() when getCartSuccess != null:
return getCartSuccess(_that.getCartData);case GetCartError() when getCartError != null:
return getCartError(_that.apiErrorModel);case AddRfidToCartError() when addRfidToCartError != null:
return addRfidToCartError(_that.apiErrorModel);case DeleteCartItemLoading() when deleteCartItemLoading != null:
return deleteCartItemLoading();case DeleteCartItemSuccess() when deleteCartItemSuccess != null:
return deleteCartItemSuccess(_that.getCartData);case DeleteCartItemError() when deleteCartItemError != null:
return deleteCartItemError(_that.apiErrorModel);case _:
  return null;

}
}

}

/// @nodoc


class _Initial implements HomeState {
  const _Initial();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Initial);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'HomeState.initial()';
}


}




/// @nodoc


class GetCartLoading implements HomeState {
  const GetCartLoading();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is GetCartLoading);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'HomeState.getCartLoading()';
}


}




/// @nodoc


class GetCartSuccess implements HomeState {
  const GetCartSuccess(final  List<CartData?>? getCartData): _getCartData = getCartData;
  

 final  List<CartData?>? _getCartData;
 List<CartData?>? get getCartData {
  final value = _getCartData;
  if (value == null) return null;
  if (_getCartData is EqualUnmodifiableListView) return _getCartData;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}


/// Create a copy of HomeState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$GetCartSuccessCopyWith<GetCartSuccess> get copyWith => _$GetCartSuccessCopyWithImpl<GetCartSuccess>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is GetCartSuccess&&const DeepCollectionEquality().equals(other._getCartData, _getCartData));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_getCartData));

@override
String toString() {
  return 'HomeState.getCartSuccess(getCartData: $getCartData)';
}


}

/// @nodoc
abstract mixin class $GetCartSuccessCopyWith<$Res> implements $HomeStateCopyWith<$Res> {
  factory $GetCartSuccessCopyWith(GetCartSuccess value, $Res Function(GetCartSuccess) _then) = _$GetCartSuccessCopyWithImpl;
@useResult
$Res call({
 List<CartData?>? getCartData
});




}
/// @nodoc
class _$GetCartSuccessCopyWithImpl<$Res>
    implements $GetCartSuccessCopyWith<$Res> {
  _$GetCartSuccessCopyWithImpl(this._self, this._then);

  final GetCartSuccess _self;
  final $Res Function(GetCartSuccess) _then;

/// Create a copy of HomeState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? getCartData = freezed,}) {
  return _then(GetCartSuccess(
freezed == getCartData ? _self._getCartData : getCartData // ignore: cast_nullable_to_non_nullable
as List<CartData?>?,
  ));
}


}

/// @nodoc


class GetCartError implements HomeState {
  const GetCartError(this.apiErrorModel);
  

 final  ApiErrorModel apiErrorModel;

/// Create a copy of HomeState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$GetCartErrorCopyWith<GetCartError> get copyWith => _$GetCartErrorCopyWithImpl<GetCartError>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is GetCartError&&(identical(other.apiErrorModel, apiErrorModel) || other.apiErrorModel == apiErrorModel));
}


@override
int get hashCode => Object.hash(runtimeType,apiErrorModel);

@override
String toString() {
  return 'HomeState.getCartError(apiErrorModel: $apiErrorModel)';
}


}

/// @nodoc
abstract mixin class $GetCartErrorCopyWith<$Res> implements $HomeStateCopyWith<$Res> {
  factory $GetCartErrorCopyWith(GetCartError value, $Res Function(GetCartError) _then) = _$GetCartErrorCopyWithImpl;
@useResult
$Res call({
 ApiErrorModel apiErrorModel
});




}
/// @nodoc
class _$GetCartErrorCopyWithImpl<$Res>
    implements $GetCartErrorCopyWith<$Res> {
  _$GetCartErrorCopyWithImpl(this._self, this._then);

  final GetCartError _self;
  final $Res Function(GetCartError) _then;

/// Create a copy of HomeState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? apiErrorModel = null,}) {
  return _then(GetCartError(
null == apiErrorModel ? _self.apiErrorModel : apiErrorModel // ignore: cast_nullable_to_non_nullable
as ApiErrorModel,
  ));
}


}

/// @nodoc


class AddRfidToCartError implements HomeState {
  const AddRfidToCartError(this.apiErrorModel);
  

 final  ApiErrorModel apiErrorModel;

/// Create a copy of HomeState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AddRfidToCartErrorCopyWith<AddRfidToCartError> get copyWith => _$AddRfidToCartErrorCopyWithImpl<AddRfidToCartError>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AddRfidToCartError&&(identical(other.apiErrorModel, apiErrorModel) || other.apiErrorModel == apiErrorModel));
}


@override
int get hashCode => Object.hash(runtimeType,apiErrorModel);

@override
String toString() {
  return 'HomeState.addRfidToCartError(apiErrorModel: $apiErrorModel)';
}


}

/// @nodoc
abstract mixin class $AddRfidToCartErrorCopyWith<$Res> implements $HomeStateCopyWith<$Res> {
  factory $AddRfidToCartErrorCopyWith(AddRfidToCartError value, $Res Function(AddRfidToCartError) _then) = _$AddRfidToCartErrorCopyWithImpl;
@useResult
$Res call({
 ApiErrorModel apiErrorModel
});




}
/// @nodoc
class _$AddRfidToCartErrorCopyWithImpl<$Res>
    implements $AddRfidToCartErrorCopyWith<$Res> {
  _$AddRfidToCartErrorCopyWithImpl(this._self, this._then);

  final AddRfidToCartError _self;
  final $Res Function(AddRfidToCartError) _then;

/// Create a copy of HomeState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? apiErrorModel = null,}) {
  return _then(AddRfidToCartError(
null == apiErrorModel ? _self.apiErrorModel : apiErrorModel // ignore: cast_nullable_to_non_nullable
as ApiErrorModel,
  ));
}


}

/// @nodoc


class DeleteCartItemLoading implements HomeState {
  const DeleteCartItemLoading();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DeleteCartItemLoading);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'HomeState.deleteCartItemLoading()';
}


}




/// @nodoc


class DeleteCartItemSuccess implements HomeState {
  const DeleteCartItemSuccess(final  List<CartData?>? getCartData): _getCartData = getCartData;
  

 final  List<CartData?>? _getCartData;
 List<CartData?>? get getCartData {
  final value = _getCartData;
  if (value == null) return null;
  if (_getCartData is EqualUnmodifiableListView) return _getCartData;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}


/// Create a copy of HomeState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DeleteCartItemSuccessCopyWith<DeleteCartItemSuccess> get copyWith => _$DeleteCartItemSuccessCopyWithImpl<DeleteCartItemSuccess>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DeleteCartItemSuccess&&const DeepCollectionEquality().equals(other._getCartData, _getCartData));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_getCartData));

@override
String toString() {
  return 'HomeState.deleteCartItemSuccess(getCartData: $getCartData)';
}


}

/// @nodoc
abstract mixin class $DeleteCartItemSuccessCopyWith<$Res> implements $HomeStateCopyWith<$Res> {
  factory $DeleteCartItemSuccessCopyWith(DeleteCartItemSuccess value, $Res Function(DeleteCartItemSuccess) _then) = _$DeleteCartItemSuccessCopyWithImpl;
@useResult
$Res call({
 List<CartData?>? getCartData
});




}
/// @nodoc
class _$DeleteCartItemSuccessCopyWithImpl<$Res>
    implements $DeleteCartItemSuccessCopyWith<$Res> {
  _$DeleteCartItemSuccessCopyWithImpl(this._self, this._then);

  final DeleteCartItemSuccess _self;
  final $Res Function(DeleteCartItemSuccess) _then;

/// Create a copy of HomeState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? getCartData = freezed,}) {
  return _then(DeleteCartItemSuccess(
freezed == getCartData ? _self._getCartData : getCartData // ignore: cast_nullable_to_non_nullable
as List<CartData?>?,
  ));
}


}

/// @nodoc


class DeleteCartItemError implements HomeState {
  const DeleteCartItemError(this.apiErrorModel);
  

 final  ApiErrorModel apiErrorModel;

/// Create a copy of HomeState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DeleteCartItemErrorCopyWith<DeleteCartItemError> get copyWith => _$DeleteCartItemErrorCopyWithImpl<DeleteCartItemError>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DeleteCartItemError&&(identical(other.apiErrorModel, apiErrorModel) || other.apiErrorModel == apiErrorModel));
}


@override
int get hashCode => Object.hash(runtimeType,apiErrorModel);

@override
String toString() {
  return 'HomeState.deleteCartItemError(apiErrorModel: $apiErrorModel)';
}


}

/// @nodoc
abstract mixin class $DeleteCartItemErrorCopyWith<$Res> implements $HomeStateCopyWith<$Res> {
  factory $DeleteCartItemErrorCopyWith(DeleteCartItemError value, $Res Function(DeleteCartItemError) _then) = _$DeleteCartItemErrorCopyWithImpl;
@useResult
$Res call({
 ApiErrorModel apiErrorModel
});




}
/// @nodoc
class _$DeleteCartItemErrorCopyWithImpl<$Res>
    implements $DeleteCartItemErrorCopyWith<$Res> {
  _$DeleteCartItemErrorCopyWithImpl(this._self, this._then);

  final DeleteCartItemError _self;
  final $Res Function(DeleteCartItemError) _then;

/// Create a copy of HomeState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? apiErrorModel = null,}) {
  return _then(DeleteCartItemError(
null == apiErrorModel ? _self.apiErrorModel : apiErrorModel // ignore: cast_nullable_to_non_nullable
as ApiErrorModel,
  ));
}


}

// dart format on
