import '../../models/models.dart';
import '../../mock/mock_data.dart';
import '../auth_repository.dart';

/// 목 인증 구현. 메모리 세션만 유지한다.
class MockAuthRepository implements AuthRepository {
  AppUser? _current;

  static const _latency = Duration(milliseconds: 400);

  @override
  Future<AppUser?> currentUser() async {
    await Future.delayed(_latency);
    return _current;
  }

  @override
  Future<AppUser> signInWithEmail(String email, String password) async {
    await Future.delayed(_latency);
    // 목: 자격 검증 없이 데모 사용자로 로그인.
    return _current = MockData.demoUser.copyWith(email: email);
  }

  @override
  Future<AppUser> signUpWithEmail({
    required String name,
    required String email,
    required String password,
  }) async {
    await Future.delayed(_latency);
    return _current = MockData.demoUser.copyWith(name: name, email: email);
  }

  @override
  Future<AppUser> signInWithKakao() async {
    await Future.delayed(_latency);
    // TODO: 카카오 SDK 연동.
    return _current =
        MockData.demoUser.copyWith(provider: AuthProvider.kakao);
  }

  @override
  Future<AppUser> signInWithGoogle() async {
    await Future.delayed(_latency);
    // TODO: Google 로그인 연동.
    return _current =
        MockData.demoUser.copyWith(provider: AuthProvider.google);
  }

  @override
  Future<void> signOut() async {
    await Future.delayed(_latency);
    _current = null;
  }
}
