import 'package:dio/dio.dart';

import '../../data/services/token_store.dart';
import '../config/app_config.dart';

/// [Dio] 인스턴스 생성. baseUrl + 인증 토큰 인터셉터를 설정한다.
///
/// 저장된 accessToken이 있으면 모든 요청에 `Authorization: Bearer`를 자동으로 붙인다.
/// (로그인 엔드포인트는 토큰이 없을 때 그냥 헤더를 생략한다.)
Dio createDio(AppConfig config, TokenStore tokenStore) {
  final dio = Dio(
    BaseOptions(
      baseUrl: config.baseUrl,
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 10),
      // isSuccess:false여도 서버가 200으로 내려줄 수 있으므로 그대로 통과시킨다.
      validateStatus: (status) => status != null && status < 500,
    ),
  );

  dio.interceptors.add(
    InterceptorsWrapper(
      onRequest: (options, handler) async {
        final token = await tokenStore.readAccessToken();
        if (token != null) {
          options.headers['Authorization'] = 'Bearer $token';
        }
        handler.next(options);
      },
    ),
  );

  return dio;
}
