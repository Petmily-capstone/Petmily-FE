import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../core/format/formatters.dart';
import '../../core/router/routes.dart';
import '../../core/theme/theme.dart';
import '../../core/widgets/widgets.dart';
import '../../data/models/models.dart';
import '../../state/pet_provider.dart';
import '../../state/shop_provider.dart';
import 'widgets/wishlist_button.dart';

/// 쇼핑 화면. 성분 분석 기반 맞춤 푸드 가이드.
class ShopPage extends ConsumerWidget {
  const ShopPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pet = ref.watch(activePetProvider);
    final products = ref.watch(productListProvider);
    final category = ref.watch(shopCategoryProvider);
    final cartCount = ref.watch(cartCountProvider);

    final speciesEmoji = pet?.species == PetSpecies.cat ? '🐱' : '🐶';

    return Scaffold(
      body: Column(
        children: [
          GradientHeader(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('성분 분석 쇼핑',
                              style: TextStyle(
                                  color: Colors.white70, fontSize: 13)),
                          const SizedBox(height: 2),
                          Text('$speciesEmoji ${pet?.name ?? '우리 아이'}의 푸드 가이드',
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w800)),
                        ],
                      ),
                    ),
                    _CartButton(
                      count: cartCount,
                      onTap: () => context.push(Routes.cart),
                    ),
                  ],
                ),
                const SizedBox(height: AppSpacing.lg),
                _SearchField(
                  onChanged: (v) =>
                      ref.read(shopQueryProvider.notifier).set(v),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.only(bottom: AppSpacing.xxl),
              children: [
                const _RecommendSection(),
                Padding(
                  padding: const EdgeInsets.fromLTRB(AppSpacing.xl,
                      AppSpacing.sm, AppSpacing.xl, AppSpacing.sm),
                  child: _CategoryChips(
                    selected: category,
                    onSelect: (c) =>
                        ref.read(shopCategoryProvider.notifier).select(c),
                  ),
                ),
                products.when(
                  loading: () => const Padding(
                    padding: EdgeInsets.all(AppSpacing.xxxl),
                    child: Center(child: CircularProgressIndicator()),
                  ),
                  error: (_, _) => const Padding(
                    padding: EdgeInsets.all(AppSpacing.xxxl),
                    child: Center(
                        child: Text('상품을 불러오지 못했어요.',
                            style: TextStyle(color: AppColors.textMuted))),
                  ),
                  data: (items) => _ProductGrid(
                    items: items,
                    speciesLabel: pet?.species.label ?? '전체',
                    speciesEmoji: speciesEmoji,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _RecommendSection extends ConsumerWidget {
  const _RecommendSection();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final recommended = ref.watch(recommendedProductsProvider);
    return recommended.maybeWhen(
      data: (items) {
        if (items.isEmpty) return const SizedBox.shrink();
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.fromLTRB(
                  AppSpacing.xl, AppSpacing.lg, AppSpacing.xl, AppSpacing.md),
              child: Row(
                children: [
                  Text('AI 추천',
                      style: TextStyle(
                          fontSize: 17, fontWeight: FontWeight.w800)),
                  SizedBox(width: AppSpacing.sm),
                  Text('좋은 성분 TOP 5',
                      style: TextStyle(
                          color: AppColors.primary,
                          fontWeight: FontWeight.w700,
                          fontSize: 13)),
                ],
              ),
            ),
            SizedBox(
              height: 220,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: AppSpacing.xl),
                itemCount: items.length,
                separatorBuilder: (_, _) =>
                    const SizedBox(width: AppSpacing.md),
                itemBuilder: (_, i) => _RecommendCard(product: items[i]),
              ),
            ),
          ],
        );
      },
      orElse: () => const SizedBox.shrink(),
    );
  }
}

class _RecommendCard extends StatelessWidget {
  const _RecommendCard({required this.product});
  final Product product;

  @override
  Widget build(BuildContext context) {
    return ScaleTap(
      onTap: () => context.push(Routes.productDetail(product.id)),
      child: SizedBox(
        width: 150,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(AppRadius.lg),
                  child: _ProductImage(url: product.imageUrl, height: 130),
                ),
                const Positioned(
                  top: AppSpacing.sm,
                  left: AppSpacing.sm,
                  child: AppBadge(label: 'AI추천', color: AppBadgeColor.blue),
                ),
                Positioned(
                  top: AppSpacing.xs,
                  right: AppSpacing.xs,
                  child: WishlistButton(productId: product.id),
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.sm),
            Text(product.brand,
                style: const TextStyle(
                    fontSize: 11, color: AppColors.textMuted)),
            Text(product.name,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                    fontSize: 13, fontWeight: FontWeight.w600)),
            const SizedBox(height: 2),
            Text(Formatters.won(product.price),
                style: const TextStyle(
                    color: AppColors.primary,
                    fontWeight: FontWeight.w800)),
          ],
        ),
      ),
    );
  }
}

class _CategoryChips extends StatelessWidget {
  const _CategoryChips({required this.selected, required this.onSelect});

  final ProductCategory? selected;
  final ValueChanged<ProductCategory?> onSelect;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          _Chip(
            label: '전체',
            selected: selected == null,
            onTap: () => onSelect(null),
          ),
          for (final c in ProductCategory.values)
            _Chip(
              label: '${c.emoji} ${c.label}',
              selected: selected == c,
              onTap: () => onSelect(c),
            ),
        ],
      ),
    );
  }
}

