import 'package:flutter/material.dart';

import '../theme/theme.dart';

/// 펫밀리 레벨 게이지 등에 쓰는 둥근 진행 바.
class AppProgressBar extends StatelessWidget {
  const AppProgressBar({
    super.key,
    required this.value,
    this.height = 10,
    this.color = AppColors.primary,
    this.backgroundColor = const Color(0xFFE2E8F0),
    this.gradient,
  });

  /// 0.0 ~ 1.0.
  final double value;
  final double height;
  final Color color;
  final Color backgroundColor;

  /// 지정 시 [color] 대신 그라데이션으로 채운다.
  final Gradient? gradient;

  @override
  Widget build(BuildContext context) {
    final clamped = value.clamp(0.0, 1.0);
    return ClipRRect(
      borderRadius: BorderRadius.circular(AppRadius.pill),
      child: Stack(
        children: [
          Container(height: height, color: backgroundColor),
          FractionallySizedBox(
            widthFactor: clamped,
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 400),
              curve: Curves.easeOut,
              height: height,
              decoration: BoxDecoration(
                color: gradient == null ? color : null,
                gradient: gradient,
                borderRadius: BorderRadius.circular(AppRadius.pill),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
