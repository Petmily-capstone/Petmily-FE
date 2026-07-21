// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Ingredient _$IngredientFromJson(Map<String, dynamic> json) => _Ingredient(
  name: json['name'] as String,
  isGood: json['isGood'] as bool? ?? true,
  note: json['note'] as String?,
);

Map<String, dynamic> _$IngredientToJson(_Ingredient instance) =>
    <String, dynamic>{
      'name': instance.name,
      'isGood': instance.isGood,
      'note': instance.note,
    };

_Product _$ProductFromJson(Map<String, dynamic> json) => _Product(
  id: json['id'] as String,
  name: json['name'] as String,
  brand: json['brand'] as String,
  price: (json['price'] as num).toInt(),
  species: $enumDecode(_$PetSpeciesEnumMap, json['species']),
  imageUrl: json['imageUrl'] as String?,
  tags:
      (json['tags'] as List<dynamic>?)?.map((e) => e as String).toList() ??
      const <String>[],
  rating: (json['rating'] as num?)?.toDouble() ?? 0,
  ingredients:
      (json['ingredients'] as List<dynamic>?)
          ?.map((e) => Ingredient.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const <Ingredient>[],
  matchScore: (json['matchScore'] as num?)?.toInt(),
  description: json['description'] as String? ?? '',
);

Map<String, dynamic> _$ProductToJson(_Product instance) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'brand': instance.brand,
  'price': instance.price,
  'species': _$PetSpeciesEnumMap[instance.species]!,
  'imageUrl': instance.imageUrl,
  'tags': instance.tags,
  'rating': instance.rating,
  'ingredients': instance.ingredients,
  'matchScore': instance.matchScore,
  'description': instance.description,
};

const _$PetSpeciesEnumMap = {PetSpecies.dog: 'dog', PetSpecies.cat: 'cat'};
