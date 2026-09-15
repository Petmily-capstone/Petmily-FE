import '../models/models.dart';

/// 인증 도메인 Repository 인터페이스.
///
/// 화면/상태는 이 인터페이스에만 의존한다. 개발 단계는 [MockAuthRepository],
/// 백엔드 연동 시 `ApiAuthRepository`를 provider override로 교체한다.
///
/// 로그인 수단은 **카카오 소셜 로그인(인가 코드 방식)** 하나만 지원한다.
abstract interface class AuthRepository {
  /// 저장된 세션으로 복원한 로그인 사용자. 없으면 null.
  Future<AppUser?> currentUser();

  /// 카카오 인가 코드를 서버에 넘겨 자체 세션(JWT)을 발급받는다.
  ///
  /// 프론트는 카카오 authorize 화면에서 [code]만 받아 넘기고, 카카오 토큰 교환은
  /// 서버(`POST /auth/kakao`)가 처리한다.
  Future<AuthResult> signInWithKakao(String code);

  Future<void> signOut();

  /// 표시 이름(닉네임)을 변경하고 갱신된 사용자를 반환한다.
  Future<AppUser> updateDisplayName(String name);
}
