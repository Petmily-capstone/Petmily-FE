// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'product.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Ingredient {

 String get name; IngredientKind get kind; String? get note;
/// Create a copy of Ingredient
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$IngredientCopyWith<Ingredient> get copyWith => _$IngredientCopyWithImpl<Ingredient>(this as Ingredient, _$identity);

  /// Serializes this Ingredient to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Ingredient&&(identical(other.name, name) || other.name == name)&&(identical(other.kind, kind) || other.kind == kind)&&(identical(other.note, note) || other.note == note));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,name,kind,note);

@override
String toString() {
  return 'Ingredient(name: $name, kind: $kind, note: $note)';
}


}

/// @nodoc
abstract mixin class $IngredientCopyWith<$Res>  {
  factory $IngredientCopyWith(Ingredient value, $Res Function(Ingredient) _then) = _$IngredientCopyWithImpl;
@useResult
$Res call({
 String name, IngredientKind kind, String? note
});




}
/// @nodoc
class _$IngredientCopyWithImpl<$Res>
    implements $IngredientCopyWith<$Res> {
  _$IngredientCopyWithImpl(this._self, this._then);

  final Ingredient _self;
  final $Res Function(Ingredient) _then;

/// Create a copy of Ingredient
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? name = null,Object? kind = null,Object? note = freezed,}) {
  return _then(_self.copyWith(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,kind: null == kind ? _self.kind : kind // ignore: cast_nullable_to_non_nullable
as IngredientKind,note: freezed == note ? _self.note : note // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [Ingredient].
extension IngredientPatterns on Ingredient {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Ingredient value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Ingredient() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Ingredient value)  $default,){
final _that = this;
switch (_that) {
case _Ingredient():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Ingredient value)?  $default,){
final _that = this;
switch (_that) {
case _Ingredient() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String name,  IngredientKind kind,  String? note)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Ingredient() when $default != null:
return $default(_that.name,_that.kind,_that.note);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String name,  IngredientKind kind,  String? note)  $default,) {final _that = this;
switch (_that) {
case _Ingredient():
return $default(_that.name,_that.kind,_that.note);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String name,  IngredientKind kind,  String? note)?  $default,) {final _that = this;
switch (_that) {
case _Ingredient() when $default != null:
return $default(_that.name,_that.kind,_that.note);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Ingredient implements Ingredient {
  const _Ingredient({required this.name, this.kind = IngredientKind.good, this.note});
  factory _Ingredient.fromJson(Map<String, dynamic> json) => _$IngredientFromJson(json);

@override final  String name;
@override@JsonKey() final  IngredientKind kind;
@override final  String? note;

/// Create a copy of Ingredient
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$IngredientCopyWith<_Ingredient> get copyWith => __$IngredientCopyWithImpl<_Ingredient>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$IngredientToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Ingredient&&(identical(other.name, name) || other.name == name)&&(identical(other.kind, kind) || other.kind == kind)&&(identical(other.note, note) || other.note == note));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,name,kind,note);

@override
String toString() {
  return 'Ingredient(name: $name, kind: $kind, note: $note)';
}


}

/// @nodoc
abstract mixin class _$IngredientCopyWith<$Res> implements $IngredientCopyWith<$Res> {
  factory _$IngredientCopyWith(_Ingredient value, $Res Function(_Ingredient) _then) = __$IngredientCopyWithImpl;
@override @useResult
$Res call({
 String name, IngredientKind kind, String? note
});




}
/// @nodoc
class __$IngredientCopyWithImpl<$Res>
    implements _$IngredientCopyWith<$Res> {
  __$IngredientCopyWithImpl(this._self, this._then);

  final _Ingredient _self;
  final $Res Function(_Ingredient) _then;

/// Create a copy of Ingredient
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? name = null,Object? kind = null,Object? note = freezed,}) {
  return _then(_Ingredient(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,kind: null == kind ? _self.kind : kind // ignore: cast_nullable_to_non_nullable
as IngredientKind,note: freezed == note ? _self.note : note // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}


/// @nodoc
mixin _$Product {

 String get id; String get name; String get brand; int get price; PetSpecies get species; ProductCategory get category; String? get imageUrl; List<String> get tags; double get rating; int get reviewCount; List<Ingredient> get ingredients; List<String> get suitableFor; List<Review> get reviews; int? get matchScore; bool get certified; String get description;
/// Create a copy of Product
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ProductCopyWith<Product> get copyWith => _$ProductCopyWithImpl<Product>(this as Product, _$identity);

  /// Serializes this Product to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Product&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.brand, brand) || other.brand == brand)&&(identical(other.price, price) || other.price == price)&&(identical(other.species, species) || other.species == species)&&(identical(other.category, category) || other.category == category)&&(identical(other.imageUrl, imageUrl) || other.imageUrl == imageUrl)&&const DeepCollectionEquality().equals(other.tags, tags)&&(identical(other.rating, rating) || other.rating == rating)&&(identical(other.reviewCount, reviewCount) || other.reviewCount == reviewCount)&&const DeepCollectionEquality().equals(other.ingredients, ingredients)&&const DeepCollectionEquality().equals(other.suitableFor, suitableFor)&&const DeepCollectionEquality().equals(other.reviews, reviews)&&(identical(other.matchScore, matchScore) || other.matchScore == matchScore)&&(identical(other.certified, certified) || other.certified == certified)&&(identical(other.description, description) || other.description == description));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,brand,price,species,category,imageUrl,const DeepCollectionEquality().hash(tags),rating,reviewCount,const DeepCollectionEquality().hash(ingredients),const DeepCollectionEquality().hash(suitableFor),const DeepCollectionEquality().hash(reviews),matchScore,certified,description);

@override
String toString() {
  return 'Product(id: $id, name: $name, brand: $brand, price: $price, species: $species, category: $category, imageUrl: $imageUrl, tags: $tags, rating: $rating, reviewCount: $reviewCount, ingredients: $ingredients, suitableFor: $suitableFor, reviews: $reviews, matchScore: $matchScore, certified: $certified, description: $description)';
}


}

/// @nodoc
abstract mixin class $ProductCopyWith<$Res>  {
  factory $ProductCopyWith(Product value, $Res Function(Product) _then) = _$ProductCopyWithImpl;
@useResult
$Res call({
 String id, String name, String brand, int price, PetSpecies species, ProductCategory category, String? imageUrl, List<String> tags, double rating, int reviewCount, List<Ingredient> ingredients, List<String> suitableFor, List<Review> reviews, int? matchScore, bool certified, String description
});




}
/// @nodoc
class _$ProductCopyWithImpl<$Res>
    implements $ProductCopyWith<$Res> {
  _$ProductCopyWithImpl(this._self, this._then);

  final Product _self;
  final $Res Function(Product) _then;

/// Create a copy of Product
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? brand = null,Object? price = null,Object? species = null,Object? category = null,Object? imageUrl = freezed,Object? tags = null,Object? rating = null,Object? reviewCount = null,Object? ingredients = null,Object? suitableFor = null,Object? reviews = null,Object? matchScore = freezed,Object? certified = null,Object? description = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,brand: null == brand ? _self.brand : brand // ignore: cast_nullable_to_non_nullable
as String,price: null == price ? _self.price : price // ignore: cast_nullable_to_non_nullable
as int,species: null == species ? _self.species : species // ignore: cast_nullable_to_non_nullable
as PetSpecies,category: null == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as ProductCategory,imageUrl: freezed == imageUrl ? _self.imageUrl : imageUrl // ignore: cast_nullable_to_non_nullable
as String?,tags: null == tags ? _self.tags : tags // ignore: cast_nullable_to_non_nullable
as List<String>,rating: null == rating ? _self.rating : rating // ignore: cast_nullable_to_non_nullable
as double,reviewCount: null == reviewCount ? _self.reviewCount : reviewCount // ignore: cast_nullable_to_non_nullable
as int,ingredients: null == ingredients ? _self.ingredients : ingredients // ignore: cast_nullable_to_non_nullable
as List<Ingredient>,suitableFor: null == suitableFor ? _self.suitableFor : suitableFor // ignore: cast_nullable_to_non_nullable
as List<String>,reviews: null == reviews ? _self.reviews : reviews // ignore: cast_nullable_to_non_nullable
as List<Review>,matchScore: freezed == matchScore ? _self.matchScore : matchScore // ignore: cast_nullable_to_non_nullable
as int?,certified: null == certified ? _self.certified : certified // ignore: cast_nullable_to_non_nullable
as bool,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [Product].
extension ProductPatterns on Product {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Product value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Product() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Product value)  $default,){
final _that = this;
switch (_that) {
case _Product():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Product value)?  $default,){
final _that = this;
switch (_that) {
case _Product() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String name,  String brand,  int price,  PetSpecies species,  ProductCategory category,  String? imageUrl,  List<String> tags,  double rating,  int reviewCount,  List<Ingredient> ingredients,  List<String> suitableFor,  List<Review> reviews,  int? matchScore,  bool certified,  String description)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Product() when $default != null:
return $default(_that.id,_that.name,_that.brand,_that.price,_that.species,_that.category,_that.imageUrl,_that.tags,_that.rating,_that.reviewCount,_that.ingredients,_that.suitableFor,_that.reviews,_that.matchScore,_that.certified,_that.description);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String name,  String brand,  int price,  PetSpecies species,  ProductCategory category,  String? imageUrl,  List<String> tags,  double rating,  int reviewCount,  List<Ingredient> ingredients,  List<String> suitableFor,  List<Review> reviews,  int? matchScore,  bool certified,  String description)  $default,) {final _that = this;
switch (_that) {
case _Product():
return $default(_that.id,_that.name,_that.brand,_that.price,_that.species,_that.category,_that.imageUrl,_that.tags,_that.rating,_that.reviewCount,_that.ingredients,_that.suitableFor,_that.reviews,_that.matchScore,_that.certified,_that.description);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String name,  String brand,  int price,  PetSpecies species,  ProductCategory category,  String? imageUrl,  List<String> tags,  double rating,  int reviewCount,  List<Ingredient> ingredients,  List<String> suitableFor,  List<Review> reviews,  int? matchScore,  bool certified,  String description)?  $default,) {final _that = this;
switch (_that) {
case _Product() when $default != null:
return $default(_that.id,_that.name,_that.brand,_that.price,_that.species,_that.category,_that.imageUrl,_that.tags,_that.rating,_that.reviewCount,_that.ingredients,_that.suitableFor,_that.reviews,_that.matchScore,_that.certified,_that.description);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Product extends Product {
  const _Product({required this.id, required this.name, required this.brand, required this.price, required this.species, this.category = ProductCategory.food, this.imageUrl, final  List<String> tags = const <String>[], this.rating = 0, this.reviewCount = 0, final  List<Ingredient> ingredients = const <Ingredient>[], final  List<String> suitableFor = const <String>[], final  List<Review> reviews = const <Review>[], this.matchScore, this.certified = false, this.description = ''}): _tags = tags,_ingredients = ingredients,_suitableFor = suitableFor,_reviews = reviews,super._();
  factory _Product.fromJson(Map<String, dynamic> json) => _$ProductFromJson(json);

@override final  String id;
@override final  String name;
@override final  String brand;
@override final  int price;
@override final  PetSpecies species;
@override@JsonKey() final  ProductCategory category;
@override final  String? imageUrl;
 final  List<String> _tags;
@override@JsonKey() List<String> get tags {
  if (_tags is EqualUnmodifiableListView) return _tags;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_tags);
}

@override@JsonKey() final  double rating;
@override@JsonKey() final  int reviewCount;
 final  List<Ingredient> _ingredients;
@override@JsonKey() List<Ingredient> get ingredients {
  if (_ingredients is EqualUnmodifiableListView) return _ingredients;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_ingredients);
}

 final  List<String> _suitableFor;
@override@JsonKey() List<String> get suitableFor {
  if (_suitableFor is EqualUnmodifiableListView) return _suitableFor;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_suitableFor);
}

 final  List<Review> _reviews;
@override@JsonKey() List<Review> get reviews {
  if (_reviews is EqualUnmodifiableListView) return _reviews;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_reviews);
}

@override final  int? matchScore;
@override@JsonKey() final  bool certified;
@override@JsonKey() final  String description;

/// Create a copy of Product
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ProductCopyWith<_Product> get copyWith => __$ProductCopyWithImpl<_Product>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ProductToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Product&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.brand, brand) || other.brand == brand)&&(identical(other.price, price) || other.price == price)&&(identical(other.species, species) || other.species == species)&&(identical(other.category, category) || other.category == category)&&(identical(other.imageUrl, imageUrl) || other.imageUrl == imageUrl)&&const DeepCollectionEquality().equals(other._tags, _tags)&&(identical(other.rating, rating) || other.rating == rating)&&(identical(other.reviewCount, reviewCount) || other.reviewCount == reviewCount)&&const DeepCollectionEquality().equals(other._ingredients, _ingredients)&&const DeepCollectionEquality().equals(other._suitableFor, _suitableFor)&&const DeepCollectionEquality().equals(other._reviews, _reviews)&&(identical(other.matchScore, matchScore) || other.matchScore == matchScore)&&(identical(other.certified, certified) || other.certified == certified)&&(identical(other.description, description) || other.description == description));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,brand,price,species,category,imageUrl,const DeepCollectionEquality().hash(_tags),rating,reviewCount,const DeepCollectionEquality().hash(_ingredients),const DeepCollectionEquality().hash(_suitableFor),const DeepCollectionEquality().hash(_reviews),matchScore,certified,description);

