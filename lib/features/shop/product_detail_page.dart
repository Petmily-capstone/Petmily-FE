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
import 'widgets/wishlist_button.dart';

/// 상품 상세. 성분 분석 · 적합 대상 · 리뷰를 탭으로 제공한다.
class ProductDetailPage extends ConsumerWidget {
  const ProductDetailPage({super.key, required this.productId});

  final String productId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final product = ref.watch(productDetailProvider(productId));

    return Scaffold(
      backgroundColor: AppColors.background,
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
    return DefaultTabController(
      length: 3,
      child: Column(
        children: [
          Expanded(
            child: NestedScrollView(
              headerSliverBuilder: (_, _) => [
                SliverToBoxAdapter(child: _ImageHeader(product: product)),
                SliverToBoxAdapter(child: _InfoCard(product: product)),
                const SliverToBoxAdapter(child: _Tabs()),
              ],
              body: TabBarView(
                children: [
                  _IngredientTab(product: product),
                  _SuitableTab(product: product),
                  _ReviewTab(product: product),
                ],
              ),
            ),
          ),
          _BuyBar(product: product),
        ],
      ),
    );
  }
}

class _ImageHeader extends StatelessWidget {
  const _ImageHeader({required this.product});
  final Product product;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SizedBox(
          height: 280,
          width: double.infinity,
          child: product.imageUrl == null
              ? Container(
                  color: AppColors.border,
                  child: const Icon(Icons.pets,
                      size: 60, color: AppColors.primaryLight))
              : CachedNetworkImage(
                  imageUrl: product.imageUrl!,
                  fit: BoxFit.cover,
                  errorWidget: (_, _, _) => Container(
                      color: AppColors.border,
                      child: const Icon(Icons.pets,
                          size: 60, color: AppColors.primaryLight)),
                ),
        ),
        Positioned(
          top: MediaQuery.of(context).padding.top + AppSpacing.sm,
          left: AppSpacing.md,
          child: _CircleButton(
            icon: Icons.arrow_back_ios_new,
            onTap: () => context.pop(),
          ),
        ),
        Positioned(
          top: MediaQuery.of(context).padding.top + AppSpacing.sm,
          right: AppSpacing.md,
          child: WishlistButton(productId: product.id, size: 24),
        ),
        if (product.certified)
          const Positioned(
            top: 0,
            right: AppSpacing.xl,
            child: _CertifiedBadge(),
          ),
      ],
    );
  }
}

class _InfoCard extends StatelessWidget {
  const _InfoCard({required this.product});
  final Product product;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(AppSpacing.xl),
      padding: const EdgeInsets.all(AppSpacing.xl),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppRadius.xl),
        boxShadow: AppShadows.card,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(product.brand,
                  style: const TextStyle(color: AppColors.textMuted)),
              const Spacer(),
              if (product.matchScore != null)
                AppBadge(
                    label: '펫밀리 ${product.matchScore}점',
                    color: AppBadgeColor.blue),
            ],
          ),
          const SizedBox(height: AppSpacing.sm),
          Text(product.name,
              style: Theme.of(context).textTheme.headlineMedium),
          const SizedBox(height: AppSpacing.md),
          Text(Formatters.won(product.price),
              style: const TextStyle(
                  fontSize: 24, fontWeight: FontWeight.w800)),
          const SizedBox(height: AppSpacing.md),
          Row(
            children: [
              _Stars(rating: product.rating),
              const SizedBox(width: AppSpacing.sm),
              Text(product.rating.toStringAsFixed(1),
                  style: const TextStyle(fontWeight: FontWeight.w700)),
              const SizedBox(width: AppSpacing.sm),
              Text('리뷰 ${product.reviewCount}개',
                  style: const TextStyle(
                      color: AppColors.textMuted, fontSize: 13)),
            ],
          ),
        ],
      ),
    );
  }
}

class _Tabs extends StatelessWidget {
  const _Tabs();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.background,
      child: const TabBar(
        labelColor: AppColors.primary,
        unselectedLabelColor: AppColors.textMuted,
        indicatorColor: AppColors.primary,
        labelStyle: TextStyle(fontWeight: FontWeight.w700),
        tabs: [
          Tab(text: '성분 분석'),
          Tab(text: '적합 대상'),
          Tab(text: '리뷰'),
        ],
      ),
    );
  }
}

class _IngredientTab extends StatelessWidget {
  const _IngredientTab({required this.product});
  final Product product;

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(AppSpacing.xl),
      children: [
        _IngredientBlock(
          dotColor: AppColors.success,
          title: '좋은 성분',
          ingredients: product.ingredientsOf(IngredientKind.good),
          chipBg: const Color(0xFFDCFCE7),
          chipFg: const Color(0xFF15803D),
          leading: '✓ ',
        ),
        _IngredientBlock(
          dotColor: AppColors.warning,
          title: '주의 성분',
          ingredients: product.ingredientsOf(IngredientKind.caution),
          chipBg: const Color(0xFFFFEDD5),
          chipFg: const Color(0xFFC2410C),
          leading: '⚠ ',
        ),
        _IngredientBlock(
          dotColor: AppColors.primary,
          title: '기능성 성분',
          ingredients: product.ingredientsOf(IngredientKind.functional),
          chipBg: const Color(0xFFDBEAFE),
          chipFg: AppColors.primaryDeep,
          leading: '💊 ',
          showNote: true,
        ),
        if (product.description.isNotEmpty) ...[
          const SizedBox(height: AppSpacing.lg),
          Text('상품 설명', style: Theme.of(context).textTheme.titleMedium),
          const SizedBox(height: AppSpacing.sm),
          Text(product.description,
              style: Theme.of(context).textTheme.bodyMedium),
        ],
      ],
    );
  }
}

