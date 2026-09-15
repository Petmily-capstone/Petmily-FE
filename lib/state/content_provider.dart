import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/models/models.dart';
import 'repository_providers.dart';

/// 건강 콘텐츠(게시글) 목록 상태.
///
/// 작성 시 [create]로 서버(목)에 저장하고 로컬 상태를 갱신한다.
class ContentNotifier extends AsyncNotifier<List<HealthContent>> {
  @override
  Future<List<HealthContent>> build() {
    return ref.watch(contentRepositoryProvider).fetchHealthContents();
  }

  /// 새 게시글 작성. 성공 시 목록 맨 앞에 추가한다.
  Future<void> create({
    required ContentCategory category,
    required String title,
    required String body,
    required List<String> imagePaths,
  }) async {
    final created =
        await ref.read(contentRepositoryProvider).createHealthContent(
              category: category,
              title: title,
              body: body,
              imagePaths: imagePaths,
            );
    final current = state.asData?.value ?? const [];
    state = AsyncData([created, ...current]);
  }
}

final contentProvider =
    AsyncNotifierProvider<ContentNotifier, List<HealthContent>>(
        ContentNotifier.new);

/// 단일 콘텐츠 상세.
final contentDetailProvider =
    FutureProvider.family<HealthContent, String>((ref, id) async {
  return ref.watch(contentRepositoryProvider).fetchHealthContent(id);
});
