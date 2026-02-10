// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'checkout_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$CheckoutState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CheckoutState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'CheckoutState()';
}


}

/// @nodoc
class $CheckoutStateCopyWith<$Res>  {
$CheckoutStateCopyWith(CheckoutState _, $Res Function(CheckoutState) __);
}


/// Adds pattern-matching-related methods to [CheckoutState].
extension CheckoutStatePatterns on CheckoutState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( _Initial value)?  initial,TResult Function( CheckoutLoaded value)?  loaded,TResult Function( CheckoutProcessing value)?  processing,TResult Function( CheckoutSuccess value)?  success,TResult Function( CheckoutError value)?  error,TResult Function( SettingsLoading value)?  settingsLoading,TResult Function( SettingsLoaded value)?  settingsLoaded,TResult Function( SettingsError value)?  settingsError,TResult Function( DiscountApplying value)?  discountApplying,TResult Function( DiscountApplied value)?  discountApplied,TResult Function( DiscountError value)?  discountError,TResult Function( PasswordRequired value)?  passwordRequired,TResult Function( PasswordValid value)?  passwordValid,TResult Function( PasswordInvalid value)?  passwordInvalid,TResult Function( PaymentProcessing value)?  paymentProcessing,TResult Function( PaymentSuccess value)?  paymentSuccess,TResult Function( PaymentError value)?  paymentError,TResult Function( TerminalPaymentProcessing value)?  terminalPaymentProcessing,TResult Function( TerminalPaymentSuccess value)?  terminalPaymentSuccess,TResult Function( TerminalPaymentError value)?  terminalPaymentError,TResult Function( TerminalPaymentTimeout value)?  terminalPaymentTimeout,TResult Function( CardPaymentCreatingIntent value)?  cardPaymentCreatingIntent,TResult Function( CardPaymentCollecting value)?  cardPaymentCollecting,TResult Function( CardPaymentConfirming value)?  cardPaymentConfirming,TResult Function( CardPaymentSuccess value)?  cardPaymentSuccess,TResult Function( CardPaymentError value)?  cardPaymentError,TResult Function( CardPaymentCancelled value)?  cardPaymentCancelled,TResult Function( SplitPaymentCardSuccess value)?  splitPaymentCardSuccess,TResult Function( SplitPaymentComplete value)?  splitPaymentComplete,required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial(_that);case CheckoutLoaded() when loaded != null:
return loaded(_that);case CheckoutProcessing() when processing != null:
return processing(_that);case CheckoutSuccess() when success != null:
return success(_that);case CheckoutError() when error != null:
return error(_that);case SettingsLoading() when settingsLoading != null:
return settingsLoading(_that);case SettingsLoaded() when settingsLoaded != null:
return settingsLoaded(_that);case SettingsError() when settingsError != null:
return settingsError(_that);case DiscountApplying() when discountApplying != null:
return discountApplying(_that);case DiscountApplied() when discountApplied != null:
return discountApplied(_that);case DiscountError() when discountError != null:
return discountError(_that);case PasswordRequired() when passwordRequired != null:
return passwordRequired(_that);case PasswordValid() when passwordValid != null:
return passwordValid(_that);case PasswordInvalid() when passwordInvalid != null:
return passwordInvalid(_that);case PaymentProcessing() when paymentProcessing != null:
return paymentProcessing(_that);case PaymentSuccess() when paymentSuccess != null:
return paymentSuccess(_that);case PaymentError() when paymentError != null:
return paymentError(_that);case TerminalPaymentProcessing() when terminalPaymentProcessing != null:
return terminalPaymentProcessing(_that);case TerminalPaymentSuccess() when terminalPaymentSuccess != null:
return terminalPaymentSuccess(_that);case TerminalPaymentError() when terminalPaymentError != null:
return terminalPaymentError(_that);case TerminalPaymentTimeout() when terminalPaymentTimeout != null:
return terminalPaymentTimeout(_that);case CardPaymentCreatingIntent() when cardPaymentCreatingIntent != null:
return cardPaymentCreatingIntent(_that);case CardPaymentCollecting() when cardPaymentCollecting != null:
return cardPaymentCollecting(_that);case CardPaymentConfirming() when cardPaymentConfirming != null:
return cardPaymentConfirming(_that);case CardPaymentSuccess() when cardPaymentSuccess != null:
return cardPaymentSuccess(_that);case CardPaymentError() when cardPaymentError != null:
return cardPaymentError(_that);case CardPaymentCancelled() when cardPaymentCancelled != null:
return cardPaymentCancelled(_that);case SplitPaymentCardSuccess() when splitPaymentCardSuccess != null:
return splitPaymentCardSuccess(_that);case SplitPaymentComplete() when splitPaymentComplete != null:
return splitPaymentComplete(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( _Initial value)  initial,required TResult Function( CheckoutLoaded value)  loaded,required TResult Function( CheckoutProcessing value)  processing,required TResult Function( CheckoutSuccess value)  success,required TResult Function( CheckoutError value)  error,required TResult Function( SettingsLoading value)  settingsLoading,required TResult Function( SettingsLoaded value)  settingsLoaded,required TResult Function( SettingsError value)  settingsError,required TResult Function( DiscountApplying value)  discountApplying,required TResult Function( DiscountApplied value)  discountApplied,required TResult Function( DiscountError value)  discountError,required TResult Function( PasswordRequired value)  passwordRequired,required TResult Function( PasswordValid value)  passwordValid,required TResult Function( PasswordInvalid value)  passwordInvalid,required TResult Function( PaymentProcessing value)  paymentProcessing,required TResult Function( PaymentSuccess value)  paymentSuccess,required TResult Function( PaymentError value)  paymentError,required TResult Function( TerminalPaymentProcessing value)  terminalPaymentProcessing,required TResult Function( TerminalPaymentSuccess value)  terminalPaymentSuccess,required TResult Function( TerminalPaymentError value)  terminalPaymentError,required TResult Function( TerminalPaymentTimeout value)  terminalPaymentTimeout,required TResult Function( CardPaymentCreatingIntent value)  cardPaymentCreatingIntent,required TResult Function( CardPaymentCollecting value)  cardPaymentCollecting,required TResult Function( CardPaymentConfirming value)  cardPaymentConfirming,required TResult Function( CardPaymentSuccess value)  cardPaymentSuccess,required TResult Function( CardPaymentError value)  cardPaymentError,required TResult Function( CardPaymentCancelled value)  cardPaymentCancelled,required TResult Function( SplitPaymentCardSuccess value)  splitPaymentCardSuccess,required TResult Function( SplitPaymentComplete value)  splitPaymentComplete,}){
final _that = this;
switch (_that) {
case _Initial():
return initial(_that);case CheckoutLoaded():
return loaded(_that);case CheckoutProcessing():
return processing(_that);case CheckoutSuccess():
return success(_that);case CheckoutError():
return error(_that);case SettingsLoading():
return settingsLoading(_that);case SettingsLoaded():
return settingsLoaded(_that);case SettingsError():
return settingsError(_that);case DiscountApplying():
return discountApplying(_that);case DiscountApplied():
return discountApplied(_that);case DiscountError():
return discountError(_that);case PasswordRequired():
return passwordRequired(_that);case PasswordValid():
return passwordValid(_that);case PasswordInvalid():
return passwordInvalid(_that);case PaymentProcessing():
return paymentProcessing(_that);case PaymentSuccess():
return paymentSuccess(_that);case PaymentError():
return paymentError(_that);case TerminalPaymentProcessing():
return terminalPaymentProcessing(_that);case TerminalPaymentSuccess():
return terminalPaymentSuccess(_that);case TerminalPaymentError():
return terminalPaymentError(_that);case TerminalPaymentTimeout():
return terminalPaymentTimeout(_that);case CardPaymentCreatingIntent():
return cardPaymentCreatingIntent(_that);case CardPaymentCollecting():
return cardPaymentCollecting(_that);case CardPaymentConfirming():
return cardPaymentConfirming(_that);case CardPaymentSuccess():
return cardPaymentSuccess(_that);case CardPaymentError():
return cardPaymentError(_that);case CardPaymentCancelled():
return cardPaymentCancelled(_that);case SplitPaymentCardSuccess():
return splitPaymentCardSuccess(_that);case SplitPaymentComplete():
return splitPaymentComplete(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( _Initial value)?  initial,TResult? Function( CheckoutLoaded value)?  loaded,TResult? Function( CheckoutProcessing value)?  processing,TResult? Function( CheckoutSuccess value)?  success,TResult? Function( CheckoutError value)?  error,TResult? Function( SettingsLoading value)?  settingsLoading,TResult? Function( SettingsLoaded value)?  settingsLoaded,TResult? Function( SettingsError value)?  settingsError,TResult? Function( DiscountApplying value)?  discountApplying,TResult? Function( DiscountApplied value)?  discountApplied,TResult? Function( DiscountError value)?  discountError,TResult? Function( PasswordRequired value)?  passwordRequired,TResult? Function( PasswordValid value)?  passwordValid,TResult? Function( PasswordInvalid value)?  passwordInvalid,TResult? Function( PaymentProcessing value)?  paymentProcessing,TResult? Function( PaymentSuccess value)?  paymentSuccess,TResult? Function( PaymentError value)?  paymentError,TResult? Function( TerminalPaymentProcessing value)?  terminalPaymentProcessing,TResult? Function( TerminalPaymentSuccess value)?  terminalPaymentSuccess,TResult? Function( TerminalPaymentError value)?  terminalPaymentError,TResult? Function( TerminalPaymentTimeout value)?  terminalPaymentTimeout,TResult? Function( CardPaymentCreatingIntent value)?  cardPaymentCreatingIntent,TResult? Function( CardPaymentCollecting value)?  cardPaymentCollecting,TResult? Function( CardPaymentConfirming value)?  cardPaymentConfirming,TResult? Function( CardPaymentSuccess value)?  cardPaymentSuccess,TResult? Function( CardPaymentError value)?  cardPaymentError,TResult? Function( CardPaymentCancelled value)?  cardPaymentCancelled,TResult? Function( SplitPaymentCardSuccess value)?  splitPaymentCardSuccess,TResult? Function( SplitPaymentComplete value)?  splitPaymentComplete,}){
final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial(_that);case CheckoutLoaded() when loaded != null:
return loaded(_that);case CheckoutProcessing() when processing != null:
return processing(_that);case CheckoutSuccess() when success != null:
return success(_that);case CheckoutError() when error != null:
return error(_that);case SettingsLoading() when settingsLoading != null:
return settingsLoading(_that);case SettingsLoaded() when settingsLoaded != null:
return settingsLoaded(_that);case SettingsError() when settingsError != null:
return settingsError(_that);case DiscountApplying() when discountApplying != null:
return discountApplying(_that);case DiscountApplied() when discountApplied != null:
return discountApplied(_that);case DiscountError() when discountError != null:
return discountError(_that);case PasswordRequired() when passwordRequired != null:
return passwordRequired(_that);case PasswordValid() when passwordValid != null:
return passwordValid(_that);case PasswordInvalid() when passwordInvalid != null:
return passwordInvalid(_that);case PaymentProcessing() when paymentProcessing != null:
return paymentProcessing(_that);case PaymentSuccess() when paymentSuccess != null:
return paymentSuccess(_that);case PaymentError() when paymentError != null:
return paymentError(_that);case TerminalPaymentProcessing() when terminalPaymentProcessing != null:
return terminalPaymentProcessing(_that);case TerminalPaymentSuccess() when terminalPaymentSuccess != null:
return terminalPaymentSuccess(_that);case TerminalPaymentError() when terminalPaymentError != null:
return terminalPaymentError(_that);case TerminalPaymentTimeout() when terminalPaymentTimeout != null:
return terminalPaymentTimeout(_that);case CardPaymentCreatingIntent() when cardPaymentCreatingIntent != null:
return cardPaymentCreatingIntent(_that);case CardPaymentCollecting() when cardPaymentCollecting != null:
return cardPaymentCollecting(_that);case CardPaymentConfirming() when cardPaymentConfirming != null:
return cardPaymentConfirming(_that);case CardPaymentSuccess() when cardPaymentSuccess != null:
return cardPaymentSuccess(_that);case CardPaymentError() when cardPaymentError != null:
return cardPaymentError(_that);case CardPaymentCancelled() when cardPaymentCancelled != null:
return cardPaymentCancelled(_that);case SplitPaymentCardSuccess() when splitPaymentCardSuccess != null:
return splitPaymentCardSuccess(_that);case SplitPaymentComplete() when splitPaymentComplete != null:
return splitPaymentComplete(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  initial,TResult Function( CartData cartData)?  loaded,TResult Function()?  processing,TResult Function()?  success,TResult Function( String message)?  error,TResult Function()?  settingsLoading,TResult Function( DiscountSettingsSystem settings)?  settingsLoaded,TResult Function( ApiErrorModel error)?  settingsError,TResult Function()?  discountApplying,TResult Function( CartData cartData)?  discountApplied,TResult Function( ApiErrorModel error)?  discountError,TResult Function( DiscountSettingsSystem settings)?  passwordRequired,TResult Function()?  passwordValid,TResult Function()?  passwordInvalid,TResult Function()?  paymentProcessing,TResult Function( PaymentResponseData data)?  paymentSuccess,TResult Function( ApiErrorModel error)?  paymentError,TResult Function()?  terminalPaymentProcessing,TResult Function( ProcessPaymentResponse response)?  terminalPaymentSuccess,TResult Function( ProcessPaymentResponse response)?  terminalPaymentError,TResult Function( ProcessPaymentResponse response)?  terminalPaymentTimeout,TResult Function()?  cardPaymentCreatingIntent,TResult Function()?  cardPaymentCollecting,TResult Function()?  cardPaymentConfirming,TResult Function( PaymentResponseData data)?  cardPaymentSuccess,TResult Function( String message)?  cardPaymentError,TResult Function()?  cardPaymentCancelled,TResult Function( num cardAmount,  num cashAmount,  String paymentIntentId)?  splitPaymentCardSuccess,TResult Function( PaymentResponseData data)?  splitPaymentComplete,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial();case CheckoutLoaded() when loaded != null:
return loaded(_that.cartData);case CheckoutProcessing() when processing != null:
return processing();case CheckoutSuccess() when success != null:
return success();case CheckoutError() when error != null:
return error(_that.message);case SettingsLoading() when settingsLoading != null:
return settingsLoading();case SettingsLoaded() when settingsLoaded != null:
return settingsLoaded(_that.settings);case SettingsError() when settingsError != null:
return settingsError(_that.error);case DiscountApplying() when discountApplying != null:
return discountApplying();case DiscountApplied() when discountApplied != null:
return discountApplied(_that.cartData);case DiscountError() when discountError != null:
return discountError(_that.error);case PasswordRequired() when passwordRequired != null:
return passwordRequired(_that.settings);case PasswordValid() when passwordValid != null:
return passwordValid();case PasswordInvalid() when passwordInvalid != null:
return passwordInvalid();case PaymentProcessing() when paymentProcessing != null:
return paymentProcessing();case PaymentSuccess() when paymentSuccess != null:
return paymentSuccess(_that.data);case PaymentError() when paymentError != null:
return paymentError(_that.error);case TerminalPaymentProcessing() when terminalPaymentProcessing != null:
return terminalPaymentProcessing();case TerminalPaymentSuccess() when terminalPaymentSuccess != null:
return terminalPaymentSuccess(_that.response);case TerminalPaymentError() when terminalPaymentError != null:
return terminalPaymentError(_that.response);case TerminalPaymentTimeout() when terminalPaymentTimeout != null:
return terminalPaymentTimeout(_that.response);case CardPaymentCreatingIntent() when cardPaymentCreatingIntent != null:
return cardPaymentCreatingIntent();case CardPaymentCollecting() when cardPaymentCollecting != null:
return cardPaymentCollecting();case CardPaymentConfirming() when cardPaymentConfirming != null:
return cardPaymentConfirming();case CardPaymentSuccess() when cardPaymentSuccess != null:
return cardPaymentSuccess(_that.data);case CardPaymentError() when cardPaymentError != null:
return cardPaymentError(_that.message);case CardPaymentCancelled() when cardPaymentCancelled != null:
return cardPaymentCancelled();case SplitPaymentCardSuccess() when splitPaymentCardSuccess != null:
return splitPaymentCardSuccess(_that.cardAmount,_that.cashAmount,_that.paymentIntentId);case SplitPaymentComplete() when splitPaymentComplete != null:
return splitPaymentComplete(_that.data);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  initial,required TResult Function( CartData cartData)  loaded,required TResult Function()  processing,required TResult Function()  success,required TResult Function( String message)  error,required TResult Function()  settingsLoading,required TResult Function( DiscountSettingsSystem settings)  settingsLoaded,required TResult Function( ApiErrorModel error)  settingsError,required TResult Function()  discountApplying,required TResult Function( CartData cartData)  discountApplied,required TResult Function( ApiErrorModel error)  discountError,required TResult Function( DiscountSettingsSystem settings)  passwordRequired,required TResult Function()  passwordValid,required TResult Function()  passwordInvalid,required TResult Function()  paymentProcessing,required TResult Function( PaymentResponseData data)  paymentSuccess,required TResult Function( ApiErrorModel error)  paymentError,required TResult Function()  terminalPaymentProcessing,required TResult Function( ProcessPaymentResponse response)  terminalPaymentSuccess,required TResult Function( ProcessPaymentResponse response)  terminalPaymentError,required TResult Function( ProcessPaymentResponse response)  terminalPaymentTimeout,required TResult Function()  cardPaymentCreatingIntent,required TResult Function()  cardPaymentCollecting,required TResult Function()  cardPaymentConfirming,required TResult Function( PaymentResponseData data)  cardPaymentSuccess,required TResult Function( String message)  cardPaymentError,required TResult Function()  cardPaymentCancelled,required TResult Function( num cardAmount,  num cashAmount,  String paymentIntentId)  splitPaymentCardSuccess,required TResult Function( PaymentResponseData data)  splitPaymentComplete,}) {final _that = this;
switch (_that) {
case _Initial():
return initial();case CheckoutLoaded():
return loaded(_that.cartData);case CheckoutProcessing():
return processing();case CheckoutSuccess():
return success();case CheckoutError():
return error(_that.message);case SettingsLoading():
return settingsLoading();case SettingsLoaded():
return settingsLoaded(_that.settings);case SettingsError():
return settingsError(_that.error);case DiscountApplying():
return discountApplying();case DiscountApplied():
return discountApplied(_that.cartData);case DiscountError():
return discountError(_that.error);case PasswordRequired():
return passwordRequired(_that.settings);case PasswordValid():
return passwordValid();case PasswordInvalid():
return passwordInvalid();case PaymentProcessing():
return paymentProcessing();case PaymentSuccess():
return paymentSuccess(_that.data);case PaymentError():
return paymentError(_that.error);case TerminalPaymentProcessing():
return terminalPaymentProcessing();case TerminalPaymentSuccess():
return terminalPaymentSuccess(_that.response);case TerminalPaymentError():
return terminalPaymentError(_that.response);case TerminalPaymentTimeout():
return terminalPaymentTimeout(_that.response);case CardPaymentCreatingIntent():
return cardPaymentCreatingIntent();case CardPaymentCollecting():
return cardPaymentCollecting();case CardPaymentConfirming():
return cardPaymentConfirming();case CardPaymentSuccess():
return cardPaymentSuccess(_that.data);case CardPaymentError():
return cardPaymentError(_that.message);case CardPaymentCancelled():
return cardPaymentCancelled();case SplitPaymentCardSuccess():
return splitPaymentCardSuccess(_that.cardAmount,_that.cashAmount,_that.paymentIntentId);case SplitPaymentComplete():
return splitPaymentComplete(_that.data);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  initial,TResult? Function( CartData cartData)?  loaded,TResult? Function()?  processing,TResult? Function()?  success,TResult? Function( String message)?  error,TResult? Function()?  settingsLoading,TResult? Function( DiscountSettingsSystem settings)?  settingsLoaded,TResult? Function( ApiErrorModel error)?  settingsError,TResult? Function()?  discountApplying,TResult? Function( CartData cartData)?  discountApplied,TResult? Function( ApiErrorModel error)?  discountError,TResult? Function( DiscountSettingsSystem settings)?  passwordRequired,TResult? Function()?  passwordValid,TResult? Function()?  passwordInvalid,TResult? Function()?  paymentProcessing,TResult? Function( PaymentResponseData data)?  paymentSuccess,TResult? Function( ApiErrorModel error)?  paymentError,TResult? Function()?  terminalPaymentProcessing,TResult? Function( ProcessPaymentResponse response)?  terminalPaymentSuccess,TResult? Function( ProcessPaymentResponse response)?  terminalPaymentError,TResult? Function( ProcessPaymentResponse response)?  terminalPaymentTimeout,TResult? Function()?  cardPaymentCreatingIntent,TResult? Function()?  cardPaymentCollecting,TResult? Function()?  cardPaymentConfirming,TResult? Function( PaymentResponseData data)?  cardPaymentSuccess,TResult? Function( String message)?  cardPaymentError,TResult? Function()?  cardPaymentCancelled,TResult? Function( num cardAmount,  num cashAmount,  String paymentIntentId)?  splitPaymentCardSuccess,TResult? Function( PaymentResponseData data)?  splitPaymentComplete,}) {final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial();case CheckoutLoaded() when loaded != null:
return loaded(_that.cartData);case CheckoutProcessing() when processing != null:
return processing();case CheckoutSuccess() when success != null:
return success();case CheckoutError() when error != null:
return error(_that.message);case SettingsLoading() when settingsLoading != null:
return settingsLoading();case SettingsLoaded() when settingsLoaded != null:
return settingsLoaded(_that.settings);case SettingsError() when settingsError != null:
return settingsError(_that.error);case DiscountApplying() when discountApplying != null:
return discountApplying();case DiscountApplied() when discountApplied != null:
return discountApplied(_that.cartData);case DiscountError() when discountError != null:
return discountError(_that.error);case PasswordRequired() when passwordRequired != null:
return passwordRequired(_that.settings);case PasswordValid() when passwordValid != null:
return passwordValid();case PasswordInvalid() when passwordInvalid != null:
return passwordInvalid();case PaymentProcessing() when paymentProcessing != null:
return paymentProcessing();case PaymentSuccess() when paymentSuccess != null:
return paymentSuccess(_that.data);case PaymentError() when paymentError != null:
return paymentError(_that.error);case TerminalPaymentProcessing() when terminalPaymentProcessing != null:
return terminalPaymentProcessing();case TerminalPaymentSuccess() when terminalPaymentSuccess != null:
return terminalPaymentSuccess(_that.response);case TerminalPaymentError() when terminalPaymentError != null:
return terminalPaymentError(_that.response);case TerminalPaymentTimeout() when terminalPaymentTimeout != null:
return terminalPaymentTimeout(_that.response);case CardPaymentCreatingIntent() when cardPaymentCreatingIntent != null:
return cardPaymentCreatingIntent();case CardPaymentCollecting() when cardPaymentCollecting != null:
return cardPaymentCollecting();case CardPaymentConfirming() when cardPaymentConfirming != null:
return cardPaymentConfirming();case CardPaymentSuccess() when cardPaymentSuccess != null:
return cardPaymentSuccess(_that.data);case CardPaymentError() when cardPaymentError != null:
return cardPaymentError(_that.message);case CardPaymentCancelled() when cardPaymentCancelled != null:
return cardPaymentCancelled();case SplitPaymentCardSuccess() when splitPaymentCardSuccess != null:
return splitPaymentCardSuccess(_that.cardAmount,_that.cashAmount,_that.paymentIntentId);case SplitPaymentComplete() when splitPaymentComplete != null:
return splitPaymentComplete(_that.data);case _:
  return null;

}
}

}

