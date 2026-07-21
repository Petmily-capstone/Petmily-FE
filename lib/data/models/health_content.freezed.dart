// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'health_content.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$HealthContent {

 String get id; String get category; String get title; String get summary; String? get imageUrl;
/// Create a copy of HealthContent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$HealthContentCopyWith<HealthContent> get copyWith => _$HealthContentCopyWithImpl<HealthContent>(this as HealthContent, _$identity);

  /// Serializes this HealthContent to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is HealthContent&&(identical(other.id, id) || other.id == id)&&(identical(other.category, category) || other.category == category)&&(identical(other.title, title) || other.title == title)&&(identical(other.summary, summary) || other.summary == summary)&&(identical(other.imageUrl, imageUrl) || other.imageUrl == imageUrl));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,category,title,summary,imageUrl);

@override
String toString() {
  return 'HealthContent(id: $id, category: $category, title: $title, summary: $summary, imageUrl: $imageUrl)';
}


}

/// @nodoc
abstract mixin class $HealthContentCopyWith<$Res>  {
  factory $HealthContentCopyWith(HealthContent value, $Res Function(HealthContent) _then) = _$HealthContentCopyWithImpl;
@useResult
$Res call({
 String id, String category, String title, String summary, String? imageUrl
});




}
/// @nodoc
class _$HealthContentCopyWithImpl<$Res>
    implements $HealthContentCopyWith<$Res> {
  _$HealthContentCopyWithImpl(this._self, this._then);

  final HealthContent _self;
  final $Res Function(HealthContent) _then;

/// Create a copy of HealthContent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? category = null,Object? title = null,Object? summary = null,Object? imageUrl = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,category: null == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,summary: null == summary ? _self.summary : summary // ignore: cast_nullable_to_non_nullable
as String,imageUrl: freezed == imageUrl ? _self.imageUrl : imageUrl // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [HealthContent].
extension HealthContentPatterns on HealthContent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _HealthContent value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _HealthContent() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _HealthContent value)  $default,){
final _that = this;
switch (_that) {
case _HealthContent():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _HealthContent value)?  $default,){
final _that = this;
switch (_that) {
case _HealthContent() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String category,  String title,  String summary,  String? imageUrl)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _HealthContent() when $default != null:
return $default(_that.id,_that.category,_that.title,_that.summary,_that.imageUrl);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String category,  String title,  String summary,  String? imageUrl)  $default,) {final _that = this;
switch (_that) {
case _HealthContent():
return $default(_that.id,_that.category,_that.title,_that.summary,_that.imageUrl);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String category,  String title,  String summary,  String? imageUrl)?  $default,) {final _that = this;
switch (_that) {
case _HealthContent() when $default != null:
return $default(_that.id,_that.category,_that.title,_that.summary,_that.imageUrl);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _HealthContent implements HealthContent {
  const _HealthContent({required this.id, required this.category, required this.title, required this.summary, this.imageUrl});
  factory _HealthContent.fromJson(Map<String, dynamic> json) => _$HealthContentFromJson(json);

@override final  String id;
@override final  String category;
@override final  String title;
@override final  String summary;
@override final  String? imageUrl;

/// Create a copy of HealthContent
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$HealthContentCopyWith<_HealthContent> get copyWith => __$HealthContentCopyWithImpl<_HealthContent>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$HealthContentToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _HealthContent&&(identical(other.id, id) || other.id == id)&&(identical(other.category, category) || other.category == category)&&(identical(other.title, title) || other.title == title)&&(identical(other.summary, summary) || other.summary == summary)&&(identical(other.imageUrl, imageUrl) || other.imageUrl == imageUrl));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,category,title,summary,imageUrl);

@override
String toString() {
  return 'HealthContent(id: $id, category: $category, title: $title, summary: $summary, imageUrl: $imageUrl)';
}


}

/// @nodoc
abstract mixin class _$HealthContentCopyWith<$Res> implements $HealthContentCopyWith<$Res> {
  factory _$HealthContentCopyWith(_HealthContent value, $Res Function(_HealthContent) _then) = __$HealthContentCopyWithImpl;
@override @useResult
$Res call({
 String id, String category, String title, String summary, String? imageUrl
});




}
/// @nodoc
class __$HealthContentCopyWithImpl<$Res>
    implements _$HealthContentCopyWith<$Res> {
  __$HealthContentCopyWithImpl(this._self, this._then);

  final _HealthContent _self;
  final $Res Function(_HealthContent) _then;

/// Create a copy of HealthContent
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? category = null,Object? title = null,Object? summary = null,Object? imageUrl = freezed,}) {
  return _then(_HealthContent(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,category: null == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,summary: null == summary ? _self.summary : summary // ignore: cast_nullable_to_non_nullable
as String,imageUrl: freezed == imageUrl ? _self.imageUrl : imageUrl // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
