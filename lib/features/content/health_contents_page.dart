import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../core/router/routes.dart';
import '../../core/theme/theme.dart';
import '../../core/widgets/widgets.dart';
import '../../data/models/models.dart';
import '../../state/content_provider.dart';
import 'widgets/category_badge.dart';
import 'widgets/content_image.dart';

/// 건강 콘텐츠 전체보기. 목록 + 우측 하단 작성(+) 버튼.
class HealthContentsPage extends ConsumerWidget {
  const HealthContentsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final contents = ref.watch(contentProvider);

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        foregroundColor: AppColors.textStrong,
        backgroundColor: AppColors.background,
        title: const Text('건강 콘텐츠'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.push(Routes.contentCompose),
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
        child: const Icon(Icons.add),
      ),
      body: contents.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (_, _) => const Center(
          child: Text(
            '콘텐츠를 불러오지 못했어요.',
            style: TextStyle(color: AppColors.textMuted),
          ),
        ),
        data: (items) {
          if (items.isEmpty) return const _EmptyContents();
          return ListView.separated(
            padding: const EdgeInsets.fromLTRB(
              AppSpacing.xl,
              AppSpacing.xl,
              AppSpacing.xl,
              AppSpacing.section + 56,
            ),
            itemCount: items.length,
            separatorBuilder: (_, _) => const SizedBox(height: AppSpacing.md),
            itemBuilder: (_, i) => ContentListCard(content: items[i]),
          );
        },
      ),
    );
  }
}

/// 전체보기 목록의 콘텐츠 카드.
class ContentListCard extends StatelessWidget {
  const ContentListCard({super.key, required this.content});

  final HealthContent content;

  @override
  Widget build(BuildContext context) {
    final images = content.imageUrls;
    return ScaleTap(
      onTap: () => context.push(Routes.contentDetail(content.id)),
      child: AppCard(
        padding: const EdgeInsets.all(AppSpacing.lg),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppBadge(
              label: content.category.label,
              color: content.category.badgeColor,
            ),
            const SizedBox(height: AppSpacing.md),
            Text(
              content.title,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w800),
            ),
            const SizedBox(height: AppSpacing.xs),
            Text(
              content.body,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                color: AppColors.textBody,
                fontSize: 14,
                height: 1.5,
              ),
            ),
            if (images.isNotEmpty) ...[
              const SizedBox(height: AppSpacing.md),
              SizedBox(
                height: 96,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: images.length,
                  separatorBuilder: (_, _) =>
                      const SizedBox(width: AppSpacing.sm),
                  itemBuilder: (_, i) => ClipRRect(
                    borderRadius: BorderRadius.circular(AppRadius.md),
                    child: SizedBox(
                      width: 96,
                      height: 96,
                      child: ContentImage(source: images[i]),
                    ),
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class _EmptyContents extends StatelessWidget {
  const _EmptyContents();

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Padding(
        padding: EdgeInsets.all(AppSpacing.xxl),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.article_outlined,
              size: 56,
              color: AppColors.primaryLight,
            ),
            SizedBox(height: AppSpacing.lg),
            Text(
              '아직 콘텐츠가 없어요',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
            ),
            SizedBox(height: AppSpacing.sm),
            Text(
              '오른쪽 아래 + 버튼으로 첫 글을 작성해 보세요.',
              style: TextStyle(color: AppColors.textMuted),
            ),
          ],
        ),
      ),
    );
  }
}
