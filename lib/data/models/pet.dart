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
    @Default(0) int exp,
  }) = _Pet;

  factory Pet.fromJson(Map<String, dynamic> json) => _$PetFromJson(json);

  /// 펫밀리 레벨 (1레벨부터 시작).
  int get level => (exp ~/ kExpPerLevel) + 1;

  /// 현재 레벨 내 진행도 (0.0 ~ 1.0).
  double get levelProgress => (exp % kExpPerLevel) / kExpPerLevel;

  /// 다음 레벨까지 남은 경험치.
  int get expToNextLevel => kExpPerLevel - (exp % kExpPerLevel);
}
