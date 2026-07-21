import '../models/models.dart';

/// 건강 콘텐츠 도메인 Repository 인터페이스.
abstract interface class ContentRepository {
  /// 홈 '건강 콘텐츠' 목록.
  Future<List<HealthContent>> fetchHealthContents();
}
