import 'package:flutter/material.dart';

import 'app_colors.dart';

/// 앱 전역 Material 테마.
///
/// 브랜드 톤(파란 계열·연한 배경·둥근모서리)을 ThemeData에 반영한다.
/// 개별 위젯은 이 테마를 기반으로 하되, 세부 스타일은 core/widgets에서 관장한다.
abstract final class AppTheme {
  static ThemeData get light {
    final scheme = ColorScheme.fromSeed(
      seedColor: AppColors.primary,
      primary: AppColors.primary,
      surface: AppColors.surface,
    );

    return ThemeData(
      useMaterial3: true,
      colorScheme: scheme,
      scaffoldBackgroundColor: AppColors.background,
      fontFamily: 'Pretendard', // 미설치 시 시스템 폰트로 폴백
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.white,
        elevation: 0,
        centerTitle: false,
      ),
      textTheme: _textTheme,
      dividerColor: AppColors.border,
      splashFactory: NoSplash.splashFactory, // 눌림 효과는 ScaleTap이 담당
    );
  }

  static const TextTheme _textTheme = TextTheme(
    headlineLarge: TextStyle(
      fontSize: 28,
      fontWeight: FontWeight.w800,
      color: AppColors.textStrong,
    ),
    headlineMedium: TextStyle(
      fontSize: 22,
      fontWeight: FontWeight.w700,
      color: AppColors.textStrong,
    ),
    titleLarge: TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.w700,
      color: AppColors.textStrong,
    ),
    titleMedium: TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w600,
      color: AppColors.textStrong,
    ),
    bodyLarge: TextStyle(fontSize: 15, color: AppColors.textBody),
    bodyMedium: TextStyle(fontSize: 14, color: AppColors.textBody),
    bodySmall: TextStyle(fontSize: 12, color: AppColors.textMuted),
    labelLarge: TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w600,
      color: AppColors.textStrong,
    ),
  );
}

/// 부드러운 카드 그림자 토큰.
abstract final class AppShadows {
  static const List<BoxShadow> card = [
    BoxShadow(
      color: Color(0x14000000), // black 8%
      blurRadius: 16,
      offset: Offset(0, 6),
    ),
  ];

  static const List<BoxShadow> soft = [
    BoxShadow(
      color: Color(0x0F000000), // black 6%
      blurRadius: 10,
      offset: Offset(0, 4),
    ),
  ];
}