/// @nodoc


class _Initial implements CheckoutState {
  const _Initial();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Initial);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'CheckoutState.initial()';
}


}




/// @nodoc


class CheckoutLoaded implements CheckoutState {
  const CheckoutLoaded(this.cartData);
  

 final  CartData cartData;

/// Create a copy of CheckoutState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CheckoutLoadedCopyWith<CheckoutLoaded> get copyWith => _$CheckoutLoadedCopyWithImpl<CheckoutLoaded>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CheckoutLoaded&&(identical(other.cartData, cartData) || other.cartData == cartData));
}


@override
int get hashCode => Object.hash(runtimeType,cartData);

@override
String toString() {
  return 'CheckoutState.loaded(cartData: $cartData)';
}


}

/// @nodoc
abstract mixin class $CheckoutLoadedCopyWith<$Res> implements $CheckoutStateCopyWith<$Res> {
  factory $CheckoutLoadedCopyWith(CheckoutLoaded value, $Res Function(CheckoutLoaded) _then) = _$CheckoutLoadedCopyWithImpl;
@useResult
$Res call({
 CartData cartData
});




}
/// @nodoc
class _$CheckoutLoadedCopyWithImpl<$Res>
    implements $CheckoutLoadedCopyWith<$Res> {
  _$CheckoutLoadedCopyWithImpl(this._self, this._then);

  final CheckoutLoaded _self;
  final $Res Function(CheckoutLoaded) _then;

/// Create a copy of CheckoutState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? cartData = null,}) {
  return _then(CheckoutLoaded(
null == cartData ? _self.cartData : cartData // ignore: cast_nullable_to_non_nullable
as CartData,
  ));
}


}

