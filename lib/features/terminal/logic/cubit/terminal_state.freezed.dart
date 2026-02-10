// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'terminal_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$TerminalState<T> {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TerminalState<T>);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'TerminalState<$T>()';
}


}

/// @nodoc
class $TerminalStateCopyWith<T,$Res>  {
$TerminalStateCopyWith(TerminalState<T> _, $Res Function(TerminalState<T>) __);
}


/// Adds pattern-matching-related methods to [TerminalState].
extension TerminalStatePatterns<T> on TerminalState<T> {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( _Initial<T> value)?  initial,TResult Function( Loading<T> value)?  loading,TResult Function( Success<T> value)?  success,TResult Function( TerminalSelected<T> value)?  terminalSelected,TResult Function( Error<T> value)?  error,TResult Function( SdkInitializing<T> value)?  sdkInitializing,TResult Function( SdkInitialized<T> value)?  sdkInitialized,TResult Function( SdkError<T> value)?  sdkError,TResult Function( DiscoveringReaders<T> value)?  discoveringReaders,TResult Function( ReadersDiscovered<T> value)?  readersDiscovered,TResult Function( NoReadersFound<T> value)?  noReadersFound,TResult Function( ReaderConnecting<T> value)?  readerConnecting,TResult Function( ReaderConnected<T> value)?  readerConnected,TResult Function( ReaderConnectionError<T> value)?  readerConnectionError,required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial(_that);case Loading() when loading != null:
return loading(_that);case Success() when success != null:
return success(_that);case TerminalSelected() when terminalSelected != null:
return terminalSelected(_that);case Error() when error != null:
return error(_that);case SdkInitializing() when sdkInitializing != null:
return sdkInitializing(_that);case SdkInitialized() when sdkInitialized != null:
return sdkInitialized(_that);case SdkError() when sdkError != null:
return sdkError(_that);case DiscoveringReaders() when discoveringReaders != null:
return discoveringReaders(_that);case ReadersDiscovered() when readersDiscovered != null:
return readersDiscovered(_that);case NoReadersFound() when noReadersFound != null:
return noReadersFound(_that);case ReaderConnecting() when readerConnecting != null:
return readerConnecting(_that);case ReaderConnected() when readerConnected != null:
return readerConnected(_that);case ReaderConnectionError() when readerConnectionError != null:
return readerConnectionError(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( _Initial<T> value)  initial,required TResult Function( Loading<T> value)  loading,required TResult Function( Success<T> value)  success,required TResult Function( TerminalSelected<T> value)  terminalSelected,required TResult Function( Error<T> value)  error,required TResult Function( SdkInitializing<T> value)  sdkInitializing,required TResult Function( SdkInitialized<T> value)  sdkInitialized,required TResult Function( SdkError<T> value)  sdkError,required TResult Function( DiscoveringReaders<T> value)  discoveringReaders,required TResult Function( ReadersDiscovered<T> value)  readersDiscovered,required TResult Function( NoReadersFound<T> value)  noReadersFound,required TResult Function( ReaderConnecting<T> value)  readerConnecting,required TResult Function( ReaderConnected<T> value)  readerConnected,required TResult Function( ReaderConnectionError<T> value)  readerConnectionError,}){
final _that = this;
switch (_that) {
case _Initial():
return initial(_that);case Loading():
return loading(_that);case Success():
return success(_that);case TerminalSelected():
return terminalSelected(_that);case Error():
return error(_that);case SdkInitializing():
return sdkInitializing(_that);case SdkInitialized():
return sdkInitialized(_that);case SdkError():
return sdkError(_that);case DiscoveringReaders():
return discoveringReaders(_that);case ReadersDiscovered():
return readersDiscovered(_that);case NoReadersFound():
return noReadersFound(_that);case ReaderConnecting():
return readerConnecting(_that);case ReaderConnected():
return readerConnected(_that);case ReaderConnectionError():
return readerConnectionError(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( _Initial<T> value)?  initial,TResult? Function( Loading<T> value)?  loading,TResult? Function( Success<T> value)?  success,TResult? Function( TerminalSelected<T> value)?  terminalSelected,TResult? Function( Error<T> value)?  error,TResult? Function( SdkInitializing<T> value)?  sdkInitializing,TResult? Function( SdkInitialized<T> value)?  sdkInitialized,TResult? Function( SdkError<T> value)?  sdkError,TResult? Function( DiscoveringReaders<T> value)?  discoveringReaders,TResult? Function( ReadersDiscovered<T> value)?  readersDiscovered,TResult? Function( NoReadersFound<T> value)?  noReadersFound,TResult? Function( ReaderConnecting<T> value)?  readerConnecting,TResult? Function( ReaderConnected<T> value)?  readerConnected,TResult? Function( ReaderConnectionError<T> value)?  readerConnectionError,}){
final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial(_that);case Loading() when loading != null:
return loading(_that);case Success() when success != null:
return success(_that);case TerminalSelected() when terminalSelected != null:
return terminalSelected(_that);case Error() when error != null:
return error(_that);case SdkInitializing() when sdkInitializing != null:
return sdkInitializing(_that);case SdkInitialized() when sdkInitialized != null:
return sdkInitialized(_that);case SdkError() when sdkError != null:
return sdkError(_that);case DiscoveringReaders() when discoveringReaders != null:
return discoveringReaders(_that);case ReadersDiscovered() when readersDiscovered != null:
return readersDiscovered(_that);case NoReadersFound() when noReadersFound != null:
return noReadersFound(_that);case ReaderConnecting() when readerConnecting != null:
return readerConnecting(_that);case ReaderConnected() when readerConnected != null:
return readerConnected(_that);case ReaderConnectionError() when readerConnectionError != null:
return readerConnectionError(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  initial,TResult Function()?  loading,TResult Function( T data)?  success,TResult Function()?  terminalSelected,TResult Function( ApiErrorModel apiErrorModel)?  error,TResult Function()?  sdkInitializing,TResult Function()?  sdkInitialized,TResult Function( String message)?  sdkError,TResult Function()?  discoveringReaders,TResult Function( List<Reader> readers)?  readersDiscovered,TResult Function()?  noReadersFound,TResult Function()?  readerConnecting,TResult Function( String readerLabel)?  readerConnected,TResult Function( String message)?  readerConnectionError,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial();case Loading() when loading != null:
return loading();case Success() when success != null:
return success(_that.data);case TerminalSelected() when terminalSelected != null:
return terminalSelected();case Error() when error != null:
return error(_that.apiErrorModel);case SdkInitializing() when sdkInitializing != null:
return sdkInitializing();case SdkInitialized() when sdkInitialized != null:
return sdkInitialized();case SdkError() when sdkError != null:
return sdkError(_that.message);case DiscoveringReaders() when discoveringReaders != null:
return discoveringReaders();case ReadersDiscovered() when readersDiscovered != null:
return readersDiscovered(_that.readers);case NoReadersFound() when noReadersFound != null:
return noReadersFound();case ReaderConnecting() when readerConnecting != null:
return readerConnecting();case ReaderConnected() when readerConnected != null:
return readerConnected(_that.readerLabel);case ReaderConnectionError() when readerConnectionError != null:
return readerConnectionError(_that.message);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  initial,required TResult Function()  loading,required TResult Function( T data)  success,required TResult Function()  terminalSelected,required TResult Function( ApiErrorModel apiErrorModel)  error,required TResult Function()  sdkInitializing,required TResult Function()  sdkInitialized,required TResult Function( String message)  sdkError,required TResult Function()  discoveringReaders,required TResult Function( List<Reader> readers)  readersDiscovered,required TResult Function()  noReadersFound,required TResult Function()  readerConnecting,required TResult Function( String readerLabel)  readerConnected,required TResult Function( String message)  readerConnectionError,}) {final _that = this;
switch (_that) {
case _Initial():
return initial();case Loading():
return loading();case Success():
return success(_that.data);case TerminalSelected():
return terminalSelected();case Error():
return error(_that.apiErrorModel);case SdkInitializing():
return sdkInitializing();case SdkInitialized():
return sdkInitialized();case SdkError():
return sdkError(_that.message);case DiscoveringReaders():
return discoveringReaders();case ReadersDiscovered():
return readersDiscovered(_that.readers);case NoReadersFound():
return noReadersFound();case ReaderConnecting():
return readerConnecting();case ReaderConnected():
return readerConnected(_that.readerLabel);case ReaderConnectionError():
return readerConnectionError(_that.message);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  initial,TResult? Function()?  loading,TResult? Function( T data)?  success,TResult? Function()?  terminalSelected,TResult? Function( ApiErrorModel apiErrorModel)?  error,TResult? Function()?  sdkInitializing,TResult? Function()?  sdkInitialized,TResult? Function( String message)?  sdkError,TResult? Function()?  discoveringReaders,TResult? Function( List<Reader> readers)?  readersDiscovered,TResult? Function()?  noReadersFound,TResult? Function()?  readerConnecting,TResult? Function( String readerLabel)?  readerConnected,TResult? Function( String message)?  readerConnectionError,}) {final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial();case Loading() when loading != null:
return loading();case Success() when success != null:
return success(_that.data);case TerminalSelected() when terminalSelected != null:
return terminalSelected();case Error() when error != null:
return error(_that.apiErrorModel);case SdkInitializing() when sdkInitializing != null:
return sdkInitializing();case SdkInitialized() when sdkInitialized != null:
return sdkInitialized();case SdkError() when sdkError != null:
return sdkError(_that.message);case DiscoveringReaders() when discoveringReaders != null:
return discoveringReaders();case ReadersDiscovered() when readersDiscovered != null:
return readersDiscovered(_that.readers);case NoReadersFound() when noReadersFound != null:
return noReadersFound();case ReaderConnecting() when readerConnecting != null:
return readerConnecting();case ReaderConnected() when readerConnected != null:
return readerConnected(_that.readerLabel);case ReaderConnectionError() when readerConnectionError != null:
return readerConnectionError(_that.message);case _:
  return null;

}
}

}

