import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/theme/theme.dart';
import '../../../core/widgets/widgets.dart';
import '../../../state/shop_provider.dart';

/// 찜(위시리스트) 토글 하트 버튼.
class WishlistButton extends ConsumerWidget {
  const WishlistButton({super.key, required this.productId, this.size = 20});

  final String productId;
  final double size;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final liked = ref.watch(wishlistProvider).contains(productId);
    return ScaleTap(
      onTap: () => ref.read(wishlistProvider.notifier).toggle(productId),
      child: Container(
        padding: const EdgeInsets.all(6),
        decoration: const BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
          boxShadow: AppShadows.soft,
        ),
        child: Icon(
          liked ? Icons.favorite : Icons.favorite_border,
          size: size,
          color: liked ? AppColors.danger : AppColors.textMuted,
        ),
      ),
    );
  }
}
