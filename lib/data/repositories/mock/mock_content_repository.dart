import '../../models/models.dart';
import '../../mock/mock_data.dart';
import '../content_repository.dart';

/// 목 건강 콘텐츠 구현.
///
/// 작성한 게시글이 세션 동안 유지되도록 시드 데이터를 메모리에 보관한다.
class MockContentRepository implements ContentRepository {
  final List<HealthContent> _contents = [...MockData.healthContents()];
  int _seq = 0;

  @override
  Future<List<HealthContent>> fetchHealthContents() async {
    await Future.delayed(const Duration(milliseconds: 300));
    return List.unmodifiable(_contents);
  }

  @override
  Future<HealthContent> fetchHealthContent(String id) async {
    await Future.delayed(const Duration(milliseconds: 200));
    return _contents.firstWhere(
      (c) => c.id == id,
      orElse: () => throw StateError('콘텐츠를 찾을 수 없어요: $id'),
    );
  }

  @override
  Future<HealthContent> createHealthContent({
    required ContentCategory category,
    required String title,
    required String body,
    required List<String> imagePaths,
  }) async {
    await Future.delayed(const Duration(milliseconds: 300));
    // TODO: 이미지 업로드 연동. 지금은 로컬 경로를 그대로 저장한다.
    final content = HealthContent(
      id: 'local-${DateTime.now().millisecondsSinceEpoch}-${_seq++}',
      category: category,
      title: title,
      body: body,
      imageUrls: List.unmodifiable(imagePaths),
      createdAt: DateTime.now(),
    );
    _contents.insert(0, content);
    return content;
  }
}