/// @nodoc


class CheckoutProcessing implements CheckoutState {
  const CheckoutProcessing();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CheckoutProcessing);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'CheckoutState.processing()';
}


}




/// @nodoc


class CheckoutSuccess implements CheckoutState {
  const CheckoutSuccess();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CheckoutSuccess);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'CheckoutState.success()';
}


}




/// @nodoc


class CheckoutError implements CheckoutState {
  const CheckoutError(this.message);
  

 final  String message;

/// Create a copy of CheckoutState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CheckoutErrorCopyWith<CheckoutError> get copyWith => _$CheckoutErrorCopyWithImpl<CheckoutError>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CheckoutError&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,message);

@override
String toString() {
  return 'CheckoutState.error(message: $message)';
}


}

/// @nodoc
abstract mixin class $CheckoutErrorCopyWith<$Res> implements $CheckoutStateCopyWith<$Res> {
  factory $CheckoutErrorCopyWith(CheckoutError value, $Res Function(CheckoutError) _then) = _$CheckoutErrorCopyWithImpl;
@useResult
$Res call({
 String message
});




}
/// @nodoc
class _$CheckoutErrorCopyWithImpl<$Res>
    implements $CheckoutErrorCopyWith<$Res> {
  _$CheckoutErrorCopyWithImpl(this._self, this._then);

  final CheckoutError _self;
  final $Res Function(CheckoutError) _then;

/// Create a copy of CheckoutState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = null,}) {
  return _then(CheckoutError(
null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class SettingsLoading implements CheckoutState {
  const SettingsLoading();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SettingsLoading);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'CheckoutState.settingsLoading()';
}


}




/// @nodoc


class SettingsLoaded implements CheckoutState {
  const SettingsLoaded(this.settings);
  

 final  DiscountSettingsSystem settings;

/// Create a copy of CheckoutState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SettingsLoadedCopyWith<SettingsLoaded> get copyWith => _$SettingsLoadedCopyWithImpl<SettingsLoaded>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SettingsLoaded&&(identical(other.settings, settings) || other.settings == settings));
}


@override
int get hashCode => Object.hash(runtimeType,settings);

@override
String toString() {
  return 'CheckoutState.settingsLoaded(settings: $settings)';
}


}

