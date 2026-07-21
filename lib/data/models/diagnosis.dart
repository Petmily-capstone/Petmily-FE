import 'package:freezed_annotation/freezed_annotation.dart';

import 'enums.dart';

part 'diagnosis.freezed.dart';
part 'diagnosis.g.dart';

/// AI 증상 진단 결과 1건.
@freezed
abstract class Diagnosis with _$Diagnosis {
  const factory Diagnosis({
    required String id,
    required String petId,
    required DateTime createdAt,
    required String symptomText,
    // TODO: 진단 사진 업로드 연동 시 원격 URL 매핑.
    String? imageUrl,
    required String resultTitle,
    required String resultSummary,
    @Default(DiagnosisSeverity.low) DiagnosisSeverity severity,
    @Default(<String>[]) List<String> recommendations,
  }) = _Diagnosis;

  factory Diagnosis.fromJson(Map<String, dynamic> json) =>
      _$DiagnosisFromJson(json);
}
