import '../models/models.dart';

/// 반려동물·데일리 퀵체크 도메인 Repository 인터페이스.
abstract interface class PetRepository {
  Future<List<Pet>> fetchPets();

  Future<Pet> addPet(Pet pet);

  Future<Pet> updatePet(Pet pet);

  Future<void> deletePet(String id);

  /// 특정 날짜의 퀵체크 상태(없으면 빈 체크 반환).
  Future<DailyCheck> fetchDailyCheck(String petId, DateTime date);

  /// 퀵체크 항목을 토글한다.
  ///
  /// 완료/해제에 따라 펫 경험치를 함께 조정하고, 갱신된 (펫, 데일리체크)를 반환한다.
  Future<(Pet, DailyCheck)> toggleDailyCheck({
    required String petId,
    required DateTime date,
    required QuickCheckType type,
  });
}
