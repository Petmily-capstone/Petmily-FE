import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/format/formatters.dart';
import '../../core/theme/theme.dart';
import '../../core/widgets/widgets.dart';
import '../../data/models/models.dart';
import '../../state/shop_provider.dart';

/// 장바구니. 수량 조절·삭제·결제(목).
class CartPage extends ConsumerStatefulWidget {
  const CartPage({super.key});

  @override
  ConsumerState<CartPage> createState() => _CartPageState();
}

class _CartPageState extends ConsumerState<CartPage> {
  bool _checkingOut = false;

  Future<void> _checkout() async {
    setState(() => _checkingOut = true);
    // TODO: 결제(PG) 연동. 지금은 목 checkout 후 완료 안내.
    await ref.read(cartProvider.notifier).checkout();
    if (!mounted) return;
    setState(() => _checkingOut = false);
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('주문이 완료되었어요. (결제 연동 예정)')),
    );
  }

  @override
  Widget build(BuildContext context) {
    final items = ref.watch(cartProvider);
    final total = ref.watch(cartTotalProvider);

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        foregroundColor: AppColors.textStrong,
        backgroundColor: AppColors.background,
        title: const Text('장바구니'),
      ),
      body: items.isEmpty
          ? const _EmptyCart()
          : Column(
              children: [
                Expanded(
                  child: ListView.separated(
                    padding: const EdgeInsets.all(AppSpacing.xl),
                    itemCount: items.length,
                    separatorBuilder: (_, _) =>
                        const SizedBox(height: AppSpacing.md),
                    itemBuilder: (_, i) => _CartRow(item: items[i]),
                  ),
                ),
                _CheckoutBar(
                  total: total,
                  loading: _checkingOut,
                  onCheckout: _checkingOut ? null : _checkout,
                ),
              ],
            ),
    );
  }
}

class _CartRow extends ConsumerWidget {
  const _CartRow({required this.item});
  final CartItem item;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cart = ref.read(cartProvider.notifier);
    final p = item.product;
    return AppCard(
      padding: const EdgeInsets.all(AppSpacing.md),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(AppRadius.md),
            child: SizedBox(
              width: 64,
              height: 64,
              child: p.imageUrl == null
                  ? Container(
                      color: AppColors.background,
                      child: const Icon(Icons.pets,
                          color: AppColors.primaryLight),
                    )
                  : CachedNetworkImage(
                      imageUrl: p.imageUrl!,
                      fit: BoxFit.cover,
                      errorWidget: (_, _, _) => Container(
                        color: AppColors.background,
                        child: const Icon(Icons.pets,
                            color: AppColors.primaryLight),
                      ),
                    ),
            ),
          ),
          const SizedBox(width: AppSpacing.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(p.name,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(fontWeight: FontWeight.w600)),
                const SizedBox(height: 2),
                Text(Formatters.won(item.subtotal),
                    style: const TextStyle(
                        fontWeight: FontWeight.w800,
                        color: AppColors.textStrong)),
                const SizedBox(height: AppSpacing.sm),
                _QtyStepper(
                  quantity: item.quantity,
                  onMinus: () =>
                      cart.setQuantity(p.id, item.quantity - 1),
                  onPlus: () =>
                      cart.setQuantity(p.id, item.quantity + 1),
                ),
              ],
            ),
          ),
          IconButton(
            onPressed: () => cart.remove(p.id),
            icon: const Icon(Icons.close, color: AppColors.textMuted),
          ),
        ],
      ),
    );
  }
}

class _QtyStepper extends StatelessWidget {
  const _QtyStepper({
    required this.quantity,
    required this.onMinus,
    required this.onPlus,
  });

  final int quantity;
  final VoidCallback onMinus;
  final VoidCallback onPlus;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.border),
        borderRadius: BorderRadius.circular(AppRadius.pill),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          _StepBtn(icon: Icons.remove, onTap: onMinus),
          SizedBox(
            width: 32,
            child: Text('$quantity',
                textAlign: TextAlign.center,
                style: const TextStyle(fontWeight: FontWeight.w700)),
          ),
          _StepBtn(icon: Icons.add, onTap: onPlus),
        ],
      ),
    );
  }
}

class _StepBtn extends StatelessWidget {
  const _StepBtn({required this.icon, required this.onTap});
  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return ScaleTap(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.sm),
        child: Icon(icon, size: 18, color: AppColors.primary),
      ),
    );
  }
}

class _CheckoutBar extends StatelessWidget {
  const _CheckoutBar({
    required this.total,
    required this.loading,
    required this.onCheckout,
  });

  final int total;
  final bool loading;
  final VoidCallback? onCheckout;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.xl),
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
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('총 결제금액',
                    style: TextStyle(color: AppColors.textBody)),
                Text(Formatters.won(total),
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.w800)),
              ],
            ),
            const SizedBox(height: AppSpacing.md),
            PrimaryButton(
              label: '결제하기',
              loading: loading,
              onPressed: onCheckout,
            ),
          ],
        ),
      ),
    );
  }
}

class _EmptyCart extends StatelessWidget {
  const _EmptyCart();

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.shopping_cart_outlined,
              size: 56, color: AppColors.primaryLight),
          SizedBox(height: AppSpacing.lg),
          Text('장바구니가 비어 있어요',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700)),
        ],
      ),
    );
  }
}