class _Chip extends StatelessWidget {
  const _Chip({
    required this.label,
    required this.selected,
    required this.onTap,
  });

  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: AppSpacing.sm),
      child: ScaleTap(
        onTap: onTap,
        child: Container(
          alignment: Alignment.center,
          padding:
              const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
          decoration: BoxDecoration(
            color: selected ? AppColors.primary : AppColors.surface,
            borderRadius: BorderRadius.circular(AppRadius.pill),
            border: Border.all(
                color: selected ? AppColors.primary : AppColors.border),
          ),
          child: Text(
            label,
            style: TextStyle(
              color: selected ? Colors.white : AppColors.textBody,
              fontWeight: FontWeight.w600,
              fontSize: 13,
            ),
          ),
        ),
      ),
    );
  }
}

class _ProductGrid extends StatelessWidget {
  const _ProductGrid({
    required this.items,
    required this.speciesLabel,
    required this.speciesEmoji,
  });

  final List<Product> items;
  final String speciesLabel;
  final String speciesEmoji;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(
              AppSpacing.xl, AppSpacing.sm, AppSpacing.xl, AppSpacing.md),
          child: Text('$speciesEmoji $speciesLabel 제품 ${items.length}개',
              style: const TextStyle(
                  fontSize: 13, color: AppColors.textBody)),
        ),
        if (items.isEmpty)
          const Padding(
            padding: EdgeInsets.all(AppSpacing.xxxl),
            child: Center(
                child: Text('검색 결과가 없어요.',
                    style: TextStyle(color: AppColors.textMuted))),
          )
        else
          GridView.builder(
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.xl),
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: AppSpacing.lg,
              crossAxisSpacing: AppSpacing.lg,
              // 콘텐츠 높이를 고정해 카드 오버플로를 방지.
              mainAxisExtent: 300,
            ),
            itemCount: items.length,
            itemBuilder: (_, i) => _ShopProductCard(product: items[i]),
          ),
      ],
    );
  }
}

class _ShopProductCard extends StatelessWidget {
  const _ShopProductCard({required this.product});
  final Product product;

  @override
  Widget build(BuildContext context) {
    return ScaleTap(
      onTap: () => context.push(Routes.productDetail(product.id)),
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
            Stack(
              children: [
                _ProductImage(url: product.imageUrl, height: 140),
                Positioned(
                  top: AppSpacing.xs,
                  right: AppSpacing.xs,
                  child: WishlistButton(productId: product.id),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(AppSpacing.md),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppBadge(
                      label: '${product.category.emoji} ${product.category.label}',
                      color: AppBadgeColor.red),
                  const SizedBox(height: 6),
                  Text(product.brand,
                      style: const TextStyle(
                          fontSize: 11, color: AppColors.textMuted)),
                  Text(product.name,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                          fontSize: 13, fontWeight: FontWeight.w600)),
                  if (product.goodSummary.isNotEmpty) ...[
                    const SizedBox(height: AppSpacing.sm),
                    _GoodChip(text: product.goodSummary),
                  ],
                  const SizedBox(height: AppSpacing.sm),
                  Text(Formatters.won(product.price),
                      style: const TextStyle(
                          color: AppColors.primary,
                          fontSize: 15,
                          fontWeight: FontWeight.w800)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _GoodChip extends StatelessWidget {
  const _GoodChip({required this.text});
  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.sm, vertical: 4),
      decoration: BoxDecoration(
        color: const Color(0xFFDCFCE7),
        borderRadius: BorderRadius.circular(AppRadius.sm),
      ),
      child: Row(
        children: [
          const Icon(Icons.check, size: 12, color: Color(0xFF15803D)),
          const SizedBox(width: 4),
          Expanded(
            child: Text(text,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                    fontSize: 11, color: Color(0xFF15803D))),
          ),
        ],
      ),
    );
  }
}

class _ProductImage extends StatelessWidget {
  const _ProductImage({required this.url, required this.height});
  final String? url;
  final double height;

  @override
  Widget build(BuildContext context) {
    if (url == null || url!.isEmpty) {
      return Container(
        height: height,
        color: AppColors.background,
        child: const Icon(Icons.pets, color: AppColors.primaryLight, size: 36),
      );
    }
    return CachedNetworkImage(
      imageUrl: url!,
      height: height,
      fit: BoxFit.cover,
      placeholder: (_, _) =>
          Container(height: height, color: AppColors.background),
      errorWidget: (_, _, _) => Container(
        height: height,
        color: AppColors.background,
        child: const Icon(Icons.pets, color: AppColors.primaryLight, size: 36),
      ),
    );
  }
}

class _CartButton extends StatelessWidget {
  const _CartButton({required this.count, required this.onTap});
  final int count;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return ScaleTap(
      onTap: onTap,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            width: 42,
            height: 42,
            decoration: BoxDecoration(
              color: Colors.white24,
              borderRadius: BorderRadius.circular(AppRadius.md),
            ),
            child: const Icon(Icons.shopping_bag_outlined,
                color: Colors.white, size: 22),
          ),
          if (count > 0)
            Positioned(
              right: -4,
              top: -4,
              child: Container(
                padding: const EdgeInsets.all(5),
                decoration: const BoxDecoration(
                    color: AppColors.danger, shape: BoxShape.circle),
                constraints:
                    const BoxConstraints(minWidth: 18, minHeight: 18),
                child: Text('$count',
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                        fontWeight: FontWeight.w700)),
              ),
            ),
        ],
      ),
    );
  }
}

class _SearchField extends StatelessWidget {
  const _SearchField({required this.onChanged});
  final ValueChanged<String> onChanged;

  @override
  Widget build(BuildContext context) {
    return TextField(
      onChanged: onChanged,
      textInputAction: TextInputAction.search,
      decoration: InputDecoration(
        hintText: '브랜드, 제품명 검색',
        prefixIcon: const Icon(Icons.search, color: AppColors.textMuted),
        filled: true,
        fillColor: Colors.white,
        contentPadding: EdgeInsets.zero,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppRadius.lg),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}
