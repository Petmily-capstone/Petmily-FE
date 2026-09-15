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

 String get id; ContentCategory get category; String get title; String get body; List<String> get imageUrls; DateTime? get createdAt;
/// Create a copy of HealthContent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$HealthContentCopyWith<HealthContent> get copyWith => _$HealthContentCopyWithImpl<HealthContent>(this as HealthContent, _$identity);

  /// Serializes this HealthContent to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is HealthContent&&(identical(other.id, id) || other.id == id)&&(identical(other.category, category) || other.category == category)&&(identical(other.title, title) || other.title == title)&&(identical(other.body, body) || other.body == body)&&const DeepCollectionEquality().equals(other.imageUrls, imageUrls)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,category,title,body,const DeepCollectionEquality().hash(imageUrls),createdAt);

@override
String toString() {
  return 'HealthContent(id: $id, category: $category, title: $title, body: $body, imageUrls: $imageUrls, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class $HealthContentCopyWith<$Res>  {
  factory $HealthContentCopyWith(HealthContent value, $Res Function(HealthContent) _then) = _$HealthContentCopyWithImpl;
@useResult
$Res call({
 String id, ContentCategory category, String title, String body, List<String> imageUrls, DateTime? createdAt
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
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? category = null,Object? title = null,Object? body = null,Object? imageUrls = null,Object? createdAt = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,category: null == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as ContentCategory,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,body: null == body ? _self.body : body // ignore: cast_nullable_to_non_nullable
as String,imageUrls: null == imageUrls ? _self.imageUrls : imageUrls // ignore: cast_nullable_to_non_nullable
as List<String>,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  ContentCategory category,  String title,  String body,  List<String> imageUrls,  DateTime? createdAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _HealthContent() when $default != null:
return $default(_that.id,_that.category,_that.title,_that.body,_that.imageUrls,_that.createdAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  ContentCategory category,  String title,  String body,  List<String> imageUrls,  DateTime? createdAt)  $default,) {final _that = this;
switch (_that) {
case _HealthContent():
return $default(_that.id,_that.category,_that.title,_that.body,_that.imageUrls,_that.createdAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  ContentCategory category,  String title,  String body,  List<String> imageUrls,  DateTime? createdAt)?  $default,) {final _that = this;
switch (_that) {
case _HealthContent() when $default != null:
return $default(_that.id,_that.category,_that.title,_that.body,_that.imageUrls,_that.createdAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _HealthContent extends HealthContent {
  const _HealthContent({required this.id, required this.category, required this.title, required this.body, final  List<String> imageUrls = const <String>[], this.createdAt}): _imageUrls = imageUrls,super._();
  factory _HealthContent.fromJson(Map<String, dynamic> json) => _$HealthContentFromJson(json);

@override final  String id;
@override final  ContentCategory category;
@override final  String title;
@override final  String body;
 final  List<String> _imageUrls;
@override@JsonKey() List<String> get imageUrls {
  if (_imageUrls is EqualUnmodifiableListView) return _imageUrls;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_imageUrls);
}

@override final  DateTime? createdAt;

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
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _HealthContent&&(identical(other.id, id) || other.id == id)&&(identical(other.category, category) || other.category == category)&&(identical(other.title, title) || other.title == title)&&(identical(other.body, body) || other.body == body)&&const DeepCollectionEquality().equals(other._imageUrls, _imageUrls)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,category,title,body,const DeepCollectionEquality().hash(_imageUrls),createdAt);

@override
String toString() {
  return 'HealthContent(id: $id, category: $category, title: $title, body: $body, imageUrls: $imageUrls, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class _$HealthContentCopyWith<$Res> implements $HealthContentCopyWith<$Res> {
  factory _$HealthContentCopyWith(_HealthContent value, $Res Function(_HealthContent) _then) = __$HealthContentCopyWithImpl;
@override @useResult
$Res call({
 String id, ContentCategory category, String title, String body, List<String> imageUrls, DateTime? createdAt
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
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? category = null,Object? title = null,Object? body = null,Object? imageUrls = null,Object? createdAt = freezed,}) {
  return _then(_HealthContent(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,category: null == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as ContentCategory,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,body: null == body ? _self.body : body // ignore: cast_nullable_to_non_nullable
as String,imageUrls: null == imageUrls ? _self._imageUrls : imageUrls // ignore: cast_nullable_to_non_nullable
as List<String>,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}

// dart format on
