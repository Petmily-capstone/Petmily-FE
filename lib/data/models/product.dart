import 'package:freezed_annotation/freezed_annotation.dart';

import 'enums.dart';
import 'review.dart';

part 'product.freezed.dart';
part 'product.g.dart';

/// 펫푸드 성분 1건.
@freezed
abstract class Ingredient with _$Ingredient {
  const factory Ingredient({
    required String name,
    // 성분 분류(좋은/주의/기능성).
    @Default(IngredientKind.good) IngredientKind kind,
    // 기능성 성분의 효능 태그(예: 체중, 피모, 장).
    String? note,
  }) = _Ingredient;

  factory Ingredient.fromJson(Map<String, dynamic> json) =>
      _$IngredientFromJson(json);
}

/// 펫푸드 상품.
@freezed
abstract class Product with _$Product {
  const Product._();

  const factory Product({
    required String id,
    required String name,
    required String brand,
    required int price,
    required PetSpecies species,
    @Default(ProductCategory.food) ProductCategory category,
    String? imageUrl,
    @Default(<String>[]) List<String> tags,
    @Default(0) double rating,
    @Default(0) int reviewCount,
    @Default(<Ingredient>[]) List<Ingredient> ingredients,
    // 적합 대상(예: 강아지, 소화기가 민감한 반려동물).
    @Default(<String>[]) List<String> suitableFor,
    @Default(<Review>[]) List<Review> reviews,
    // 반려동물 성분 궁합 기반 펫밀리 점수(0~100). 없으면 일반 상품.
    int? matchScore,
    // 인증 판매점 여부.
    @Default(false) bool certified,
    @Default('') String description,
  }) = _Product;

  factory Product.fromJson(Map<String, dynamic> json) =>
      _$ProductFromJson(json);

  List<Ingredient> ingredientsOf(IngredientKind kind) =>
      ingredients.where((i) => i.kind == kind).toList();

  /// 좋은 성분 이름 요약(상품 카드용).
  String get goodSummary =>
      ingredientsOf(IngredientKind.good).map((i) => i.name).join(', ');
}
