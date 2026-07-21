import '../models/models.dart';

/// 인증 도메인 Repository 인터페이스.
///
/// 화면/상태는 이 인터페이스에만 의존한다. 지금은 [MockAuthRepository],
/// 백엔드 연동 시 `ApiAuthRepository`를 provider override로 교체한다.
abstract interface class AuthRepository {
  /// 세션에 남아 있는 로그인 사용자. 없으면 null.
  Future<AppUser?> currentUser();

  Future<AppUser> signInWithEmail(String email, String password);

  Future<AppUser> signUpWithEmail({
    required String name,
    required String email,
    required String password,
  });

  // TODO: 카카오 SDK 연동 (지금은 목 사용자 반환).
  Future<AppUser> signInWithKakao();

  // TODO: Google 로그인 연동 (지금은 목 사용자 반환).
  Future<AppUser> signInWithGoogle();

  Future<void> signOut();
}
