import 'package:freezed_annotation/freezed_annotation.dart';

import 'enums.dart';

part 'pet.freezed.dart';
part 'pet.g.dart';

/// 레벨 1당 필요한 경험치.
const int kExpPerLevel = 100;

/// 반려동물.
///
/// 펫밀리 레벨은 누적 [exp]에서 파생한다(컴포넌트마다 재계산하지 않도록 getter로 제공).
@freezed
abstract class Pet with _$Pet {
  const Pet._();

  const factory Pet({
    required String id,
    required String name,
    required PetSpecies species,
    String? breed,
    PetGender? gender,
    DateTime? birthDate,
    double? weightKg,
    String? imageUrl,
    // 강아지 크기 분류(소/중/대형견). 고양이는 사용하지 않음.
    DogSize? size,
    // 중성화 여부.
    bool? neutered,
    // 알러지 목록(없으면 비어 있음).
    @Default(<String>[]) List<String> allergies,
    @Default(0) int exp,
  }) = _Pet;

  factory Pet.fromJson(Map<String, dynamic> json) => _$PetFromJson(json);

  /// 펫밀리 레벨 (1레벨부터 시작).
  int get level => (exp ~/ kExpPerLevel) + 1;

  /// 현재 레벨 내 진행도 (0.0 ~ 1.0).
  double get levelProgress => (exp % kExpPerLevel) / kExpPerLevel;

  /// 현재 레벨의 현재 경험치(0~99).
  int get levelExp => exp % kExpPerLevel;

  /// 다음 레벨까지 남은 경험치.
  int get expToNextLevel => kExpPerLevel - (exp % kExpPerLevel);

  /// 레벨 칭호.
  String get levelTitle => switch (level) {
        1 => '새싹 집사',
        2 => '반려 초보',
        3 => '건강 지킴이',
        4 => '케어 마스터',
        _ => '펫밀리 히어로',
      };

  /// 만 나이(생년월일 없으면 null).
  int? get ageYears {
    if (birthDate == null) return null;
    final now = DateTime.now();
    var age = now.year - birthDate!.year;
    if (now.month < birthDate!.month ||
        (now.month == birthDate!.month && now.day < birthDate!.day)) {
      age--;
    }
    return age < 0 ? 0 : age;
  }
}