/// @nodoc
abstract mixin class $SettingsLoadedCopyWith<$Res> implements $CheckoutStateCopyWith<$Res> {
  factory $SettingsLoadedCopyWith(SettingsLoaded value, $Res Function(SettingsLoaded) _then) = _$SettingsLoadedCopyWithImpl;
@useResult
$Res call({
 DiscountSettingsSystem settings
});




}
/// @nodoc
class _$SettingsLoadedCopyWithImpl<$Res>
    implements $SettingsLoadedCopyWith<$Res> {
  _$SettingsLoadedCopyWithImpl(this._self, this._then);

  final SettingsLoaded _self;
  final $Res Function(SettingsLoaded) _then;

/// Create a copy of CheckoutState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? settings = null,}) {
  return _then(SettingsLoaded(
null == settings ? _self.settings : settings // ignore: cast_nullable_to_non_nullable
as DiscountSettingsSystem,
  ));
}


}

/// @nodoc


class SettingsError implements CheckoutState {
  const SettingsError(this.error);
  

 final  ApiErrorModel error;

/// Create a copy of CheckoutState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SettingsErrorCopyWith<SettingsError> get copyWith => _$SettingsErrorCopyWithImpl<SettingsError>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SettingsError&&(identical(other.error, error) || other.error == error));
}


