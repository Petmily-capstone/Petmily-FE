/// 앱 전역 환경설정.
///
/// 지금은 목데이터로 동작하지만, 백엔드 연동 시 [baseUrl] 등을 여기서 주입한다.
/// 빌드 환경별 값은 `--dart-define`으로 주입할 수 있도록 자리를 마련해 둔다.
class AppConfig {
  const AppConfig({
    required this.baseUrl,
    required this.useMock,
  });

  /// REST/GraphQL 백엔드 base URL. 목 단계에서는 비어 있다.
  final String baseUrl;

  /// true면 Mock* Repository, false면 Api* Repository를 사용한다.
  final bool useMock;

  /// 기본(개발) 설정. 추후 flavor별로 확장한다.
  static const AppConfig dev = AppConfig(
    // TODO: 백엔드 준비되면 실제 주소 주입 (--dart-define=BASE_URL=...).
    baseUrl: String.fromEnvironment('BASE_URL', defaultValue: ''),
    useMock: bool.fromEnvironment('USE_MOCK', defaultValue: true),
  );
}
