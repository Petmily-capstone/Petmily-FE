import '../../models/models.dart';
import '../../mock/mock_data.dart';
import '../shop_repository.dart';

/// 목 쇼핑 구현. 시드 상품을 필터링해 반환한다.
class MockShopRepository implements ShopRepository {
  final List<Product> _products = MockData.products();
  static const _latency = Duration(milliseconds: 400);

  @override
  Future<List<Product>> fetchProducts({
    PetSpecies? species,
    ProductCategory? category,
    String? query,
  }) async {
    await Future.delayed(_latency);
    final q = query?.trim().toLowerCase();
    return _products.where((p) {
      final speciesOk = species == null || p.species == species;
      final categoryOk = category == null || p.category == category;
      final queryOk = q == null ||
          q.isEmpty ||
          p.name.toLowerCase().contains(q) ||
          p.brand.toLowerCase().contains(q);
      return speciesOk && categoryOk && queryOk;
    }).toList();
  }

  @override
  Future<Product> fetchProduct(String id) async {
    await Future.delayed(_latency);
    return _products.firstWhere(
      (p) => p.id == id,
      orElse: () => throw StateError('존재하지 않는 상품: $id'),
    );
  }

  @override
  Future<List<Product>> fetchRecommended(String petId) async {
    await Future.delayed(_latency);
    // 목: 맞춤 점수가 높은 상품 상위 5개(AI 추천 TOP 5).
    final items =
        _products.where((p) => p.matchScore != null).toList()
          ..sort((a, b) => b.matchScore!.compareTo(a.matchScore!));
    return items.take(5).toList();
  }

  @override
  Future<void> checkout(List<CartItem> items) async {
    await Future.delayed(const Duration(milliseconds: 800));
    // TODO: PG 결제 연동. 지금은 성공만 흉내 낸다.
  }
}
