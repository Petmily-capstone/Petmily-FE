// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'health_content.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_HealthContent _$HealthContentFromJson(Map<String, dynamic> json) =>
    _HealthContent(
      id: json['id'] as String,
      category: $enumDecode(_$ContentCategoryEnumMap, json['category']),
      title: json['title'] as String,
      body: json['body'] as String,
      imageUrls:
          (json['imageUrls'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const <String>[],
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
    );

Map<String, dynamic> _$HealthContentToJson(_HealthContent instance) =>
    <String, dynamic>{
      'id': instance.id,
      'category': _$ContentCategoryEnumMap[instance.category]!,
      'title': instance.title,
      'body': instance.body,
      'imageUrls': instance.imageUrls,
      'createdAt': instance.createdAt?.toIso8601String(),
    };

const _$ContentCategoryEnumMap = {
  ContentCategory.skin: 'skin',
  ContentCategory.joint: 'joint',
  ContentCategory.diet: 'diet',
  ContentCategory.etc: 'etc',
};
