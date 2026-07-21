import 'package:flutter/material.dart';

/// 펫밀리 브랜드 컬러 토큰.
///
/// 원본 프로토타입의 Tailwind 팔레트를 Flutter 상수로 옮긴 것.
/// 파란 계열을 중심으로 카드형/둥근모서리/부드러운 그림자 톤을 유지한다.
abstract final class AppColors {
  // Brand
  static const Color primary = Color(0xFF3B82F6);
  static const Color primaryLight = Color(0xFF60A5FA);
  static const Color primaryDeep = Color(0xFF1D4ED8);

  // Surfaces
  static const Color background = Color(0xFFF0F7FF);
  static const Color surface = Color(0xFFFFFFFF);

  // Text
  static const Color textStrong = Color(0xFF1E293B); // slate-800
  static const Color textBody = Color(0xFF475569); // slate-600
  static const Color textMuted = Color(0xFF94A3B8); // slate-400

  // Lines
  static const Color border = Color(0xFFE2E8F0); // slate-200

  // Semantic
  static const Color success = Color(0xFF22C55E);
  static const Color danger = Color(0xFFEF4444);
  static const Color warning = Color(0xFFF59E0B);

  // Social
  static const Color kakao = Color(0xFFFEE500);
  static const Color kakaoText = Color(0xFF191600);

  /// 헤더 기본 그라데이션: primary-deep → primary (세로).
  static const LinearGradient headerGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [primaryDeep, primary],
  );
}
