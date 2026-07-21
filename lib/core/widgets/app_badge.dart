import 'package:flutter/material.dart';

import '../theme/theme.dart';

/// 배지 변형. 연한 배경 + 진한 글자 조합.
enum AppBadgeColor { blue, green, red, yellow, purple, gray, orange }

/// 상태/카테고리 표시용 작은 배지.
class AppBadge extends StatelessWidget {
  const AppBadge({
    super.key,
    required this.label,
    this.color = AppBadgeColor.blue,
    this.icon,
  });

  final String label;
  final AppBadgeColor color;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    final palette = _palette(color);
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.sm,
        vertical: AppSpacing.xs,
      ),
      decoration: BoxDecoration(
        color: palette.bg,
        borderRadius: BorderRadius.circular(AppRadius.pill),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null) ...[
            Icon(icon, size: 12, color: palette.fg),
            const SizedBox(width: 4),
          ],
          Text(
            label,
            style: TextStyle(
              color: palette.fg,
              fontSize: 12,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  _BadgePalette _palette(AppBadgeColor c) {
    switch (c) {
      case AppBadgeColor.blue:
        return const _BadgePalette(Color(0xFFDBEAFE), Color(0xFF1D4ED8));
      case AppBadgeColor.green:
        return const _BadgePalette(Color(0xFFDCFCE7), Color(0xFF15803D));
      case AppBadgeColor.red:
        return const _BadgePalette(Color(0xFFFEE2E2), Color(0xFFB91C1C));
      case AppBadgeColor.yellow:
        return const _BadgePalette(Color(0xFFFEF9C3), Color(0xFF854D0E));
      case AppBadgeColor.purple:
        return const _BadgePalette(Color(0xFFF3E8FF), Color(0xFF7E22CE));
      case AppBadgeColor.gray:
        return const _BadgePalette(Color(0xFFF1F5F9), Color(0xFF475569));
      case AppBadgeColor.orange:
        return const _BadgePalette(Color(0xFFFFEDD5), Color(0xFFC2410C));
    }
  }
}

class _BadgePalette {
  const _BadgePalette(this.bg, this.fg);
  final Color bg;
  final Color fg;
}
