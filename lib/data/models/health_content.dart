import 'package:freezed_annotation/freezed_annotation.dart';

import 'enums.dart';

part 'health_content.freezed.dart';
part 'health_content.g.dart';

/// 건강 콘텐츠(게시글).
///
/// 홈의 '건강 콘텐츠' 캐러셀과 전체보기 목록에 함께 쓰인다. 사용자가 직접 작성할 수
/// 있으며 태그(카테고리)와 최대 5장의 사진을 가진다.
@freezed
abstract class HealthContent with _$HealthContent {
  const HealthContent._();

  const factory HealthContent({
    required String id,
    required ContentCategory category,
    required String title,
    // 본문.
    required String body,
    // 사진(최대 [maxImages]장). 원격 URL 또는 로컬 파일 경로.
    @Default(<String>[]) List<String> imageUrls,
    DateTime? createdAt,
  }) = _HealthContent;

  factory HealthContent.fromJson(Map<String, dynamic> json) =>
      _$HealthContentFromJson(json);

  /// 게시글에 넣을 수 있는 최대 사진 수.
  static const int maxImages = 5;

  /// 대표 이미지(없으면 null).
  String? get thumbnailUrl => imageUrls.isEmpty ? null : imageUrls.first;
}