@override
int get hashCode => Object.hash(runtimeType,error);

@override
String toString() {
  return 'CheckoutState.settingsError(error: $error)';
}


}

/// @nodoc
abstract mixin class $SettingsErrorCopyWith<$Res> implements $CheckoutStateCopyWith<$Res> {
  factory $SettingsErrorCopyWith(SettingsError value, $Res Function(SettingsError) _then) = _$SettingsErrorCopyWithImpl;
@useResult
$Res call({
 ApiErrorModel error
});




}
/// @nodoc
class _$SettingsErrorCopyWithImpl<$Res>
    implements $SettingsErrorCopyWith<$Res> {
  _$SettingsErrorCopyWithImpl(this._self, this._then);

  final SettingsError _self;
  final $Res Function(SettingsError) _then;

/// Create a copy of CheckoutState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? error = null,}) {
  return _then(SettingsError(
null == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as ApiErrorModel,
  ));
}


}

/// @nodoc


class DiscountApplying implements CheckoutState {
  const DiscountApplying();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DiscountApplying);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'CheckoutState.discountApplying()';
}


}




/// @nodoc


class DiscountApplied implements CheckoutState {
  const DiscountApplied(this.cartData);
  

 final  CartData cartData;

/// Create a copy of CheckoutState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DiscountAppliedCopyWith<DiscountApplied> get copyWith => _$DiscountAppliedCopyWithImpl<DiscountApplied>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DiscountApplied&&(identical(other.cartData, cartData) || other.cartData == cartData));
}


@override
int get hashCode => Object.hash(runtimeType,cartData);

@override
String toString() {
  return 'CheckoutState.discountApplied(cartData: $cartData)';
}


}

/// @nodoc
abstract mixin class $DiscountAppliedCopyWith<$Res> implements $CheckoutStateCopyWith<$Res> {
  factory $DiscountAppliedCopyWith(DiscountApplied value, $Res Function(DiscountApplied) _then) = _$DiscountAppliedCopyWithImpl;
@useResult
$Res call({
 CartData cartData
});




}
/// @nodoc
class _$DiscountAppliedCopyWithImpl<$Res>
    implements $DiscountAppliedCopyWith<$Res> {
  _$DiscountAppliedCopyWithImpl(this._self, this._then);

  final DiscountApplied _self;
  final $Res Function(DiscountApplied) _then;

/// Create a copy of CheckoutState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? cartData = null,}) {
  return _then(DiscountApplied(
null == cartData ? _self.cartData : cartData // ignore: cast_nullable_to_non_nullable
as CartData,
  ));
}


}

