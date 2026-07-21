// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'health_content.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_HealthContent _$HealthContentFromJson(Map<String, dynamic> json) =>
    _HealthContent(
      id: json['id'] as String,
      category: json['category'] as String,
      title: json['title'] as String,
      summary: json['summary'] as String,
      imageUrl: json['imageUrl'] as String?,
    );

Map<String, dynamic> _$HealthContentToJson(_HealthContent instance) =>
    <String, dynamic>{
      'id': instance.id,
      'category': instance.category,
      'title': instance.title,
      'summary': instance.summary,
      'imageUrl': instance.imageUrl,
    };
