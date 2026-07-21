import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/models/models.dart';
import '../data/repositories/pet_repository.dart';
import 'repository_providers.dart';

/// 오늘 날짜(시각 제거).
DateTime _today() {
  final now = DateTime.now();
  return DateTime(now.year, now.month, now.day);
}

/// Pet 도메인 상태: 펫 목록 + 선택된 펫 + 오늘자 퀵체크.
class PetState {
  const PetState({
    this.pets = const [],
    this.activePetId,
    this.todayCheck,
  });

  final List<Pet> pets;
  final String? activePetId;
  final DailyCheck? todayCheck;

  /// 파생값: 현재 선택된 펫(없으면 첫 펫).
  Pet? get activePet {
    if (pets.isEmpty) return null;
    return pets.firstWhere(
      (p) => p.id == activePetId,
      orElse: () => pets.first,
    );
  }

  PetState copyWith({
    List<Pet>? pets,
    String? activePetId,
    DailyCheck? todayCheck,
  }) {
    return PetState(
      pets: pets ?? this.pets,
      activePetId: activePetId ?? this.activePetId,
      todayCheck: todayCheck ?? this.todayCheck,
    );
  }
}

/// Pet 도메인 유스케이스.
class PetNotifier extends AsyncNotifier<PetState> {
  PetRepository get _repo => ref.read(petRepositoryProvider);

  @override
  Future<PetState> build() async {
    final pets = await _repo.fetchPets();
    final activeId = pets.isEmpty ? null : pets.first.id;
    final check =
        activeId == null ? null : await _repo.fetchDailyCheck(activeId, _today());
    return PetState(pets: pets, activePetId: activeId, todayCheck: check);
  }

  /// 활성 펫 전환 + 해당 펫 오늘 퀵체크 로드.
  Future<void> selectPet(String petId) async {
    final current = state.value;
    if (current == null) return;
    final check = await _repo.fetchDailyCheck(petId, _today());
    state = AsyncData(current.copyWith(activePetId: petId, todayCheck: check));
  }

  /// 오늘 퀵체크 항목 토글(펫 경험치 동반 갱신).
  Future<void> toggleCheck(QuickCheckType type) async {
    final current = state.value;
    final petId = current?.activePetId;
    if (current == null || petId == null) return;

    final (updatedPet, updatedCheck) = await _repo.toggleDailyCheck(
      petId: petId,
      date: _today(),
      type: type,
    );
    final pets = [
      for (final p in current.pets) p.id == updatedPet.id ? updatedPet : p,
    ];
    state = AsyncData(current.copyWith(pets: pets, todayCheck: updatedCheck));
  }

  /// 펫 등록.
  Future<Pet> addPet(Pet pet) async {
    final created = await _repo.addPet(pet);
    final current = state.value ?? const PetState();
    state = AsyncData(current.copyWith(pets: [...current.pets, created]));
    return created;
  }

  /// 펫 정보 수정.
  Future<void> updatePet(Pet pet) async {
    final updated = await _repo.updatePet(pet);
    final current = state.value;
    if (current == null) return;
    final pets = [
      for (final p in current.pets) p.id == updated.id ? updated : p,
    ];
    state = AsyncData(current.copyWith(pets: pets));
  }
}

final petProvider =
    AsyncNotifierProvider<PetNotifier, PetState>(PetNotifier.new);

/// 파생 provider: 현재 활성 펫(로딩/에러 시 null).
final activePetProvider = Provider<Pet?>((ref) {
  return ref.watch(petProvider).value?.activePet;
});
