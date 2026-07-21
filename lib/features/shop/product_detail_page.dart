import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../core/format/formatters.dart';
import '../../core/router/routes.dart';
import '../../core/theme/theme.dart';
import '../../core/widgets/widgets.dart';
import '../../data/models/models.dart';
import '../../state/shop_provider.dart';

/// 상품 상세. 성분 분석 결과와 함께 장바구니 담기를 제공한다.
class ProductDetailPage extends ConsumerWidget {
  const ProductDetailPage({super.key, required this.productId});

  final String productId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final product = ref.watch(productDetailProvider(productId));

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        foregroundColor: AppColors.textStrong,
        backgroundColor: AppColors.background,
        title: const Text('상품 상세'),
      ),
      body: product.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (_, _) => const Center(
          child: Text('상품을 불러오지 못했어요.',
              style: TextStyle(color: AppColors.textMuted)),
        ),
        data: (p) => _Detail(product: p),
      ),
    );
  }
}

class _Detail extends ConsumerWidget {
  const _Detail({required this.product});
  final Product product;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      children: [
        Expanded(
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              AspectRatio(
                aspectRatio: 1.2,
                child: product.imageUrl == null
                    ? Container(
                        color: AppColors.border,
                        child: const Icon(Icons.pets,
                            size: 60, color: AppColors.primaryLight),
                      )
                    : CachedNetworkImage(
                        imageUrl: product.imageUrl!,
                        fit: BoxFit.cover,
                        errorWidget: (_, _, _) => Container(
                          color: AppColors.border,
                          child: const Icon(Icons.pets,
                              size: 60, color: AppColors.primaryLight),
                        ),
                      ),
              ),
              Padding(
                padding: const EdgeInsets.all(AppSpacing.xl),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(product.brand,
                        style: const TextStyle(color: AppColors.textMuted)),
                    const SizedBox(height: 4),
                    Text(product.name,
                        style: Theme.of(context).textTheme.headlineMedium),
                    const SizedBox(height: AppSpacing.sm),
                    Row(
                      children: [
                        const Icon(Icons.star_rounded,
                            color: AppColors.warning, size: 18),
                        const SizedBox(width: 4),
                        Text(product.rating.toStringAsFixed(1),
                            style: const TextStyle(
                                fontWeight: FontWeight.w600)),
                        const SizedBox(width: AppSpacing.md),
                        if (product.matchScore != null)
                          AppBadge(
                            label: '맞춤 ${product.matchScore}점',
                            color: AppBadgeColor.blue,
                            icon: Icons.verified,
                          ),
                      ],
                    ),
                    const SizedBox(height: AppSpacing.md),
                    Text(Formatters.won(product.price),
                        style: const TextStyle(
                            fontSize: 24, fontWeight: FontWeight.w800)),
                    if (product.tags.isNotEmpty) ...[
                      const SizedBox(height: AppSpacing.md),
                      Wrap(
                        spacing: AppSpacing.sm,
                        runSpacing: AppSpacing.sm,
                        children: [
                          for (final t in product.tags)
                            AppBadge(label: t, color: AppBadgeColor.gray),
                        ],
                      ),
                    ],
                    if (product.description.isNotEmpty) ...[
                      const SizedBox(height: AppSpacing.lg),
                      Text(product.description,
                          style: Theme.of(context).textTheme.bodyLarge),
                    ],
                    if (product.ingredients.isNotEmpty) ...[
                      const SizedBox(height: AppSpacing.xxl),
                      Text('성분 분석',
                          style: Theme.of(context).textTheme.titleLarge),
                      const SizedBox(height: AppSpacing.md),
                      for (final ing in product.ingredients)
                        _IngredientRow(ingredient: ing),
                    ],
                  ],
                ),
              ),
            ],
          ),
        ),
        _BuyBar(product: product),
      ],
    );
  }
}

class _IngredientRow extends StatelessWidget {
  const _IngredientRow({required this.ingredient});
  final Ingredient ingredient;

  @override
  Widget build(BuildContext context) {
    final good = ingredient.isGood;
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.sm),
      child: Row(
        children: [
          Icon(
            good ? Icons.check_circle : Icons.error_outline,
            color: good ? AppColors.success : AppColors.warning,
            size: 20,
          ),
          const SizedBox(width: AppSpacing.md),
          Text(ingredient.name,
              style: const TextStyle(
                  fontWeight: FontWeight.w600, color: AppColors.textStrong)),
          if (ingredient.note != null) ...[
            const SizedBox(width: AppSpacing.sm),
            Expanded(
              child: Text(ingredient.note!,
                  style: const TextStyle(
                      fontSize: 12, color: AppColors.textMuted)),
            ),
          ],
        ],
      ),
    );
  }
}

class _BuyBar extends ConsumerWidget {
  const _BuyBar({required this.product});
  final Product product;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      padding: const EdgeInsets.fromLTRB(
          AppSpacing.xl, AppSpacing.md, AppSpacing.xl, AppSpacing.md),
      decoration: const BoxDecoration(
        color: AppColors.surface,
        boxShadow: [
          BoxShadow(
            color: Color(0x14000000),
            blurRadius: 16,
            offset: Offset(0, -4),
          ),
        ],
      ),
      child: SafeArea(
        top: false,
        child: Row(
          children: [
            Expanded(
              child: PrimaryButton(
                label: '장바구니 담기',
                variant: AppButtonVariant.secondary,
                icon: Icons.add_shopping_cart,
                onPressed: () {
                  ref.read(cartProvider.notifier).add(product);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('장바구니에 담았어요.')),
                  );
                },
              ),
            ),
            const SizedBox(width: AppSpacing.md),
            Expanded(
              child: PrimaryButton(
                label: '바로 구매',
                onPressed: () {
                  ref.read(cartProvider.notifier).add(product);
                  context.push(Routes.cart);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
