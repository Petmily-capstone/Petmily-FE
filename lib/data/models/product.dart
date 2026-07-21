import 'package:freezed_annotation/freezed_annotation.dart';

import 'enums.dart';

part 'product.freezed.dart';
part 'product.g.dart';

/// 펫푸드 성분 1건.
@freezed
abstract class Ingredient with _$Ingredient {
  const factory Ingredient({
    required String name,
    // 성분 분석 결과: 이로운 성분이면 true, 주의 성분이면 false.
    @Default(true) bool isGood,
    String? note,
  }) = _Ingredient;

  factory Ingredient.fromJson(Map<String, dynamic> json) =>
      _$IngredientFromJson(json);
}

/// 펫푸드 상품.
@freezed
abstract class Product with _$Product {
  const factory Product({
    required String id,
    required String name,
    required String brand,
    required int price,
    required PetSpecies species,
    String? imageUrl,
    @Default(<String>[]) List<String> tags,
    @Default(0) double rating,
    @Default(<Ingredient>[]) List<Ingredient> ingredients,
    // 반려동물 성분 궁합 기반 맞춤 점수(0~100). 없으면 일반 상품.
    int? matchScore,
    @Default('') String description,
  }) = _Product;

  factory Product.fromJson(Map<String, dynamic> json) =>
      _$ProductFromJson(json);
}
