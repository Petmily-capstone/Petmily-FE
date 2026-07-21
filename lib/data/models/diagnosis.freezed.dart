// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'diagnosis.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Diagnosis {

 String get id; String get petId; DateTime get createdAt; String get symptomText; String? get imageUrl; String get resultTitle; String get resultSummary; DiagnosisSeverity get severity; List<String> get recommendations;
/// Create a copy of Diagnosis
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DiagnosisCopyWith<Diagnosis> get copyWith => _$DiagnosisCopyWithImpl<Diagnosis>(this as Diagnosis, _$identity);

  /// Serializes this Diagnosis to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Diagnosis&&(identical(other.id, id) || other.id == id)&&(identical(other.petId, petId) || other.petId == petId)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.symptomText, symptomText) || other.symptomText == symptomText)&&(identical(other.imageUrl, imageUrl) || other.imageUrl == imageUrl)&&(identical(other.resultTitle, resultTitle) || other.resultTitle == resultTitle)&&(identical(other.resultSummary, resultSummary) || other.resultSummary == resultSummary)&&(identical(other.severity, severity) || other.severity == severity)&&const DeepCollectionEquality().equals(other.recommendations, recommendations));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,petId,createdAt,symptomText,imageUrl,resultTitle,resultSummary,severity,const DeepCollectionEquality().hash(recommendations));

@override
String toString() {
  return 'Diagnosis(id: $id, petId: $petId, createdAt: $createdAt, symptomText: $symptomText, imageUrl: $imageUrl, resultTitle: $resultTitle, resultSummary: $resultSummary, severity: $severity, recommendations: $recommendations)';
}


}

/// @nodoc
abstract mixin class $DiagnosisCopyWith<$Res>  {
  factory $DiagnosisCopyWith(Diagnosis value, $Res Function(Diagnosis) _then) = _$DiagnosisCopyWithImpl;
@useResult
$Res call({
 String id, String petId, DateTime createdAt, String symptomText, String? imageUrl, String resultTitle, String resultSummary, DiagnosisSeverity severity, List<String> recommendations
});




}
/// @nodoc
class _$DiagnosisCopyWithImpl<$Res>
    implements $DiagnosisCopyWith<$Res> {
  _$DiagnosisCopyWithImpl(this._self, this._then);

  final Diagnosis _self;
  final $Res Function(Diagnosis) _then;

/// Create a copy of Diagnosis
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? petId = null,Object? createdAt = null,Object? symptomText = null,Object? imageUrl = freezed,Object? resultTitle = null,Object? resultSummary = null,Object? severity = null,Object? recommendations = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,petId: null == petId ? _self.petId : petId // ignore: cast_nullable_to_non_nullable
as String,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,symptomText: null == symptomText ? _self.symptomText : symptomText // ignore: cast_nullable_to_non_nullable
as String,imageUrl: freezed == imageUrl ? _self.imageUrl : imageUrl // ignore: cast_nullable_to_non_nullable
as String?,resultTitle: null == resultTitle ? _self.resultTitle : resultTitle // ignore: cast_nullable_to_non_nullable
as String,resultSummary: null == resultSummary ? _self.resultSummary : resultSummary // ignore: cast_nullable_to_non_nullable
as String,severity: null == severity ? _self.severity : severity // ignore: cast_nullable_to_non_nullable
as DiagnosisSeverity,recommendations: null == recommendations ? _self.recommendations : recommendations // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}

}


