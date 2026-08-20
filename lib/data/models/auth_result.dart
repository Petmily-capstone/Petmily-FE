import 'package:freezed_annotation/freezed_annotation.dart';

part 'auth_result.freezed.dart';
part 'auth_result.g.dart';

/// `POST /auth/kakao` 성공 응답의 `result` 필드.
///
/// 서버가 카카오 인가 코드를 토큰으로 교환한 뒤 발급하는 자체 세션 정보.
@freezed
abstract class AuthResult with _$AuthResult {
  const factory AuthResult({
    required String accessToken,
    required String refreshToken,
    required int userId,
    required String nickname,
    required bool isNewUser,
  }) = _AuthResult;

  factory AuthResult.fromJson(Map<String, dynamic> json) =>
      _$AuthResultFromJson(json);
}
