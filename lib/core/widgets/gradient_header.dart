import 'package:flutter/material.dart';

import '../theme/theme.dart';

/// primary-deep → primary 세로 그라데이션 헤더.
///
/// 홈·마이페이지 등 여러 화면 상단에 공통으로 쓰는 패턴.
class GradientHeader extends StatelessWidget {
  const GradientHeader({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.fromLTRB(
      AppSpacing.xl,
      AppSpacing.lg,
      AppSpacing.xl,
      AppSpacing.xxl,
    ),
    this.borderRadius = const BorderRadius.vertical(
      bottom: Radius.circular(AppRadius.xxl),
    ),
  });

  final Widget child;
  final EdgeInsetsGeometry padding;
  final BorderRadiusGeometry borderRadius;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: padding,
      decoration: BoxDecoration(
        gradient: AppColors.headerGradient,
        borderRadius: borderRadius,
      ),
      child: SafeArea(bottom: false, child: child),
    );
  }
}
