/// 앱 라우트 경로 상수. 문자열 하드코딩 대신 이 상수를 사용한다.
abstract final class Routes {
  static const splash = '/splash';
  static const onboarding = '/onboarding';
  static const login = '/login';
  static const signup = '/signup';

  /// 펫 등록/수정. `?mode=add` 등 쿼리로 분기.
  static const petSetup = '/pet-setup';

  // 메인 셸 탭
  static const home = '/home';
  static const diagnosis = '/diagnosis';
  static const shop = '/shop';
  static const mypage = '/mypage';

  // 하위 화면
  static const cart = '/cart';

  /// 상품 상세: `/shop/:id`.
  static String productDetail(String id) => '/shop/$id';
}
