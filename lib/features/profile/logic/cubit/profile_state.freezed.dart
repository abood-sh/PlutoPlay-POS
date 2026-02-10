// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'profile_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ProfileState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ProfileState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ProfileState()';
}


}

/// @nodoc
class $ProfileStateCopyWith<$Res>  {
$ProfileStateCopyWith(ProfileState _, $Res Function(ProfileState) __);
}


/// Adds pattern-matching-related methods to [ProfileState].
extension ProfileStatePatterns on ProfileState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( ProfileInitial value)?  initial,TResult Function( ProfileLoading value)?  loading,TResult Function( ProfileSuccess value)?  success,TResult Function( ProfileError value)?  error,TResult Function( ProfileLoggingOut value)?  loggingOut,TResult Function( ProfileLogoutSuccess value)?  logoutSuccess,TResult Function( ProfilePrinterUpdated value)?  printerUpdated,required TResult orElse(),}){
final _that = this;
switch (_that) {
case ProfileInitial() when initial != null:
return initial(_that);case ProfileLoading() when loading != null:
return loading(_that);case ProfileSuccess() when success != null:
return success(_that);case ProfileError() when error != null:
return error(_that);case ProfileLoggingOut() when loggingOut != null:
return loggingOut(_that);case ProfileLogoutSuccess() when logoutSuccess != null:
return logoutSuccess(_that);case ProfilePrinterUpdated() when printerUpdated != null:
return printerUpdated(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( ProfileInitial value)  initial,required TResult Function( ProfileLoading value)  loading,required TResult Function( ProfileSuccess value)  success,required TResult Function( ProfileError value)  error,required TResult Function( ProfileLoggingOut value)  loggingOut,required TResult Function( ProfileLogoutSuccess value)  logoutSuccess,required TResult Function( ProfilePrinterUpdated value)  printerUpdated,}){
final _that = this;
switch (_that) {
case ProfileInitial():
return initial(_that);case ProfileLoading():
return loading(_that);case ProfileSuccess():
return success(_that);case ProfileError():
return error(_that);case ProfileLoggingOut():
return loggingOut(_that);case ProfileLogoutSuccess():
return logoutSuccess(_that);case ProfilePrinterUpdated():
return printerUpdated(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( ProfileInitial value)?  initial,TResult? Function( ProfileLoading value)?  loading,TResult? Function( ProfileSuccess value)?  success,TResult? Function( ProfileError value)?  error,TResult? Function( ProfileLoggingOut value)?  loggingOut,TResult? Function( ProfileLogoutSuccess value)?  logoutSuccess,TResult? Function( ProfilePrinterUpdated value)?  printerUpdated,}){
final _that = this;
switch (_that) {
case ProfileInitial() when initial != null:
return initial(_that);case ProfileLoading() when loading != null:
return loading(_that);case ProfileSuccess() when success != null:
return success(_that);case ProfileError() when error != null:
return error(_that);case ProfileLoggingOut() when loggingOut != null:
return loggingOut(_that);case ProfileLogoutSuccess() when logoutSuccess != null:
return logoutSuccess(_that);case ProfilePrinterUpdated() when printerUpdated != null:
return printerUpdated(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  initial,TResult Function()?  loading,TResult Function( ProfileData profileData,  PrinterModel? selectedPrinter)?  success,TResult Function( ApiErrorModel error)?  error,TResult Function()?  loggingOut,TResult Function()?  logoutSuccess,TResult Function( PrinterModel printer)?  printerUpdated,required TResult orElse(),}) {final _that = this;
switch (_that) {
case ProfileInitial() when initial != null:
return initial();case ProfileLoading() when loading != null:
return loading();case ProfileSuccess() when success != null:
return success(_that.profileData,_that.selectedPrinter);case ProfileError() when error != null:
return error(_that.error);case ProfileLoggingOut() when loggingOut != null:
return loggingOut();case ProfileLogoutSuccess() when logoutSuccess != null:
return logoutSuccess();case ProfilePrinterUpdated() when printerUpdated != null:
return printerUpdated(_that.printer);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  initial,required TResult Function()  loading,required TResult Function( ProfileData profileData,  PrinterModel? selectedPrinter)  success,required TResult Function( ApiErrorModel error)  error,required TResult Function()  loggingOut,required TResult Function()  logoutSuccess,required TResult Function( PrinterModel printer)  printerUpdated,}) {final _that = this;
switch (_that) {
case ProfileInitial():
return initial();case ProfileLoading():
return loading();case ProfileSuccess():
return success(_that.profileData,_that.selectedPrinter);case ProfileError():
return error(_that.error);case ProfileLoggingOut():
return loggingOut();case ProfileLogoutSuccess():
return logoutSuccess();case ProfilePrinterUpdated():
return printerUpdated(_that.printer);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  initial,TResult? Function()?  loading,TResult? Function( ProfileData profileData,  PrinterModel? selectedPrinter)?  success,TResult? Function( ApiErrorModel error)?  error,TResult? Function()?  loggingOut,TResult? Function()?  logoutSuccess,TResult? Function( PrinterModel printer)?  printerUpdated,}) {final _that = this;
switch (_that) {
case ProfileInitial() when initial != null:
return initial();case ProfileLoading() when loading != null:
return loading();case ProfileSuccess() when success != null:
return success(_that.profileData,_that.selectedPrinter);case ProfileError() when error != null:
return error(_that.error);case ProfileLoggingOut() when loggingOut != null:
return loggingOut();case ProfileLogoutSuccess() when logoutSuccess != null:
return logoutSuccess();case ProfilePrinterUpdated() when printerUpdated != null:
return printerUpdated(_that.printer);case _:
  return null;

}
}

}

/// @nodoc


class ProfileInitial implements ProfileState {
  const ProfileInitial();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ProfileInitial);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ProfileState.initial()';
}


}




