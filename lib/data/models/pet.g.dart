// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pet.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Pet _$PetFromJson(Map<String, dynamic> json) => _Pet(
  id: json['id'] as String,
  name: json['name'] as String,
  species: $enumDecode(_$PetSpeciesEnumMap, json['species']),
  breed: json['breed'] as String?,
  gender: $enumDecodeNullable(_$PetGenderEnumMap, json['gender']),
  birthDate: json['birthDate'] == null
      ? null
      : DateTime.parse(json['birthDate'] as String),
  weightKg: (json['weightKg'] as num?)?.toDouble(),
  imageUrl: json['imageUrl'] as String?,
  size: $enumDecodeNullable(_$DogSizeEnumMap, json['size']),
  neutered: json['neutered'] as bool?,
  allergies:
      (json['allergies'] as List<dynamic>?)?.map((e) => e as String).toList() ??
      const <String>[],
  exp: (json['exp'] as num?)?.toInt() ?? 0,
);

Map<String, dynamic> _$PetToJson(_Pet instance) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'species': _$PetSpeciesEnumMap[instance.species]!,
  'breed': instance.breed,
  'gender': _$PetGenderEnumMap[instance.gender],
  'birthDate': instance.birthDate?.toIso8601String(),
  'weightKg': instance.weightKg,
  'imageUrl': instance.imageUrl,
  'size': _$DogSizeEnumMap[instance.size],
  'neutered': instance.neutered,
  'allergies': instance.allergies,
  'exp': instance.exp,
};

const _$PetSpeciesEnumMap = {PetSpecies.dog: 'dog', PetSpecies.cat: 'cat'};

const _$PetGenderEnumMap = {PetGender.male: 'male', PetGender.female: 'female'};

const _$DogSizeEnumMap = {
  DogSize.small: 'small',
  DogSize.medium: 'medium',
  DogSize.large: 'large',
};