@override
String toString() {
  return 'Product(id: $id, name: $name, brand: $brand, price: $price, species: $species, category: $category, imageUrl: $imageUrl, tags: $tags, rating: $rating, reviewCount: $reviewCount, ingredients: $ingredients, suitableFor: $suitableFor, reviews: $reviews, matchScore: $matchScore, certified: $certified, description: $description)';
}


}

/// @nodoc
abstract mixin class _$ProductCopyWith<$Res> implements $ProductCopyWith<$Res> {
  factory _$ProductCopyWith(_Product value, $Res Function(_Product) _then) = __$ProductCopyWithImpl;
@override @useResult
$Res call({
 String id, String name, String brand, int price, PetSpecies species, ProductCategory category, String? imageUrl, List<String> tags, double rating, int reviewCount, List<Ingredient> ingredients, List<String> suitableFor, List<Review> reviews, int? matchScore, bool certified, String description
});




}
/// @nodoc
class __$ProductCopyWithImpl<$Res>
    implements _$ProductCopyWith<$Res> {
  __$ProductCopyWithImpl(this._self, this._then);

  final _Product _self;
  final $Res Function(_Product) _then;

/// Create a copy of Product
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? brand = null,Object? price = null,Object? species = null,Object? category = null,Object? imageUrl = freezed,Object? tags = null,Object? rating = null,Object? reviewCount = null,Object? ingredients = null,Object? suitableFor = null,Object? reviews = null,Object? matchScore = freezed,Object? certified = null,Object? description = null,}) {
  return _then(_Product(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,brand: null == brand ? _self.brand : brand // ignore: cast_nullable_to_non_nullable
as String,price: null == price ? _self.price : price // ignore: cast_nullable_to_non_nullable
as int,species: null == species ? _self.species : species // ignore: cast_nullable_to_non_nullable
as PetSpecies,category: null == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as ProductCategory,imageUrl: freezed == imageUrl ? _self.imageUrl : imageUrl // ignore: cast_nullable_to_non_nullable
as String?,tags: null == tags ? _self._tags : tags // ignore: cast_nullable_to_non_nullable
as List<String>,rating: null == rating ? _self.rating : rating // ignore: cast_nullable_to_non_nullable
as double,reviewCount: null == reviewCount ? _self.reviewCount : reviewCount // ignore: cast_nullable_to_non_nullable
as int,ingredients: null == ingredients ? _self._ingredients : ingredients // ignore: cast_nullable_to_non_nullable
as List<Ingredient>,suitableFor: null == suitableFor ? _self._suitableFor : suitableFor // ignore: cast_nullable_to_non_nullable
as List<String>,reviews: null == reviews ? _self._reviews : reviews // ignore: cast_nullable_to_non_nullable
as List<Review>,matchScore: freezed == matchScore ? _self.matchScore : matchScore // ignore: cast_nullable_to_non_nullable
as int?,certified: null == certified ? _self.certified : certified // ignore: cast_nullable_to_non_nullable
as bool,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