/// @nodoc


class ProfileLoading implements ProfileState {
  const ProfileLoading();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ProfileLoading);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ProfileState.loading()';
}


}




/// @nodoc


class ProfileSuccess implements ProfileState {
  const ProfileSuccess({required this.profileData, this.selectedPrinter});
  

 final  ProfileData profileData;
 final  PrinterModel? selectedPrinter;

/// Create a copy of ProfileState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ProfileSuccessCopyWith<ProfileSuccess> get copyWith => _$ProfileSuccessCopyWithImpl<ProfileSuccess>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ProfileSuccess&&(identical(other.profileData, profileData) || other.profileData == profileData)&&(identical(other.selectedPrinter, selectedPrinter) || other.selectedPrinter == selectedPrinter));
}


@override
int get hashCode => Object.hash(runtimeType,profileData,selectedPrinter);

@override
String toString() {
  return 'ProfileState.success(profileData: $profileData, selectedPrinter: $selectedPrinter)';
}


}

/// @nodoc
abstract mixin class $ProfileSuccessCopyWith<$Res> implements $ProfileStateCopyWith<$Res> {
  factory $ProfileSuccessCopyWith(ProfileSuccess value, $Res Function(ProfileSuccess) _then) = _$ProfileSuccessCopyWithImpl;
@useResult
$Res call({
 ProfileData profileData, PrinterModel? selectedPrinter
});




}
/// @nodoc
class _$ProfileSuccessCopyWithImpl<$Res>
    implements $ProfileSuccessCopyWith<$Res> {
  _$ProfileSuccessCopyWithImpl(this._self, this._then);

  final ProfileSuccess _self;
  final $Res Function(ProfileSuccess) _then;

/// Create a copy of ProfileState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? profileData = null,Object? selectedPrinter = freezed,}) {
  return _then(ProfileSuccess(
profileData: null == profileData ? _self.profileData : profileData // ignore: cast_nullable_to_non_nullable
as ProfileData,selectedPrinter: freezed == selectedPrinter ? _self.selectedPrinter : selectedPrinter // ignore: cast_nullable_to_non_nullable
as PrinterModel?,
  ));
}


}

/// @nodoc


class ProfileError implements ProfileState {
  const ProfileError(this.error);
  

 final  ApiErrorModel error;

/// Create a copy of ProfileState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ProfileErrorCopyWith<ProfileError> get copyWith => _$ProfileErrorCopyWithImpl<ProfileError>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ProfileError&&(identical(other.error, error) || other.error == error));
}


@override
int get hashCode => Object.hash(runtimeType,error);

@override
String toString() {
  return 'ProfileState.error(error: $error)';
}


}

/// @nodoc
abstract mixin class $ProfileErrorCopyWith<$Res> implements $ProfileStateCopyWith<$Res> {
  factory $ProfileErrorCopyWith(ProfileError value, $Res Function(ProfileError) _then) = _$ProfileErrorCopyWithImpl;
@useResult
$Res call({
 ApiErrorModel error
});




}
/// @nodoc
class _$ProfileErrorCopyWithImpl<$Res>
    implements $ProfileErrorCopyWith<$Res> {
  _$ProfileErrorCopyWithImpl(this._self, this._then);

  final ProfileError _self;
  final $Res Function(ProfileError) _then;

/// Create a copy of ProfileState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? error = null,}) {
  return _then(ProfileError(
null == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as ApiErrorModel,
  ));
}


}

/// @nodoc


class ProfileLoggingOut implements ProfileState {
  const ProfileLoggingOut();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ProfileLoggingOut);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ProfileState.loggingOut()';
}


}




/// @nodoc


class ProfileLogoutSuccess implements ProfileState {
  const ProfileLogoutSuccess();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ProfileLogoutSuccess);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ProfileState.logoutSuccess()';
}


}




/// @nodoc


class ProfilePrinterUpdated implements ProfileState {
  const ProfilePrinterUpdated(this.printer);
  

 final  PrinterModel printer;

/// Create a copy of ProfileState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ProfilePrinterUpdatedCopyWith<ProfilePrinterUpdated> get copyWith => _$ProfilePrinterUpdatedCopyWithImpl<ProfilePrinterUpdated>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ProfilePrinterUpdated&&(identical(other.printer, printer) || other.printer == printer));
}


@override
int get hashCode => Object.hash(runtimeType,printer);

@override
String toString() {
  return 'ProfileState.printerUpdated(printer: $printer)';
}


}

/// @nodoc
abstract mixin class $ProfilePrinterUpdatedCopyWith<$Res> implements $ProfileStateCopyWith<$Res> {
  factory $ProfilePrinterUpdatedCopyWith(ProfilePrinterUpdated value, $Res Function(ProfilePrinterUpdated) _then) = _$ProfilePrinterUpdatedCopyWithImpl;
@useResult
$Res call({
 PrinterModel printer
});




}
/// @nodoc
class _$ProfilePrinterUpdatedCopyWithImpl<$Res>
    implements $ProfilePrinterUpdatedCopyWith<$Res> {
  _$ProfilePrinterUpdatedCopyWithImpl(this._self, this._then);

  final ProfilePrinterUpdated _self;
  final $Res Function(ProfilePrinterUpdated) _then;

/// Create a copy of ProfileState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? printer = null,}) {
  return _then(ProfilePrinterUpdated(
null == printer ? _self.printer : printer // ignore: cast_nullable_to_non_nullable
as PrinterModel,
  ));
}


}

// dart format on