/// @nodoc


class _Initial<T> implements TerminalState<T> {
  const _Initial();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Initial<T>);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'TerminalState<$T>.initial()';
}


}




/// @nodoc


class Loading<T> implements TerminalState<T> {
  const Loading();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Loading<T>);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'TerminalState<$T>.loading()';
}


}




/// @nodoc


class Success<T> implements TerminalState<T> {
  const Success(this.data);
  

 final  T data;

/// Create a copy of TerminalState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SuccessCopyWith<T, Success<T>> get copyWith => _$SuccessCopyWithImpl<T, Success<T>>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Success<T>&&const DeepCollectionEquality().equals(other.data, data));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(data));

@override
String toString() {
  return 'TerminalState<$T>.success(data: $data)';
}


}

/// @nodoc
abstract mixin class $SuccessCopyWith<T,$Res> implements $TerminalStateCopyWith<T, $Res> {
  factory $SuccessCopyWith(Success<T> value, $Res Function(Success<T>) _then) = _$SuccessCopyWithImpl;
@useResult
$Res call({
 T data
});




}
/// @nodoc
class _$SuccessCopyWithImpl<T,$Res>
    implements $SuccessCopyWith<T, $Res> {
  _$SuccessCopyWithImpl(this._self, this._then);

  final Success<T> _self;
  final $Res Function(Success<T>) _then;

/// Create a copy of TerminalState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? data = freezed,}) {
  return _then(Success<T>(
freezed == data ? _self.data : data // ignore: cast_nullable_to_non_nullable
as T,
  ));
}


}

