import 'package:flutter/material.dart';

import '../theme/theme.dart';

/// primary-deep → primary 세로 그라데이션 헤더.
///
/// 진단·쇼핑·마이페이지 등 모든 화면 상단에 **동일한 크기/여백**으로 쓰는 공통 헤더.
/// 개별 화면에서 여백을 재정의하지 말고 이 기본값을 그대로 사용한다.
class GradientHeader extends StatelessWidget {
  const GradientHeader({
    super.key,
    required this.child,
    this.borderRadius = const BorderRadius.vertical(
      bottom: Radius.circular(AppRadius.xxl),
    ),
  });

  /// 전 페이지 공통 헤더 여백.
  static const EdgeInsets headerPadding = EdgeInsets.fromLTRB(
    AppSpacing.page,
    AppSpacing.xl,
    AppSpacing.page,
    AppSpacing.section,
  );

  final Widget child;
  final BorderRadiusGeometry borderRadius;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: headerPadding,
      decoration: BoxDecoration(
        gradient: AppColors.headerGradient,
        borderRadius: borderRadius,
      ),
      child: SafeArea(bottom: false, child: child),
    );
  }
}

/// 헤더 제목/부제 타이포. 모든 페이지가 같은 크기를 쓰도록 여기서만 정의한다.
class HeaderTitle extends StatelessWidget {
  const HeaderTitle({super.key, required this.title, this.subtitle});

  /// 헤더 제목 크기(홈 헤더와 동일).
  static const double titleSize = 29;
  static const double subtitleSize = 15;

  final String title;
  final String? subtitle;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            color: Colors.white,
            fontSize: titleSize,
            fontWeight: FontWeight.w800,
          ),
        ),
        if (subtitle != null) ...[
          const SizedBox(height: AppSpacing.sm),
          Text(
            subtitle!,
            style: const TextStyle(
              color: Colors.white70,
              fontSize: subtitleSize,
            ),
          ),
        ],
      ],
    );
  }
}
