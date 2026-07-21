import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../core/router/routes.dart';
import '../../core/theme/theme.dart';
import '../../core/widgets/widgets.dart';
import '../../data/models/models.dart';
import '../../state/shop_provider.dart';

/// 쇼핑 화면. 종/검색 필터 + 상품 그리드 + 장바구니 진입.
class ShopPage extends ConsumerWidget {
  const ShopPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final products = ref.watch(productListProvider);
    final filter = ref.watch(shopFilterProvider);
    final cartCount = ref.watch(cartCountProvider);

    return Scaffold(
      body: Column(
        children: [
          GradientHeader(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Text('맞춤 펫푸드',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 22,
                            fontWeight: FontWeight.w800)),
                    const Spacer(),
                    _CartButton(
                      count: cartCount,
                      onTap: () => context.push(Routes.cart),
                    ),
                  ],
                ),
                const SizedBox(height: AppSpacing.lg),
                _SearchField(
                  onChanged: (v) =>
                      ref.read(shopFilterProvider.notifier).setQuery(v),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(
                AppSpacing.xl, AppSpacing.lg, AppSpacing.xl, AppSpacing.sm),
            child: Row(
              children: [
                _FilterChip(
                  label: '전체',
                  selected: filter.species == null,
                  onTap: () =>
                      ref.read(shopFilterProvider.notifier).setSpecies(null),
                ),
                const SizedBox(width: AppSpacing.sm),
                for (final s in PetSpecies.values) ...[
                  _FilterChip(
                    label: s.label,
                    selected: filter.species == s,
                    onTap: () =>
                        ref.read(shopFilterProvider.notifier).setSpecies(s),
                  ),
                  const SizedBox(width: AppSpacing.sm),
                ],
              ],
            ),
          ),
          Expanded(
            child: products.when(
              loading: () =>
                  const Center(child: CircularProgressIndicator()),
              error: (_, _) => const Center(
                child: Text('상품을 불러오지 못했어요.',
                    style: TextStyle(color: AppColors.textMuted)),
              ),
              data: (items) => items.isEmpty
                  ? const Center(
                      child: Text('검색 결과가 없어요.',
                          style: TextStyle(color: AppColors.textMuted)),
                    )
                  : GridView.builder(
                      padding: const EdgeInsets.all(AppSpacing.xl),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: AppSpacing.lg,
                        crossAxisSpacing: AppSpacing.lg,
                        childAspectRatio: 0.62,
                      ),
                      itemCount: items.length,
                      itemBuilder: (_, i) {
                        final p = items[i];
                        return ProductCard(
                          name: p.name,
                          brand: p.brand,
                          price: p.price,
                          imageUrl: p.imageUrl,
                          tag: p.matchScore != null
                              ? '맞춤 ${p.matchScore}점'
                              : null,
                          onTap: () =>
                              context.push(Routes.productDetail(p.id)),
                        );
                      },
                    ),
            ),
          ),
        ],
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
            child: const Icon(Icons.shopping_cart_outlined,
                color: Colors.white, size: 22),
          ),
          if (count > 0)
            Positioned(
              right: -4,
              top: -4,
              child: Container(
                padding: const EdgeInsets.all(5),
                decoration: const BoxDecoration(
                  color: AppColors.danger,
                  shape: BoxShape.circle,
                ),
                constraints:
                    const BoxConstraints(minWidth: 18, minHeight: 18),
                child: Text(
                  '$count',
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 10,
                      fontWeight: FontWeight.w700),
                ),
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
        hintText: '사료·브랜드 검색',
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

class _FilterChip extends StatelessWidget {
  const _FilterChip({
    required this.label,
    required this.selected,
    required this.onTap,
  });

  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return ScaleTap(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.lg, vertical: AppSpacing.sm),
        decoration: BoxDecoration(
          color: selected ? AppColors.primary : AppColors.surface,
          borderRadius: BorderRadius.circular(AppRadius.pill),
          border: Border.all(
            color: selected ? AppColors.primary : AppColors.border,
          ),
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
    );
  }
}