/// @nodoc


class TerminalSelected<T> implements TerminalState<T> {
  const TerminalSelected();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TerminalSelected<T>);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'TerminalState<$T>.terminalSelected()';
}


}




/// @nodoc


class Error<T> implements TerminalState<T> {
  const Error(this.apiErrorModel);
  

 final  ApiErrorModel apiErrorModel;

/// Create a copy of TerminalState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ErrorCopyWith<T, Error<T>> get copyWith => _$ErrorCopyWithImpl<T, Error<T>>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Error<T>&&(identical(other.apiErrorModel, apiErrorModel) || other.apiErrorModel == apiErrorModel));
}


@override
int get hashCode => Object.hash(runtimeType,apiErrorModel);

@override
String toString() {
  return 'TerminalState<$T>.error(apiErrorModel: $apiErrorModel)';
}


}

/// @nodoc
abstract mixin class $ErrorCopyWith<T,$Res> implements $TerminalStateCopyWith<T, $Res> {
  factory $ErrorCopyWith(Error<T> value, $Res Function(Error<T>) _then) = _$ErrorCopyWithImpl;
@useResult
$Res call({
 ApiErrorModel apiErrorModel
});




}
/// @nodoc
class _$ErrorCopyWithImpl<T,$Res>
    implements $ErrorCopyWith<T, $Res> {
  _$ErrorCopyWithImpl(this._self, this._then);

  final Error<T> _self;
  final $Res Function(Error<T>) _then;

/// Create a copy of TerminalState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? apiErrorModel = null,}) {
  return _then(Error<T>(
null == apiErrorModel ? _self.apiErrorModel : apiErrorModel // ignore: cast_nullable_to_non_nullable
as ApiErrorModel,
  ));
}


}