/// Adds pattern-matching-related methods to [Diagnosis].
extension DiagnosisPatterns on Diagnosis {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Diagnosis value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Diagnosis() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Diagnosis value)  $default,){
final _that = this;
switch (_that) {
case _Diagnosis():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Diagnosis value)?  $default,){
final _that = this;
switch (_that) {
case _Diagnosis() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String petId,  DateTime createdAt,  String symptomText,  String? imageUrl,  String resultTitle,  String resultSummary,  DiagnosisSeverity severity,  List<String> recommendations)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Diagnosis() when $default != null:
return $default(_that.id,_that.petId,_that.createdAt,_that.symptomText,_that.imageUrl,_that.resultTitle,_that.resultSummary,_that.severity,_that.recommendations);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String petId,  DateTime createdAt,  String symptomText,  String? imageUrl,  String resultTitle,  String resultSummary,  DiagnosisSeverity severity,  List<String> recommendations)  $default,) {final _that = this;
switch (_that) {
case _Diagnosis():
return $default(_that.id,_that.petId,_that.createdAt,_that.symptomText,_that.imageUrl,_that.resultTitle,_that.resultSummary,_that.severity,_that.recommendations);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String petId,  DateTime createdAt,  String symptomText,  String? imageUrl,  String resultTitle,  String resultSummary,  DiagnosisSeverity severity,  List<String> recommendations)?  $default,) {final _that = this;
switch (_that) {
case _Diagnosis() when $default != null:
return $default(_that.id,_that.petId,_that.createdAt,_that.symptomText,_that.imageUrl,_that.resultTitle,_that.resultSummary,_that.severity,_that.recommendations);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Diagnosis implements Diagnosis {
  const _Diagnosis({required this.id, required this.petId, required this.createdAt, required this.symptomText, this.imageUrl, required this.resultTitle, required this.resultSummary, this.severity = DiagnosisSeverity.low, final  List<String> recommendations = const <String>[]}): _recommendations = recommendations;
  factory _Diagnosis.fromJson(Map<String, dynamic> json) => _$DiagnosisFromJson(json);

@override final  String id;
@override final  String petId;
@override final  DateTime createdAt;
@override final  String symptomText;
@override final  String? imageUrl;
@override final  String resultTitle;
@override final  String resultSummary;
@override@JsonKey() final  DiagnosisSeverity severity;
 final  List<String> _recommendations;
@override@JsonKey() List<String> get recommendations {
  if (_recommendations is EqualUnmodifiableListView) return _recommendations;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_recommendations);
}


/// Create a copy of Diagnosis
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DiagnosisCopyWith<_Diagnosis> get copyWith => __$DiagnosisCopyWithImpl<_Diagnosis>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$DiagnosisToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Diagnosis&&(identical(other.id, id) || other.id == id)&&(identical(other.petId, petId) || other.petId == petId)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.symptomText, symptomText) || other.symptomText == symptomText)&&(identical(other.imageUrl, imageUrl) || other.imageUrl == imageUrl)&&(identical(other.resultTitle, resultTitle) || other.resultTitle == resultTitle)&&(identical(other.resultSummary, resultSummary) || other.resultSummary == resultSummary)&&(identical(other.severity, severity) || other.severity == severity)&&const DeepCollectionEquality().equals(other._recommendations, _recommendations));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,petId,createdAt,symptomText,imageUrl,resultTitle,resultSummary,severity,const DeepCollectionEquality().hash(_recommendations));

@override
String toString() {
  return 'Diagnosis(id: $id, petId: $petId, createdAt: $createdAt, symptomText: $symptomText, imageUrl: $imageUrl, resultTitle: $resultTitle, resultSummary: $resultSummary, severity: $severity, recommendations: $recommendations)';
}


}

/// @nodoc
abstract mixin class _$DiagnosisCopyWith<$Res> implements $DiagnosisCopyWith<$Res> {
  factory _$DiagnosisCopyWith(_Diagnosis value, $Res Function(_Diagnosis) _then) = __$DiagnosisCopyWithImpl;
@override @useResult
$Res call({
 String id, String petId, DateTime createdAt, String symptomText, String? imageUrl, String resultTitle, String resultSummary, DiagnosisSeverity severity, List<String> recommendations
});




}
/// @nodoc
class __$DiagnosisCopyWithImpl<$Res>
    implements _$DiagnosisCopyWith<$Res> {
  __$DiagnosisCopyWithImpl(this._self, this._then);

  final _Diagnosis _self;
  final $Res Function(_Diagnosis) _then;

/// Create a copy of Diagnosis
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? petId = null,Object? createdAt = null,Object? symptomText = null,Object? imageUrl = freezed,Object? resultTitle = null,Object? resultSummary = null,Object? severity = null,Object? recommendations = null,}) {
  return _then(_Diagnosis(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,petId: null == petId ? _self.petId : petId // ignore: cast_nullable_to_non_nullable
as String,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,symptomText: null == symptomText ? _self.symptomText : symptomText // ignore: cast_nullable_to_non_nullable
as String,imageUrl: freezed == imageUrl ? _self.imageUrl : imageUrl // ignore: cast_nullable_to_non_nullable
as String?,resultTitle: null == resultTitle ? _self.resultTitle : resultTitle // ignore: cast_nullable_to_non_nullable
as String,resultSummary: null == resultSummary ? _self.resultSummary : resultSummary // ignore: cast_nullable_to_non_nullable
as String,severity: null == severity ? _self.severity : severity // ignore: cast_nullable_to_non_nullable
as DiagnosisSeverity,recommendations: null == recommendations ? _self._recommendations : recommendations // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}


}

// dart format on