/// @nodoc


class DiscountError implements CheckoutState {
  const DiscountError(this.error);
  

 final  ApiErrorModel error;

/// Create a copy of CheckoutState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DiscountErrorCopyWith<DiscountError> get copyWith => _$DiscountErrorCopyWithImpl<DiscountError>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DiscountError&&(identical(other.error, error) || other.error == error));
}


@override
int get hashCode => Object.hash(runtimeType,error);

@override
String toString() {
  return 'CheckoutState.discountError(error: $error)';
}


}

/// @nodoc
abstract mixin class $DiscountErrorCopyWith<$Res> implements $CheckoutStateCopyWith<$Res> {
  factory $DiscountErrorCopyWith(DiscountError value, $Res Function(DiscountError) _then) = _$DiscountErrorCopyWithImpl;
@useResult
$Res call({
 ApiErrorModel error
});




}
/// @nodoc
class _$DiscountErrorCopyWithImpl<$Res>
    implements $DiscountErrorCopyWith<$Res> {
  _$DiscountErrorCopyWithImpl(this._self, this._then);

  final DiscountError _self;
  final $Res Function(DiscountError) _then;

/// Create a copy of CheckoutState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? error = null,}) {
  return _then(DiscountError(
null == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as ApiErrorModel,
  ));
}


}

/// @nodoc


class PasswordRequired implements CheckoutState {
  const PasswordRequired(this.settings);
  

 final  DiscountSettingsSystem settings;

/// Create a copy of CheckoutState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PasswordRequiredCopyWith<PasswordRequired> get copyWith => _$PasswordRequiredCopyWithImpl<PasswordRequired>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PasswordRequired&&(identical(other.settings, settings) || other.settings == settings));
}


@override
int get hashCode => Object.hash(runtimeType,settings);

@override
String toString() {
  return 'CheckoutState.passwordRequired(settings: $settings)';
}


}

/// @nodoc
abstract mixin class $PasswordRequiredCopyWith<$Res> implements $CheckoutStateCopyWith<$Res> {
  factory $PasswordRequiredCopyWith(PasswordRequired value, $Res Function(PasswordRequired) _then) = _$PasswordRequiredCopyWithImpl;
@useResult
$Res call({
 DiscountSettingsSystem settings
});




}
/// @nodoc
class _$PasswordRequiredCopyWithImpl<$Res>
    implements $PasswordRequiredCopyWith<$Res> {
  _$PasswordRequiredCopyWithImpl(this._self, this._then);

  final PasswordRequired _self;
  final $Res Function(PasswordRequired) _then;

/// Create a copy of CheckoutState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? settings = null,}) {
  return _then(PasswordRequired(
null == settings ? _self.settings : settings // ignore: cast_nullable_to_non_nullable
as DiscountSettingsSystem,
  ));
}


}

/// @nodoc


class PasswordValid implements CheckoutState {
  const PasswordValid();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PasswordValid);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'CheckoutState.passwordValid()';
}


}




/// @nodoc


class PasswordInvalid implements CheckoutState {
  const PasswordInvalid();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PasswordInvalid);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'CheckoutState.passwordInvalid()';
}


}




/// @nodoc


class PaymentProcessing implements CheckoutState {
  const PaymentProcessing();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PaymentProcessing);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'CheckoutState.paymentProcessing()';
}


}




/// @nodoc


class PaymentSuccess implements CheckoutState {
  const PaymentSuccess(this.data);
  

 final  PaymentResponseData data;

/// Create a copy of CheckoutState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PaymentSuccessCopyWith<PaymentSuccess> get copyWith => _$PaymentSuccessCopyWithImpl<PaymentSuccess>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PaymentSuccess&&(identical(other.data, data) || other.data == data));
}


@override
int get hashCode => Object.hash(runtimeType,data);

@override
String toString() {
  return 'CheckoutState.paymentSuccess(data: $data)';
}


}

/// @nodoc
abstract mixin class $PaymentSuccessCopyWith<$Res> implements $CheckoutStateCopyWith<$Res> {
  factory $PaymentSuccessCopyWith(PaymentSuccess value, $Res Function(PaymentSuccess) _then) = _$PaymentSuccessCopyWithImpl;
@useResult
$Res call({
 PaymentResponseData data
});




}
/// @nodoc
class _$PaymentSuccessCopyWithImpl<$Res>
    implements $PaymentSuccessCopyWith<$Res> {
  _$PaymentSuccessCopyWithImpl(this._self, this._then);

  final PaymentSuccess _self;
  final $Res Function(PaymentSuccess) _then;

/// Create a copy of CheckoutState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? data = null,}) {
  return _then(PaymentSuccess(
null == data ? _self.data : data // ignore: cast_nullable_to_non_nullable
as PaymentResponseData,
  ));
}


}

/// @nodoc


class PaymentError implements CheckoutState {
  const PaymentError(this.error);
  

 final  ApiErrorModel error;

/// Create a copy of CheckoutState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PaymentErrorCopyWith<PaymentError> get copyWith => _$PaymentErrorCopyWithImpl<PaymentError>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PaymentError&&(identical(other.error, error) || other.error == error));
}


@override
int get hashCode => Object.hash(runtimeType,error);

@override
String toString() {
  return 'CheckoutState.paymentError(error: $error)';
}


}

/// @nodoc
abstract mixin class $PaymentErrorCopyWith<$Res> implements $CheckoutStateCopyWith<$Res> {
  factory $PaymentErrorCopyWith(PaymentError value, $Res Function(PaymentError) _then) = _$PaymentErrorCopyWithImpl;
@useResult
$Res call({
 ApiErrorModel error
});




}
/// @nodoc
class _$PaymentErrorCopyWithImpl<$Res>
    implements $PaymentErrorCopyWith<$Res> {
  _$PaymentErrorCopyWithImpl(this._self, this._then);

  final PaymentError _self;
  final $Res Function(PaymentError) _then;

/// Create a copy of CheckoutState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? error = null,}) {
  return _then(PaymentError(
null == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as ApiErrorModel,
  ));
}


}

/// @nodoc