/// @nodoc


class SdkInitializing<T> implements TerminalState<T> {
  const SdkInitializing();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SdkInitializing<T>);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'TerminalState<$T>.sdkInitializing()';
}


}




/// @nodoc


class SdkInitialized<T> implements TerminalState<T> {
  const SdkInitialized();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SdkInitialized<T>);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'TerminalState<$T>.sdkInitialized()';
}


}




/// @nodoc


class SdkError<T> implements TerminalState<T> {
  const SdkError(this.message);
  

 final  String message;

/// Create a copy of TerminalState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SdkErrorCopyWith<T, SdkError<T>> get copyWith => _$SdkErrorCopyWithImpl<T, SdkError<T>>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SdkError<T>&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,message);

@override
String toString() {
  return 'TerminalState<$T>.sdkError(message: $message)';
}


}

/// @nodoc
abstract mixin class $SdkErrorCopyWith<T,$Res> implements $TerminalStateCopyWith<T, $Res> {
  factory $SdkErrorCopyWith(SdkError<T> value, $Res Function(SdkError<T>) _then) = _$SdkErrorCopyWithImpl;
@useResult
$Res call({
 String message
});




}
/// @nodoc
class _$SdkErrorCopyWithImpl<T,$Res>
    implements $SdkErrorCopyWith<T, $Res> {
  _$SdkErrorCopyWithImpl(this._self, this._then);

  final SdkError<T> _self;
  final $Res Function(SdkError<T>) _then;

/// Create a copy of TerminalState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = null,}) {
  return _then(SdkError<T>(
null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class DiscoveringReaders<T> implements TerminalState<T> {
  const DiscoveringReaders();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DiscoveringReaders<T>);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'TerminalState<$T>.discoveringReaders()';
}


}




/// @nodoc


class ReadersDiscovered<T> implements TerminalState<T> {
  const ReadersDiscovered(final  List<Reader> readers): _readers = readers;
  

 final  List<Reader> _readers;
 List<Reader> get readers {
  if (_readers is EqualUnmodifiableListView) return _readers;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_readers);
}


/// Create a copy of TerminalState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ReadersDiscoveredCopyWith<T, ReadersDiscovered<T>> get copyWith => _$ReadersDiscoveredCopyWithImpl<T, ReadersDiscovered<T>>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ReadersDiscovered<T>&&const DeepCollectionEquality().equals(other._readers, _readers));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_readers));

@override
String toString() {
  return 'TerminalState<$T>.readersDiscovered(readers: $readers)';
}


}

