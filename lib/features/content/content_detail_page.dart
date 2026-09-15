import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/theme/theme.dart';
import '../../core/widgets/widgets.dart';
import '../../data/models/models.dart';
import '../../state/content_provider.dart';
import 'widgets/category_badge.dart';
import 'widgets/content_image.dart';

/// 건강 콘텐츠 상세 조회.
class ContentDetailPage extends ConsumerWidget {
  const ContentDetailPage({super.key, required this.contentId});

  final String contentId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final content = ref.watch(contentDetailProvider(contentId));

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        foregroundColor: AppColors.textStrong,
        backgroundColor: AppColors.background,
        title: const Text('건강 콘텐츠'),
      ),
      body: content.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (_, _) => const Center(
          child: Text(
            '콘텐츠를 불러오지 못했어요.',
            style: TextStyle(color: AppColors.textMuted),
          ),
        ),
        data: (c) => _ContentBody(content: c),
      ),
    );
  }
}

class _ContentBody extends StatelessWidget {
  const _ContentBody({required this.content});

  final HealthContent content;

  @override
  Widget build(BuildContext context) {
    final images = content.imageUrls;
    final date = content.createdAt;
    return ListView(
      padding: const EdgeInsets.all(AppSpacing.xl),
      children: [
        AppBadge(
          label: content.category.label,
          color: content.category.badgeColor,
        ),
        const SizedBox(height: AppSpacing.md),
        Text(
          content.title,
          style: const TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.w800,
            height: 1.3,
          ),
        ),
        if (date != null) ...[
          const SizedBox(height: AppSpacing.sm),
          Text(
            '${date.year}.${date.month}.${date.day}',
            style: const TextStyle(color: AppColors.textMuted, fontSize: 13),
          ),
        ],
        if (images.isNotEmpty) ...[
          const SizedBox(height: AppSpacing.xl),
          for (final source in images) ...[
            ClipRRect(
              borderRadius: BorderRadius.circular(AppRadius.lg),
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxHeight: 320),
                child: SizedBox(
                  width: double.infinity,
                  child: ContentImage(source: source, fit: BoxFit.cover),
                ),
              ),
            ),
            const SizedBox(height: AppSpacing.md),
          ],
        ],
        const SizedBox(height: AppSpacing.lg),
        Text(
          content.body,
          style: const TextStyle(
            fontSize: 15,
            height: 1.7,
            color: AppColors.textBody,
          ),
        ),
      ],
    );
  }
}
