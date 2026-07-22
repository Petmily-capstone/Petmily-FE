import 'package:flutter/material.dart';

import '../theme/theme.dart';
import 'scale_tap.dart';

/// 버튼 변형. CLAUDE.md: primary/secondary/ghost/danger/kakao/google.
enum AppButtonVariant { primary, secondary, ghost, danger, kakao, google }

/// 브랜드 공통 버튼.
///
/// [ScaleTap]으로 감싸 눌림 축소 피드백을 주고, 변형별 색/보더를 적용한다.
/// [loading] 중에는 스피너를 표시하고 탭을 막는다.
class PrimaryButton extends StatelessWidget {
  const PrimaryButton({
    super.key,
    required this.label,
    this.onPressed,
    this.variant = AppButtonVariant.primary,
    this.icon,
    this.expanded = true,
    this.loading = false,
  });

  final String label;
  final VoidCallback? onPressed;
  final AppButtonVariant variant;
  final IconData? icon;

  /// 가로를 꽉 채울지 여부.
  final bool expanded;
  final bool loading;

  bool get _enabled => onPressed != null && !loading;

  @override
  Widget build(BuildContext context) {
    final style = _resolveStyle();

    final content = Row(
      mainAxisSize: expanded ? MainAxisSize.max : MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (loading)
          SizedBox(
            width: 18,
            height: 18,
            child: CircularProgressIndicator(
              strokeWidth: 2,
              valueColor: AlwaysStoppedAnimation(style.fg),
            ),
          )
        else ...[
          if (icon != null) ...[
            Icon(icon, size: 18, color: style.fg),
            const SizedBox(width: AppSpacing.sm),
          ],
          Text(
            label,
            style: TextStyle(
              color: style.fg,
              fontSize: 15,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ],
    );

    return Opacity(
      opacity: _enabled ? 1 : 0.5,
      child: ScaleTap(
        onTap: _enabled ? onPressed : null,
        child: Container(
          height: 58,
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.xl),
          decoration: BoxDecoration(
            color: style.bg,
            borderRadius: BorderRadius.circular(AppRadius.lg),
            border: style.border == null
                ? null
                : Border.all(color: style.border!, width: 1.2),
          ),
          alignment: Alignment.center,
          child: content,
        ),
      ),
    );
  }

  _ButtonStyle _resolveStyle() {
    switch (variant) {
      case AppButtonVariant.primary:
        return const _ButtonStyle(bg: AppColors.primary, fg: Colors.white);
      case AppButtonVariant.secondary:
        return const _ButtonStyle(
          bg: AppColors.surface,
          fg: AppColors.primary,
          border: AppColors.primary,
        );
      case AppButtonVariant.ghost:
        return const _ButtonStyle(
          bg: Colors.transparent,
          fg: AppColors.textBody,
          border: AppColors.border,
        );
      case AppButtonVariant.danger:
        return const _ButtonStyle(bg: AppColors.danger, fg: Colors.white);
      case AppButtonVariant.kakao:
        return const _ButtonStyle(
          bg: AppColors.kakao,
          fg: AppColors.kakaoText,
        );
      case AppButtonVariant.google:
        return const _ButtonStyle(
          bg: AppColors.surface,
          fg: AppColors.textStrong,
          border: AppColors.border,
        );
    }
  }
}

class _ButtonStyle {
  const _ButtonStyle({required this.bg, required this.fg, this.border});
  final Color bg;
  final Color fg;
  final Color? border;
}
