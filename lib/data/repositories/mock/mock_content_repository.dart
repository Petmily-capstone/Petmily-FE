import '../../models/models.dart';
import '../../mock/mock_data.dart';
import '../content_repository.dart';

/// 목 건강 콘텐츠 구현.
class MockContentRepository implements ContentRepository {
  @override
  Future<List<HealthContent>> fetchHealthContents() async {
    await Future.delayed(const Duration(milliseconds: 300));
    return MockData.healthContents();
  }
}
