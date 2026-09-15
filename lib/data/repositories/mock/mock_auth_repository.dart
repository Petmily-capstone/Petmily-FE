import '../../models/models.dart';
import '../auth_repository.dart';

/// 목 인증 구현. 메모리 세션만 유지한다.
///
/// 백엔드 없이 흐름을 확인할 때 쓴다. 첫 로그인은 신규 회원(isNewUser=true)으로,
/// 이후 로그인은 기존 회원으로 시뮬레이션한다.
class MockAuthRepository implements AuthRepository {
  AuthResult? _session;
  bool _firstLogin = true;
  // 사용자가 변경한 표시 이름(로그인 세션의 닉네임을 덮어쓴다).
  String? _displayName;

  static const _latency = Duration(milliseconds: 400);

  @override
  Future<AppUser?> currentUser() async {
    await Future.delayed(_latency);
    final session = _session;
    return session == null ? null : _userFrom(session);
  }

  @override
  Future<AuthResult> signInWithKakao(String code) async {
    await Future.delayed(_latency);
    final result = AuthResult(
      accessToken: 'mock-access-token',
      refreshToken: 'mock-refresh-token',
      userId: 1,
      nickname: '멋쟁이 집사',
      isNewUser: _firstLogin,
    );
    _firstLogin = false;
    return _session = result;
  }

  @override
  Future<void> signOut() async {
    await Future.delayed(_latency);
    _session = null;
    _displayName = null;
  }

  @override
  Future<AppUser> updateDisplayName(String name) async {
    await Future.delayed(_latency);
    final session = _session;
    if (session == null) {
      throw StateError('로그인 상태가 아니에요.');
    }
    _displayName = name;
    return _userFrom(session);
  }

  AppUser _userFrom(AuthResult r) => AppUser(
    id: '${r.userId}',
    name: _displayName ?? r.nickname,
    email: '',
    provider: AuthProvider.kakao,
  );
}
