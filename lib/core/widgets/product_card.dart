import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../format/formatters.dart';
import '../theme/theme.dart';
import 'app_badge.dart';
import 'scale_tap.dart';

/// 쇼핑 상품 카드.
///
/// 데이터 계층과 결합하지 않도록 표시용 원시 값만 받는다(모델은 화면에서 매핑).
class ProductCard extends StatelessWidget {
  const ProductCard({
    super.key,
    required this.name,
    required this.price,
    this.imageUrl,
    this.brand,
    this.tag,
    this.onTap,
  });

  final String name;
  final int price;
  final String? imageUrl;
  final String? brand;

  /// 우상단 배지(예: "맞춤추천").
  final String? tag;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return ScaleTap(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(AppRadius.lg),
          boxShadow: AppShadows.soft,
        ),
        clipBehavior: Clip.antiAlias,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            AspectRatio(
              aspectRatio: 1,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  _image(),
                  if (tag != null)
                    Positioned(
                      top: AppSpacing.sm,
                      left: AppSpacing.sm,
                      child: AppBadge(label: tag!, color: AppBadgeColor.blue),
                    ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(AppSpacing.md),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (brand != null) ...[
                    Text(
                      brand!,
                      style: const TextStyle(
                        fontSize: 12,
                        color: AppColors.textMuted,
                      ),
                    ),
                    const SizedBox(height: 2),
                  ],
                  Text(
                    name,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: AppColors.textStrong,
                    ),
                  ),
                  const SizedBox(height: AppSpacing.sm),
                  Text(
                    Formatters.won(price),
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w800,
                      color: AppColors.textStrong,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _image() {
    if (imageUrl == null || imageUrl!.isEmpty) {
      return Container(
        color: AppColors.background,
        child: const Icon(Icons.pets, color: AppColors.primaryLight, size: 40),
      );
    }
    return CachedNetworkImage(
      imageUrl: imageUrl!,
      fit: BoxFit.cover,
      placeholder: (_, _) => Container(color: AppColors.background),
      errorWidget: (_, _, _) => Container(
        color: AppColors.background,
        child: const Icon(Icons.pets, color: AppColors.primaryLight, size: 40),
      ),
    );
  }
}
