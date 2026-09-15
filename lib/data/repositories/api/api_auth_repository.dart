import 'package:dio/dio.dart';

import '../../../core/network/api_exception.dart';
import '../../models/models.dart';
import '../../services/token_store.dart';
import '../auth_repository.dart';

/// 실서버 인증 구현. `POST /auth/kakao`로 세션을 발급받아 저장한다.
class ApiAuthRepository implements AuthRepository {
  ApiAuthRepository(this._dio, this._tokenStore);

  final Dio _dio;
  final TokenStore _tokenStore;

  @override
  Future<AppUser?> currentUser() async {
    final token = await _tokenStore.readAccessToken();
    if (token == null) return null;
    return _tokenStore.cachedUser();
  }

  @override
  Future<AuthResult> signInWithKakao(String code) async {
    // 컨트롤러가 @RequestParam이라 JSON body가 아닌 쿼리 파라미터로 보낸다.
    final response = await _dio.post<Map<String, dynamic>>(
      '/auth/kakao',
      queryParameters: {'code': code},
    );

    final body = response.data ?? const {};
    if (body['isSuccess'] != true) {
      throw ApiException(
        body['code']?.toString() ?? 'UNKNOWN',
        body['message']?.toString() ?? '카카오 인증에 실패했습니다.',
      );
    }

    final result = AuthResult.fromJson(body['result'] as Map<String, dynamic>);
    await _tokenStore.save(result);
    return result;
  }

  @override
  Future<void> signOut() async {
    // TODO: 서버 로그아웃/토큰 무효화 API 연동 (있다면).
    await _tokenStore.clear();
  }

  @override
  Future<AppUser> updateDisplayName(String name) async {
    // TODO: 프로필 수정 API 연동 (예: PATCH /users/me).
    await _tokenStore.updateNickname(name);
    final user = await _tokenStore.cachedUser();
    if (user == null) {
      throw ApiException('UNAUTHENTICATED', '로그인 상태가 아니에요.');
    }
    return user;
  }
}
