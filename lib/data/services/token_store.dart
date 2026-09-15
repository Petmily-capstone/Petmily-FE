import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../models/models.dart';

/// 인증 토큰·세션 정보를 안전 저장소에 보관한다.
///
/// accessToken은 이후 요청의 `Authorization: Bearer`로, refreshToken은 재발급용으로 쓴다.
class TokenStore {
  TokenStore([FlutterSecureStorage? storage])
      : _storage = storage ?? const FlutterSecureStorage();

  final FlutterSecureStorage _storage;

  static const _kAccess = 'auth_access_token';
  static const _kRefresh = 'auth_refresh_token';
  static const _kUserId = 'auth_user_id';
  static const _kNickname = 'auth_nickname';

  Future<void> save(AuthResult result) async {
    await _storage.write(key: _kAccess, value: result.accessToken);
    await _storage.write(key: _kRefresh, value: result.refreshToken);
    await _storage.write(key: _kUserId, value: '${result.userId}');
    await _storage.write(key: _kNickname, value: result.nickname);
  }

  /// 표시 이름(닉네임)만 갱신한다.
  Future<void> updateNickname(String nickname) =>
      _storage.write(key: _kNickname, value: nickname);

  Future<String?> readAccessToken() => _storage.read(key: _kAccess);

  Future<String?> readRefreshToken() => _storage.read(key: _kRefresh);

  /// 저장된 세션으로 복원한 사용자. 없으면 null.
  Future<AppUser?> cachedUser() async {
    final id = await _storage.read(key: _kUserId);
    if (id == null) return null;
    final nickname = await _storage.read(key: _kNickname) ?? '';
    return AppUser(
      id: id,
      name: nickname,
      email: '',
      provider: AuthProvider.kakao,
    );
  }

  Future<void> clear() async {
    await _storage.delete(key: _kAccess);
    await _storage.delete(key: _kRefresh);
    await _storage.delete(key: _kUserId);
    await _storage.delete(key: _kNickname);
  }
}