/// @nodoc
abstract mixin class $ReadersDiscoveredCopyWith<T,$Res> implements $TerminalStateCopyWith<T, $Res> {
  factory $ReadersDiscoveredCopyWith(ReadersDiscovered<T> value, $Res Function(ReadersDiscovered<T>) _then) = _$ReadersDiscoveredCopyWithImpl;
@useResult
$Res call({
 List<Reader> readers
});




}
/// @nodoc
class _$ReadersDiscoveredCopyWithImpl<T,$Res>
    implements $ReadersDiscoveredCopyWith<T, $Res> {
  _$ReadersDiscoveredCopyWithImpl(this._self, this._then);

  final ReadersDiscovered<T> _self;
  final $Res Function(ReadersDiscovered<T>) _then;

/// Create a copy of TerminalState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? readers = null,}) {
  return _then(ReadersDiscovered<T>(
null == readers ? _self._readers : readers // ignore: cast_nullable_to_non_nullable
as List<Reader>,
  ));
}


}

/// @nodoc


class NoReadersFound<T> implements TerminalState<T> {
  const NoReadersFound();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is NoReadersFound<T>);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'TerminalState<$T>.noReadersFound()';
}


}




/// @nodoc


class ReaderConnecting<T> implements TerminalState<T> {
  const ReaderConnecting();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ReaderConnecting<T>);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'TerminalState<$T>.readerConnecting()';
}


}




/// @nodoc


class ReaderConnected<T> implements TerminalState<T> {
  const ReaderConnected(this.readerLabel);
  

 final  String readerLabel;

/// Create a copy of TerminalState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ReaderConnectedCopyWith<T, ReaderConnected<T>> get copyWith => _$ReaderConnectedCopyWithImpl<T, ReaderConnected<T>>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ReaderConnected<T>&&(identical(other.readerLabel, readerLabel) || other.readerLabel == readerLabel));
}


@override
int get hashCode => Object.hash(runtimeType,readerLabel);

@override
String toString() {
  return 'TerminalState<$T>.readerConnected(readerLabel: $readerLabel)';
}


}

/// @nodoc
abstract mixin class $ReaderConnectedCopyWith<T,$Res> implements $TerminalStateCopyWith<T, $Res> {
  factory $ReaderConnectedCopyWith(ReaderConnected<T> value, $Res Function(ReaderConnected<T>) _then) = _$ReaderConnectedCopyWithImpl;
@useResult
$Res call({
 String readerLabel
});




}
/// @nodoc
class _$ReaderConnectedCopyWithImpl<T,$Res>
    implements $ReaderConnectedCopyWith<T, $Res> {
  _$ReaderConnectedCopyWithImpl(this._self, this._then);

  final ReaderConnected<T> _self;
  final $Res Function(ReaderConnected<T>) _then;

/// Create a copy of TerminalState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? readerLabel = null,}) {
  return _then(ReaderConnected<T>(
null == readerLabel ? _self.readerLabel : readerLabel // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class ReaderConnectionError<T> implements TerminalState<T> {
  const ReaderConnectionError(this.message);
  

 final  String message;

/// Create a copy of TerminalState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ReaderConnectionErrorCopyWith<T, ReaderConnectionError<T>> get copyWith => _$ReaderConnectionErrorCopyWithImpl<T, ReaderConnectionError<T>>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ReaderConnectionError<T>&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,message);

@override
String toString() {
  return 'TerminalState<$T>.readerConnectionError(message: $message)';
}


}

/// @nodoc
abstract mixin class $ReaderConnectionErrorCopyWith<T,$Res> implements $TerminalStateCopyWith<T, $Res> {
  factory $ReaderConnectionErrorCopyWith(ReaderConnectionError<T> value, $Res Function(ReaderConnectionError<T>) _then) = _$ReaderConnectionErrorCopyWithImpl;
@useResult
$Res call({
 String message
});




}
/// @nodoc
class _$ReaderConnectionErrorCopyWithImpl<T,$Res>
    implements $ReaderConnectionErrorCopyWith<T, $Res> {
  _$ReaderConnectionErrorCopyWithImpl(this._self, this._then);

  final ReaderConnectionError<T> _self;
  final $Res Function(ReaderConnectionError<T>) _then;

/// Create a copy of TerminalState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = null,}) {
  return _then(ReaderConnectionError<T>(
null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