class TerminalPaymentProcessing implements CheckoutState {
  const TerminalPaymentProcessing();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TerminalPaymentProcessing);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'CheckoutState.terminalPaymentProcessing()';
}


}




/// @nodoc


class TerminalPaymentSuccess implements CheckoutState {
  const TerminalPaymentSuccess(this.response);
  

 final  ProcessPaymentResponse response;

/// Create a copy of CheckoutState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TerminalPaymentSuccessCopyWith<TerminalPaymentSuccess> get copyWith => _$TerminalPaymentSuccessCopyWithImpl<TerminalPaymentSuccess>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TerminalPaymentSuccess&&(identical(other.response, response) || other.response == response));
}


@override
int get hashCode => Object.hash(runtimeType,response);

@override
String toString() {
  return 'CheckoutState.terminalPaymentSuccess(response: $response)';
}


}

/// @nodoc
abstract mixin class $TerminalPaymentSuccessCopyWith<$Res> implements $CheckoutStateCopyWith<$Res> {
  factory $TerminalPaymentSuccessCopyWith(TerminalPaymentSuccess value, $Res Function(TerminalPaymentSuccess) _then) = _$TerminalPaymentSuccessCopyWithImpl;
@useResult
$Res call({
 ProcessPaymentResponse response
});




}
/// @nodoc
class _$TerminalPaymentSuccessCopyWithImpl<$Res>
    implements $TerminalPaymentSuccessCopyWith<$Res> {
  _$TerminalPaymentSuccessCopyWithImpl(this._self, this._then);

  final TerminalPaymentSuccess _self;
  final $Res Function(TerminalPaymentSuccess) _then;

/// Create a copy of CheckoutState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? response = null,}) {
  return _then(TerminalPaymentSuccess(
null == response ? _self.response : response // ignore: cast_nullable_to_non_nullable
as ProcessPaymentResponse,
  ));
}


}

/// @nodoc


class TerminalPaymentError implements CheckoutState {
  const TerminalPaymentError(this.response);
  

 final  ProcessPaymentResponse response;

/// Create a copy of CheckoutState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TerminalPaymentErrorCopyWith<TerminalPaymentError> get copyWith => _$TerminalPaymentErrorCopyWithImpl<TerminalPaymentError>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TerminalPaymentError&&(identical(other.response, response) || other.response == response));
}


@override
int get hashCode => Object.hash(runtimeType,response);

@override
String toString() {
  return 'CheckoutState.terminalPaymentError(response: $response)';
}


}

/// @nodoc
abstract mixin class $TerminalPaymentErrorCopyWith<$Res> implements $CheckoutStateCopyWith<$Res> {
  factory $TerminalPaymentErrorCopyWith(TerminalPaymentError value, $Res Function(TerminalPaymentError) _then) = _$TerminalPaymentErrorCopyWithImpl;
@useResult
$Res call({
 ProcessPaymentResponse response
});




}
/// @nodoc
class _$TerminalPaymentErrorCopyWithImpl<$Res>
    implements $TerminalPaymentErrorCopyWith<$Res> {
  _$TerminalPaymentErrorCopyWithImpl(this._self, this._then);

  final TerminalPaymentError _self;
  final $Res Function(TerminalPaymentError) _then;

/// Create a copy of CheckoutState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? response = null,}) {
  return _then(TerminalPaymentError(
null == response ? _self.response : response // ignore: cast_nullable_to_non_nullable
as ProcessPaymentResponse,
  ));
}


}

/// @nodoc


class TerminalPaymentTimeout implements CheckoutState {
  const TerminalPaymentTimeout(this.response);
  

 final  ProcessPaymentResponse response;

/// Create a copy of CheckoutState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TerminalPaymentTimeoutCopyWith<TerminalPaymentTimeout> get copyWith => _$TerminalPaymentTimeoutCopyWithImpl<TerminalPaymentTimeout>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TerminalPaymentTimeout&&(identical(other.response, response) || other.response == response));
}


@override
int get hashCode => Object.hash(runtimeType,response);

@override
String toString() {
  return 'CheckoutState.terminalPaymentTimeout(response: $response)';
}


}

/// @nodoc
abstract mixin class $TerminalPaymentTimeoutCopyWith<$Res> implements $CheckoutStateCopyWith<$Res> {
  factory $TerminalPaymentTimeoutCopyWith(TerminalPaymentTimeout value, $Res Function(TerminalPaymentTimeout) _then) = _$TerminalPaymentTimeoutCopyWithImpl;
@useResult
$Res call({
 ProcessPaymentResponse response
});




}
/// @nodoc
class _$TerminalPaymentTimeoutCopyWithImpl<$Res>
    implements $TerminalPaymentTimeoutCopyWith<$Res> {
  _$TerminalPaymentTimeoutCopyWithImpl(this._self, this._then);

  final TerminalPaymentTimeout _self;
  final $Res Function(TerminalPaymentTimeout) _then;

/// Create a copy of CheckoutState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? response = null,}) {
  return _then(TerminalPaymentTimeout(
null == response ? _self.response : response // ignore: cast_nullable_to_non_nullable
as ProcessPaymentResponse,
  ));
}


}

/// @nodoc


class CardPaymentCreatingIntent implements CheckoutState {
  const CardPaymentCreatingIntent();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CardPaymentCreatingIntent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'CheckoutState.cardPaymentCreatingIntent()';
}


}




/// @nodoc


class CardPaymentCollecting implements CheckoutState {
  const CardPaymentCollecting();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CardPaymentCollecting);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'CheckoutState.cardPaymentCollecting()';
}


}




/// @nodoc


class CardPaymentConfirming implements CheckoutState {
  const CardPaymentConfirming();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CardPaymentConfirming);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'CheckoutState.cardPaymentConfirming()';
}


}




/// @nodoc


class CardPaymentSuccess implements CheckoutState {
  const CardPaymentSuccess(this.data);
  

 final  PaymentResponseData data;

/// Create a copy of CheckoutState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CardPaymentSuccessCopyWith<CardPaymentSuccess> get copyWith => _$CardPaymentSuccessCopyWithImpl<CardPaymentSuccess>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CardPaymentSuccess&&(identical(other.data, data) || other.data == data));
}


@override
int get hashCode => Object.hash(runtimeType,data);

@override
String toString() {
  return 'CheckoutState.cardPaymentSuccess(data: $data)';
}


}

