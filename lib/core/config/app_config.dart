/// 앱 전역 환경설정.
///
/// 빌드 환경별 값은 `--dart-define`으로 주입한다. 개발 기본값은 로컬 백엔드 기준.
class AppConfig {
  const AppConfig({
    required this.baseUrl,
    required this.useMock,
    required this.kakaoRestApiKey,
    required this.kakaoRedirectUri,
  });

  /// REST 백엔드 base URL. 실제 API 호출(`POST /auth/kakao` 등)이 닿는 주소.
  ///
  /// 주의: [kakaoRedirectUri]와 다른 개념이다. redirect_uri는 "카카오 등록값과
  /// 글자까지 일치해야 하는 매칭 문자열"이고, 앱은 그 주소에 실제로 접속하지 않는다.
  /// 반면 baseUrl은 진짜로 백엔드에 도달해야 한다.
  /// - Android 에뮬레이터에서 호스트 PC의 로컬 백엔드: `http://10.0.2.2:8080`
  /// - iOS 시뮬레이터: `http://127.0.0.1:8080`
  final String baseUrl;

  /// true면 Mock* Repository, false면 Api* Repository를 사용한다.
  final bool useMock;

  /// 카카오 REST API 키 (= OAuth client_id). authorize URL에 노출되는 값이라 비밀이 아님.
  final String kakaoRestApiKey;

  /// 카카오 인가 코드 콜백 redirect_uri.
  ///
  /// **백엔드 `kakao.redirect-uri` · 카카오 디벨로퍼스 등록값과 정확히 일치해야 한다.**
  /// WebView가 이 URL로 이동하려는 순간 인터셉트해 `?code=`만 추출하므로,
  /// 실제로 접속되지는 않는다(로컬 주소여도 개발 단계에서 동작).
  final String kakaoRedirectUri;

  static const AppConfig dev = AppConfig(
    baseUrl: String.fromEnvironment(
      'BASE_URL',
      defaultValue: 'http://10.0.2.2:8080',
    ),
    useMock: bool.fromEnvironment('USE_MOCK', defaultValue: true),
    kakaoRestApiKey: String.fromEnvironment(
      'KAKAO_REST_API_KEY',
      defaultValue: 'b0c2a33a93fe1328c5ae313711eae4cb',
    ),
    kakaoRedirectUri: String.fromEnvironment(
      'KAKAO_REDIRECT_URI',
      defaultValue: 'http://127.0.0.1:8080/login',
    ),
  );
}
