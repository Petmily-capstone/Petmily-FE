import '../models/models.dart';

/// 건강 콘텐츠 도메인 Repository 인터페이스.
abstract interface class ContentRepository {
  /// 건강 콘텐츠 목록(최신순).
  Future<List<HealthContent>> fetchHealthContents();

  /// 단일 콘텐츠 조회.
  Future<HealthContent> fetchHealthContent(String id);

  /// 새 게시글 작성.
  ///
  /// [imagePaths]는 로컬 파일 경로. 지금은 그대로 저장하지만, 백엔드 연동 시
  /// 업로드 후 받은 URL로 치환한다.
  Future<HealthContent> createHealthContent({
    required ContentCategory category,
    required String title,
    required String body,
    required List<String> imagePaths,
  });
}