class _IngredientBlock extends StatelessWidget {
  const _IngredientBlock({
    required this.dotColor,
    required this.title,
    required this.ingredients,
    required this.chipBg,
    required this.chipFg,
    required this.leading,
    this.showNote = false,
  });

  final Color dotColor;
  final String title;
  final List<Ingredient> ingredients;
  final Color chipBg;
  final Color chipFg;
  final String leading;
  final bool showNote;

  @override
  Widget build(BuildContext context) {
    if (ingredients.isEmpty) return const SizedBox.shrink();
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.lg),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 8,
                height: 8,
                decoration: BoxDecoration(color: dotColor, shape: BoxShape.circle),
              ),
              const SizedBox(width: AppSpacing.sm),
              Text(title,
                  style: const TextStyle(
                      fontWeight: FontWeight.w700, fontSize: 15)),
            ],
          ),
          const SizedBox(height: AppSpacing.sm),
          Wrap(
            spacing: AppSpacing.sm,
            runSpacing: AppSpacing.sm,
            children: [
              for (final ing in ingredients)
                Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: AppSpacing.md, vertical: 6),
                  decoration: BoxDecoration(
                    color: chipBg,
                    borderRadius: BorderRadius.circular(AppRadius.pill),
                  ),
                  child: Text(
                    showNote && ing.note != null
                        ? '$leading${ing.name}(${ing.note})'
                        : '$leading${ing.name}',
                    style: TextStyle(
                        color: chipFg,
                        fontSize: 13,
                        fontWeight: FontWeight.w600),
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }
}

class _SuitableTab extends StatelessWidget {
  const _SuitableTab({required this.product});
  final Product product;

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(AppSpacing.xl),
      children: [
        Row(
          children: const [
            Icon(Icons.check_box, color: AppColors.success, size: 20),
            SizedBox(width: AppSpacing.sm),
            Text('적합 대상',
                style: TextStyle(fontWeight: FontWeight.w700, fontSize: 15)),
          ],
        ),
        const SizedBox(height: AppSpacing.md),
        Wrap(
          spacing: AppSpacing.sm,
          runSpacing: AppSpacing.sm,
          children: [
            for (final s in product.suitableFor)
              Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: AppSpacing.md, vertical: 8),
                decoration: BoxDecoration(
                  color: const Color(0xFFDCFCE7),
                  borderRadius: BorderRadius.circular(AppRadius.pill),
                ),
                child: Text(s,
                    style: const TextStyle(
                        color: Color(0xFF15803D),
                        fontSize: 13,
                        fontWeight: FontWeight.w600)),
              ),
          ],
        ),
      ],
    );
  }
}

class _ReviewTab extends StatelessWidget {
  const _ReviewTab({required this.product});
  final Product product;

  @override
  Widget build(BuildContext context) {
    if (product.reviews.isEmpty) {
      return const Center(
        child: Text('아직 리뷰가 없어요.',
            style: TextStyle(color: AppColors.textMuted)),
      );
    }
    return ListView.separated(
      padding: const EdgeInsets.all(AppSpacing.xl),
      itemCount: product.reviews.length,
      separatorBuilder: (_, _) => const SizedBox(height: AppSpacing.md),
      itemBuilder: (_, i) => _ReviewCard(review: product.reviews[i]),
    );
  }
}

class _ReviewCard extends StatelessWidget {
  const _ReviewCard({required this.review});
  final Review review;

  @override
  Widget build(BuildContext context) {
    return AppCard(
      padding: const EdgeInsets.all(AppSpacing.lg),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(review.author,
                  style: const TextStyle(fontWeight: FontWeight.w700)),
              const Spacer(),
              Text(Formatters.dateDot(review.createdAt),
                  style: const TextStyle(
                      color: AppColors.textMuted, fontSize: 12)),
            ],
          ),
          const SizedBox(height: 4),
          _Stars(rating: review.rating, size: 14),
          const SizedBox(height: AppSpacing.sm),
          Text(review.text, style: Theme.of(context).textTheme.bodyMedium),
        ],
      ),
    );
  }
}

class _Stars extends StatelessWidget {
  const _Stars({required this.rating, this.size = 18});
  final double rating;
  final double size;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        for (var i = 1; i <= 5; i++)
          Icon(
            i <= rating.round() ? Icons.star_rounded : Icons.star_outline_rounded,
            size: size,
            color: AppColors.warning,
          ),
      ],
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
              color: Color(0x14000000), blurRadius: 16, offset: Offset(0, -4)),
        ],
      ),
      child: SafeArea(
        top: false,
        child: PrimaryButton(
          label: '구매하기',
          icon: Icons.shopping_bag_outlined,
          onPressed: () {
            ref.read(cartProvider.notifier).add(product);
            context.push(Routes.cart);
          },
        ),
      ),
    );
  }
}

class _CircleButton extends StatelessWidget {
  const _CircleButton({required this.icon, required this.onTap});
  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return ScaleTap(
      onTap: onTap,
      child: Container(
        width: 38,
        height: 38,
        decoration: const BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
          boxShadow: AppShadows.soft,
        ),
        child: Icon(icon, size: 18, color: AppColors.textStrong),
      ),
    );
  }
}

class _CertifiedBadge extends StatelessWidget {
  const _CertifiedBadge();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.md, vertical: AppSpacing.sm),
      decoration: const BoxDecoration(
        color: AppColors.danger,
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(AppRadius.md)),
      ),
      child: const Text('인증\n판매점',
          textAlign: TextAlign.center,
          style: TextStyle(
              color: Colors.white,
              fontSize: 11,
              fontWeight: FontWeight.w800,
              height: 1.1)),
    );
  }
}
