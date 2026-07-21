// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'daily_check.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$DailyCheck {

 String get petId; DateTime get date; List<QuickCheckType> get completed;
/// Create a copy of DailyCheck
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DailyCheckCopyWith<DailyCheck> get copyWith => _$DailyCheckCopyWithImpl<DailyCheck>(this as DailyCheck, _$identity);

  /// Serializes this DailyCheck to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DailyCheck&&(identical(other.petId, petId) || other.petId == petId)&&(identical(other.date, date) || other.date == date)&&const DeepCollectionEquality().equals(other.completed, completed));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,petId,date,const DeepCollectionEquality().hash(completed));

@override
String toString() {
  return 'DailyCheck(petId: $petId, date: $date, completed: $completed)';
}


}

/// @nodoc
abstract mixin class $DailyCheckCopyWith<$Res>  {
  factory $DailyCheckCopyWith(DailyCheck value, $Res Function(DailyCheck) _then) = _$DailyCheckCopyWithImpl;
@useResult
$Res call({
 String petId, DateTime date, List<QuickCheckType> completed
});




}
/// @nodoc
class _$DailyCheckCopyWithImpl<$Res>
    implements $DailyCheckCopyWith<$Res> {
  _$DailyCheckCopyWithImpl(this._self, this._then);

  final DailyCheck _self;
  final $Res Function(DailyCheck) _then;

/// Create a copy of DailyCheck
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? petId = null,Object? date = null,Object? completed = null,}) {
  return _then(_self.copyWith(
petId: null == petId ? _self.petId : petId // ignore: cast_nullable_to_non_nullable
as String,date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as DateTime,completed: null == completed ? _self.completed : completed // ignore: cast_nullable_to_non_nullable
as List<QuickCheckType>,
  ));
}

}


/// Adds pattern-matching-related methods to [DailyCheck].
extension DailyCheckPatterns on DailyCheck {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _DailyCheck value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _DailyCheck() when $default != null:
return $default(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _DailyCheck value)  $default,){
final _that = this;
switch (_that) {
case _DailyCheck():
return $default(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _DailyCheck value)?  $default,){
final _that = this;
switch (_that) {
case _DailyCheck() when $default != null:
return $default(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String petId,  DateTime date,  List<QuickCheckType> completed)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _DailyCheck() when $default != null:
return $default(_that.petId,_that.date,_that.completed);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String petId,  DateTime date,  List<QuickCheckType> completed)  $default,) {final _that = this;
switch (_that) {
case _DailyCheck():
return $default(_that.petId,_that.date,_that.completed);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String petId,  DateTime date,  List<QuickCheckType> completed)?  $default,) {final _that = this;
switch (_that) {
case _DailyCheck() when $default != null:
return $default(_that.petId,_that.date,_that.completed);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _DailyCheck extends DailyCheck {
  const _DailyCheck({required this.petId, required this.date, final  List<QuickCheckType> completed = const <QuickCheckType>[]}): _completed = completed,super._();
  factory _DailyCheck.fromJson(Map<String, dynamic> json) => _$DailyCheckFromJson(json);

@override final  String petId;
@override final  DateTime date;
 final  List<QuickCheckType> _completed;
@override@JsonKey() List<QuickCheckType> get completed {
  if (_completed is EqualUnmodifiableListView) return _completed;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_completed);
}


/// Create a copy of DailyCheck
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DailyCheckCopyWith<_DailyCheck> get copyWith => __$DailyCheckCopyWithImpl<_DailyCheck>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$DailyCheckToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _DailyCheck&&(identical(other.petId, petId) || other.petId == petId)&&(identical(other.date, date) || other.date == date)&&const DeepCollectionEquality().equals(other._completed, _completed));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,petId,date,const DeepCollectionEquality().hash(_completed));

@override
String toString() {
  return 'DailyCheck(petId: $petId, date: $date, completed: $completed)';
}


}

/// @nodoc
abstract mixin class _$DailyCheckCopyWith<$Res> implements $DailyCheckCopyWith<$Res> {
  factory _$DailyCheckCopyWith(_DailyCheck value, $Res Function(_DailyCheck) _then) = __$DailyCheckCopyWithImpl;
@override @useResult
$Res call({
 String petId, DateTime date, List<QuickCheckType> completed
});




}
/// @nodoc
class __$DailyCheckCopyWithImpl<$Res>
    implements _$DailyCheckCopyWith<$Res> {
  __$DailyCheckCopyWithImpl(this._self, this._then);

  final _DailyCheck _self;
  final $Res Function(_DailyCheck) _then;

/// Create a copy of DailyCheck
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? petId = null,Object? date = null,Object? completed = null,}) {
  return _then(_DailyCheck(
petId: null == petId ? _self.petId : petId // ignore: cast_nullable_to_non_nullable
as String,date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as DateTime,completed: null == completed ? _self._completed : completed // ignore: cast_nullable_to_non_nullable
as List<QuickCheckType>,
  ));
}


}

// dart format on
