import '../models/models.dart';

/// 쇼핑 도메인 Repository 인터페이스.
abstract interface class ShopRepository {
  /// 상품 목록. [species]·[query]로 필터링한다.
  Future<List<Product>> fetchProducts({PetSpecies? species, String? query});

  Future<Product> fetchProduct(String id);

  /// 반려동물 성분 궁합 기반 맞춤 추천 상품.
  Future<List<Product>> fetchRecommended(String petId);

  // TODO: 결제(PG) 연동. 지금은 성공 응답만 흉내 낸다.
  Future<void> checkout(List<CartItem> items);
}
