// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'review.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Review _$ReviewFromJson(Map<String, dynamic> json) => _Review(
  id: json['id'] as String,
  author: json['author'] as String,
  rating: (json['rating'] as num).toDouble(),
  text: json['text'] as String,
  createdAt: DateTime.parse(json['createdAt'] as String),
);

Map<String, dynamic> _$ReviewToJson(_Review instance) => <String, dynamic>{
  'id': instance.id,
  'author': instance.author,
  'rating': instance.rating,
  'text': instance.text,
  'createdAt': instance.createdAt.toIso8601String(),
};
