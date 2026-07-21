// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Ingredient _$IngredientFromJson(Map<String, dynamic> json) => _Ingredient(
  name: json['name'] as String,
  kind:
      $enumDecodeNullable(_$IngredientKindEnumMap, json['kind']) ??
      IngredientKind.good,
  note: json['note'] as String?,
);

Map<String, dynamic> _$IngredientToJson(_Ingredient instance) =>
    <String, dynamic>{
      'name': instance.name,
      'kind': _$IngredientKindEnumMap[instance.kind]!,
      'note': instance.note,
    };

const _$IngredientKindEnumMap = {
  IngredientKind.good: 'good',
  IngredientKind.caution: 'caution',
  IngredientKind.functional: 'functional',
};

_Product _$ProductFromJson(Map<String, dynamic> json) => _Product(
  id: json['id'] as String,
  name: json['name'] as String,
  brand: json['brand'] as String,
  price: (json['price'] as num).toInt(),
  species: $enumDecode(_$PetSpeciesEnumMap, json['species']),
  category:
      $enumDecodeNullable(_$ProductCategoryEnumMap, json['category']) ??
      ProductCategory.food,
  imageUrl: json['imageUrl'] as String?,
  tags:
      (json['tags'] as List<dynamic>?)?.map((e) => e as String).toList() ??
      const <String>[],
  rating: (json['rating'] as num?)?.toDouble() ?? 0,
  reviewCount: (json['reviewCount'] as num?)?.toInt() ?? 0,
  ingredients:
      (json['ingredients'] as List<dynamic>?)
          ?.map((e) => Ingredient.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const <Ingredient>[],
  suitableFor:
      (json['suitableFor'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList() ??
      const <String>[],
  reviews:
      (json['reviews'] as List<dynamic>?)
          ?.map((e) => Review.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const <Review>[],
  matchScore: (json['matchScore'] as num?)?.toInt(),
  certified: json['certified'] as bool? ?? false,
  description: json['description'] as String? ?? '',
);

Map<String, dynamic> _$ProductToJson(_Product instance) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'brand': instance.brand,
  'price': instance.price,
  'species': _$PetSpeciesEnumMap[instance.species]!,
  'category': _$ProductCategoryEnumMap[instance.category]!,
  'imageUrl': instance.imageUrl,
  'tags': instance.tags,
  'rating': instance.rating,
  'reviewCount': instance.reviewCount,
  'ingredients': instance.ingredients,
  'suitableFor': instance.suitableFor,
  'reviews': instance.reviews,
  'matchScore': instance.matchScore,
  'certified': instance.certified,
  'description': instance.description,
};

const _$PetSpeciesEnumMap = {PetSpecies.dog: 'dog', PetSpecies.cat: 'cat'};

const _$ProductCategoryEnumMap = {
  ProductCategory.food: 'food',
  ProductCategory.supplement: 'supplement',
  ProductCategory.snack: 'snack',
};
