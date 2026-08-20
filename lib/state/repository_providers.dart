import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../core/config/app_config.dart';
import '../core/network/dio_client.dart';
import '../data/repositories/api/api_auth_repository.dart';
import '../data/repositories/auth_repository.dart';
import '../data/repositories/content_repository.dart';
import '../data/repositories/diagnosis_repository.dart';
import '../data/repositories/pet_repository.dart';
import '../data/repositories/shop_repository.dart';
import '../data/repositories/mock/mock_auth_repository.dart';
import '../data/repositories/mock/mock_content_repository.dart';
import '../data/repositories/mock/mock_diagnosis_repository.dart';
import '../data/repositories/mock/mock_pet_repository.dart';
import '../data/repositories/mock/mock_shop_repository.dart';
import '../data/services/token_store.dart';

/// Repository 주입 지점.
///
/// [AppConfig.useMock]에 따라 Mock*/Api*를 선택한다. 화면·상태 코드는 인터페이스에만
/// 의존하므로 이 스위치만 바꾸면 그대로 동작한다.

/// 앱 전역 설정. 테스트에서 override 가능하도록 provider로 노출.
final appConfigProvider = Provider<AppConfig>((ref) => AppConfig.dev);

/// 토큰 안전 저장소.
final tokenStoreProvider = Provider<TokenStore>((ref) => TokenStore());

/// 인증 헤더가 붙은 Dio 인스턴스.
final dioProvider = Provider<Dio>(
  (ref) => createDio(
    ref.watch(appConfigProvider),
    ref.watch(tokenStoreProvider),
  ),
);

final authRepositoryProvider = Provider<AuthRepository>((ref) {
  if (ref.watch(appConfigProvider).useMock) {
    return MockAuthRepository();
  }
  return ApiAuthRepository(
    ref.watch(dioProvider),
    ref.watch(tokenStoreProvider),
  );
});

final petRepositoryProvider = Provider<PetRepository>(
  (ref) => MockPetRepository(),
);

final diagnosisRepositoryProvider = Provider<DiagnosisRepository>(
  (ref) => MockDiagnosisRepository(),
);

final shopRepositoryProvider = Provider<ShopRepository>(
  (ref) => MockShopRepository(),
);

final contentRepositoryProvider = Provider<ContentRepository>(
  (ref) => MockContentRepository(),
);
