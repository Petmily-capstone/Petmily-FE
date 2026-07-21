import 'package:flutter/material.dart';

import '../theme/theme.dart';
import 'scale_tap.dart';

/// 흰 배경 · 큰 라운드 · 부드러운 그림자의 공통 카드.
///
/// [onTap]을 주면 [ScaleTap]으로 감싸 눌림 피드백을 준다.
class AppCard extends StatelessWidget {
  const AppCard({
    super.key,
    required this.child,
    this.onTap,
    this.padding = const EdgeInsets.all(AppSpacing.lg),
    this.radius = AppRadius.xl,
    this.color = AppColors.surface,
    this.shadow = true,
  });

  final Widget child;
  final VoidCallback? onTap;
  final EdgeInsetsGeometry padding;
  final double radius;
  final Color color;
  final bool shadow;

  @override
  Widget build(BuildContext context) {
    final card = Container(
      padding: padding,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(radius),
        boxShadow: shadow ? AppShadows.card : null,
      ),
      child: child,
    );

    if (onTap == null) return card;
    return ScaleTap(onTap: onTap, child: card);
  }
}
