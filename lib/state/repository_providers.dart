import 'package:flutter_riverpod/flutter_riverpod.dart';

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

/// Repository 주입 지점.
///
/// 지금은 Mock 구현을 반환한다. 백엔드 연동 시 여기(또는 ProviderScope overrides)를
/// `Api*Repository`로 바꾸면 화면·상태 코드는 그대로 동작한다.
final authRepositoryProvider = Provider<AuthRepository>(
  (ref) => MockAuthRepository(),
);

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
