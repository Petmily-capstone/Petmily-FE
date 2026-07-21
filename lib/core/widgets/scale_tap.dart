import 'package:flutter/material.dart';

/// 눌렀을 때 살짝 축소되는 공통 탭 래퍼.
///
/// 버튼·카드·탭 등 누를 수 있는 요소를 감싸 일관된 눌림 피드백을 준다.
class ScaleTap extends StatefulWidget {
  const ScaleTap({
    super.key,
    required this.child,
    this.onTap,
    this.scale = 0.96,
    this.duration = const Duration(milliseconds: 90),
  });

  final Widget child;
  final VoidCallback? onTap;

  /// 눌림 시 축소 비율 (0~1).
  final double scale;
  final Duration duration;

  @override
  State<ScaleTap> createState() => _ScaleTapState();
}

class _ScaleTapState extends State<ScaleTap> {
  bool _pressed = false;

  bool get _enabled => widget.onTap != null;

  void _setPressed(bool value) {
    if (!_enabled) return;
    if (_pressed != value) setState(() => _pressed = value);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: widget.onTap,
      onTapDown: (_) => _setPressed(true),
      onTapUp: (_) => _setPressed(false),
      onTapCancel: () => _setPressed(false),
      child: AnimatedScale(
        scale: _pressed ? widget.scale : 1.0,
        duration: widget.duration,
        curve: Curves.easeOut,
        child: widget.child,
      ),
    );
  }
}