/// @nodoc
abstract mixin class $CardPaymentSuccessCopyWith<$Res> implements $CheckoutStateCopyWith<$Res> {
  factory $CardPaymentSuccessCopyWith(CardPaymentSuccess value, $Res Function(CardPaymentSuccess) _then) = _$CardPaymentSuccessCopyWithImpl;
@useResult
$Res call({
 PaymentResponseData data
});




}
/// @nodoc
class _$CardPaymentSuccessCopyWithImpl<$Res>
    implements $CardPaymentSuccessCopyWith<$Res> {
  _$CardPaymentSuccessCopyWithImpl(this._self, this._then);

  final CardPaymentSuccess _self;
  final $Res Function(CardPaymentSuccess) _then;

/// Create a copy of CheckoutState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? data = null,}) {
  return _then(CardPaymentSuccess(
null == data ? _self.data : data // ignore: cast_nullable_to_non_nullable
as PaymentResponseData,
  ));
}


}

/// @nodoc


class CardPaymentError implements CheckoutState {
  const CardPaymentError(this.message);
  

 final  String message;

/// Create a copy of CheckoutState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CardPaymentErrorCopyWith<CardPaymentError> get copyWith => _$CardPaymentErrorCopyWithImpl<CardPaymentError>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CardPaymentError&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,message);

@override
String toString() {
  return 'CheckoutState.cardPaymentError(message: $message)';
}


}

/// @nodoc
abstract mixin class $CardPaymentErrorCopyWith<$Res> implements $CheckoutStateCopyWith<$Res> {
  factory $CardPaymentErrorCopyWith(CardPaymentError value, $Res Function(CardPaymentError) _then) = _$CardPaymentErrorCopyWithImpl;
@useResult
$Res call({
 String message
});




}
/// @nodoc
class _$CardPaymentErrorCopyWithImpl<$Res>
    implements $CardPaymentErrorCopyWith<$Res> {
  _$CardPaymentErrorCopyWithImpl(this._self, this._then);

  final CardPaymentError _self;
  final $Res Function(CardPaymentError) _then;

/// Create a copy of CheckoutState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = null,}) {
  return _then(CardPaymentError(
null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class CardPaymentCancelled implements CheckoutState {
  const CardPaymentCancelled();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CardPaymentCancelled);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'CheckoutState.cardPaymentCancelled()';
}


}




/// @nodoc


class SplitPaymentCardSuccess implements CheckoutState {
  const SplitPaymentCardSuccess({required this.cardAmount, required this.cashAmount, required this.paymentIntentId});
  

 final  num cardAmount;
 final  num cashAmount;
 final  String paymentIntentId;

/// Create a copy of CheckoutState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SplitPaymentCardSuccessCopyWith<SplitPaymentCardSuccess> get copyWith => _$SplitPaymentCardSuccessCopyWithImpl<SplitPaymentCardSuccess>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SplitPaymentCardSuccess&&(identical(other.cardAmount, cardAmount) || other.cardAmount == cardAmount)&&(identical(other.cashAmount, cashAmount) || other.cashAmount == cashAmount)&&(identical(other.paymentIntentId, paymentIntentId) || other.paymentIntentId == paymentIntentId));
}


@override
int get hashCode => Object.hash(runtimeType,cardAmount,cashAmount,paymentIntentId);

@override
String toString() {
  return 'CheckoutState.splitPaymentCardSuccess(cardAmount: $cardAmount, cashAmount: $cashAmount, paymentIntentId: $paymentIntentId)';
}


}

/// @nodoc
abstract mixin class $SplitPaymentCardSuccessCopyWith<$Res> implements $CheckoutStateCopyWith<$Res> {
  factory $SplitPaymentCardSuccessCopyWith(SplitPaymentCardSuccess value, $Res Function(SplitPaymentCardSuccess) _then) = _$SplitPaymentCardSuccessCopyWithImpl;
@useResult
$Res call({
 num cardAmount, num cashAmount, String paymentIntentId
});




}
/// @nodoc
class _$SplitPaymentCardSuccessCopyWithImpl<$Res>
    implements $SplitPaymentCardSuccessCopyWith<$Res> {
  _$SplitPaymentCardSuccessCopyWithImpl(this._self, this._then);

  final SplitPaymentCardSuccess _self;
  final $Res Function(SplitPaymentCardSuccess) _then;

/// Create a copy of CheckoutState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? cardAmount = null,Object? cashAmount = null,Object? paymentIntentId = null,}) {
  return _then(SplitPaymentCardSuccess(
cardAmount: null == cardAmount ? _self.cardAmount : cardAmount // ignore: cast_nullable_to_non_nullable
as num,cashAmount: null == cashAmount ? _self.cashAmount : cashAmount // ignore: cast_nullable_to_non_nullable
as num,paymentIntentId: null == paymentIntentId ? _self.paymentIntentId : paymentIntentId // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class SplitPaymentComplete implements CheckoutState {
  const SplitPaymentComplete(this.data);
  

 final  PaymentResponseData data;

/// Create a copy of CheckoutState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SplitPaymentCompleteCopyWith<SplitPaymentComplete> get copyWith => _$SplitPaymentCompleteCopyWithImpl<SplitPaymentComplete>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SplitPaymentComplete&&(identical(other.data, data) || other.data == data));
}


@override
int get hashCode => Object.hash(runtimeType,data);

@override
String toString() {
  return 'CheckoutState.splitPaymentComplete(data: $data)';
}


}

/// @nodoc
abstract mixin class $SplitPaymentCompleteCopyWith<$Res> implements $CheckoutStateCopyWith<$Res> {
  factory $SplitPaymentCompleteCopyWith(SplitPaymentComplete value, $Res Function(SplitPaymentComplete) _then) = _$SplitPaymentCompleteCopyWithImpl;
@useResult
$Res call({
 PaymentResponseData data
});




}
/// @nodoc
class _$SplitPaymentCompleteCopyWithImpl<$Res>
    implements $SplitPaymentCompleteCopyWith<$Res> {
  _$SplitPaymentCompleteCopyWithImpl(this._self, this._then);

  final SplitPaymentComplete _self;
  final $Res Function(SplitPaymentComplete) _then;

/// Create a copy of CheckoutState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? data = null,}) {
  return _then(SplitPaymentComplete(
null == data ? _self.data : data // ignore: cast_nullable_to_non_nullable
as PaymentResponseData,
  ));
}


}

// dart format on
