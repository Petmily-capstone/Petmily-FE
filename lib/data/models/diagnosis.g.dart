// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'diagnosis.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Diagnosis _$DiagnosisFromJson(Map<String, dynamic> json) => _Diagnosis(
  id: json['id'] as String,
  petId: json['petId'] as String,
  createdAt: DateTime.parse(json['createdAt'] as String),
  symptomText: json['symptomText'] as String,
  imageUrl: json['imageUrl'] as String?,
  resultTitle: json['resultTitle'] as String,
  resultSummary: json['resultSummary'] as String,
  severity:
      $enumDecodeNullable(_$DiagnosisSeverityEnumMap, json['severity']) ??
      DiagnosisSeverity.low,
  recommendations:
      (json['recommendations'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList() ??
      const <String>[],
);

Map<String, dynamic> _$DiagnosisToJson(_Diagnosis instance) =>
    <String, dynamic>{
      'id': instance.id,
      'petId': instance.petId,
      'createdAt': instance.createdAt.toIso8601String(),
      'symptomText': instance.symptomText,
      'imageUrl': instance.imageUrl,
      'resultTitle': instance.resultTitle,
      'resultSummary': instance.resultSummary,
      'severity': _$DiagnosisSeverityEnumMap[instance.severity]!,
      'recommendations': instance.recommendations,
    };

const _$DiagnosisSeverityEnumMap = {
  DiagnosisSeverity.low: 'low',
  DiagnosisSeverity.medium: 'medium',
  DiagnosisSeverity.high: 'high',
};
