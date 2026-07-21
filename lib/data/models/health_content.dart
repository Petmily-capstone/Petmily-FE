import 'package:freezed_annotation/freezed_annotation.dart';

part 'health_content.freezed.dart';
part 'health_content.g.dart';

/// 홈 '건강 콘텐츠' 아이템.
@freezed
abstract class HealthContent with _$HealthContent {
  const factory HealthContent({
    required String id,
    // 분류 태그(예: 피부관리, 관절건강).
    required String category,
    required String title,
    required String summary,
    String? imageUrl,
  }) = _HealthContent;

  factory HealthContent.fromJson(Map<String, dynamic> json) =>
      _$HealthContentFromJson(json);
}
