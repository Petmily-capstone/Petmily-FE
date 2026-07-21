import '../../models/models.dart';
import '../../mock/mock_data.dart';
import '../pet_repository.dart';

/// 목 반려동물 구현. 메모리에서 펫과 데일리 퀵체크를 관리한다.
class MockPetRepository implements PetRepository {
  final List<Pet> _pets = MockData.pets();
  final Map<String, DailyCheck> _checks = {};

  int _seq = 100;
  static const _latency = Duration(milliseconds: 350);

  String _key(String petId, DateTime date) =>
      '$petId|${date.year}-${date.month}-${date.day}';

  @override
  Future<List<Pet>> fetchPets() async {
    await Future.delayed(_latency);
    return List.unmodifiable(_pets);
  }

  @override
  Future<Pet> addPet(Pet pet) async {
    await Future.delayed(_latency);
    final created = pet.id.isEmpty ? pet.copyWith(id: 'p${_seq++}') : pet;
    _pets.add(created);
    return created;
  }

  @override
  Future<Pet> updatePet(Pet pet) async {
    await Future.delayed(_latency);
    final i = _pets.indexWhere((p) => p.id == pet.id);
    if (i == -1) throw StateError('존재하지 않는 펫: ${pet.id}');
    _pets[i] = pet;
    return pet;
  }

  @override
  Future<void> deletePet(String id) async {
    await Future.delayed(_latency);
    _pets.removeWhere((p) => p.id == id);
    _checks.removeWhere((k, _) => k.startsWith('$id|'));
  }

  @override
  Future<DailyCheck> fetchDailyCheck(String petId, DateTime date) async {
    await Future.delayed(_latency);
    return _checks[_key(petId, date)] ??
        DailyCheck(petId: petId, date: date);
  }

  @override
  Future<(Pet, DailyCheck)> toggleDailyCheck({
    required String petId,
    required DateTime date,
    required QuickCheckType type,
  }) async {
    await Future.delayed(_latency);
    final key = _key(petId, date);
    final current = _checks[key] ?? DailyCheck(petId: petId, date: date);

    final wasDone = current.isDone(type);
    final completed = wasDone
        ? current.completed.where((t) => t != type).toList()
        : [...current.completed, type];
    final updatedCheck = current.copyWith(completed: completed);
    _checks[key] = updatedCheck;

    // 완료 시 경험치 획득, 해제 시 회수(0 미만 방지).
    final i = _pets.indexWhere((p) => p.id == petId);
    if (i == -1) throw StateError('존재하지 않는 펫: $petId');
    final delta = wasDone ? -type.exp : type.exp;
    final updatedPet =
        _pets[i].copyWith(exp: (_pets[i].exp + delta).clamp(0, 1 << 30));
    _pets[i] = updatedPet;

    return (updatedPet, updatedCheck);
  }
}
