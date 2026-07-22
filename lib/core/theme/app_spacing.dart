/// 간격·라운드 토큰. 매직넘버 대신 이 상수를 사용한다.
abstract final class AppSpacing {
  static const double xs = 4;
  static const double sm = 8;
  static const double md = 12;
  static const double lg = 16;
  static const double xl = 20;
  static const double xxl = 24;
  static const double xxxl = 32;

  /// 화면 내 주요 섹션(카드 그룹) 사이 간격. 전 페이지 공통.
  static const double section = 36;

  /// 화면 좌우 기본 여백. 전 페이지 공통.
  static const double page = 20;
}

/// 카드/버튼 라운드 토큰 (CLAUDE.md: 16~24 큰 라운드).
abstract final class AppRadius {
  static const double sm = 8;
  static const double md = 12;
  static const double lg = 16;
  static const double xl = 20;
  static const double xxl = 24;
  static const double pill = 999;
}
