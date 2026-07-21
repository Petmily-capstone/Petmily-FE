// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'daily_check.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_DailyCheck _$DailyCheckFromJson(Map<String, dynamic> json) => _DailyCheck(
  petId: json['petId'] as String,
  date: DateTime.parse(json['date'] as String),
  completed:
      (json['completed'] as List<dynamic>?)
          ?.map((e) => $enumDecode(_$QuickCheckTypeEnumMap, e))
          .toList() ??
      const <QuickCheckType>[],
);

Map<String, dynamic> _$DailyCheckToJson(_DailyCheck instance) =>
    <String, dynamic>{
      'petId': instance.petId,
      'date': instance.date.toIso8601String(),
      'completed': instance.completed
          .map((e) => _$QuickCheckTypeEnumMap[e]!)
          .toList(),
    };

const _$QuickCheckTypeEnumMap = {
  QuickCheckType.walk: 'walk',
  QuickCheckType.play: 'play',
  QuickCheckType.meal: 'meal',
  QuickCheckType.water: 'water',
  QuickCheckType.nutrition: 'nutrition',
};
