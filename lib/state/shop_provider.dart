import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/models/models.dart';
import 'pet_provider.dart';
import 'repository_providers.dart';

/// 선택된 카테고리(null = 전체). 종은 활성 펫으로 자동 결정된다.
class ShopCategoryNotifier extends Notifier<ProductCategory?> {
  @override
  ProductCategory? build() => null;

  void select(ProductCategory? category) => state = category;
}

final shopCategoryProvider =
    NotifierProvider<ShopCategoryNotifier, ProductCategory?>(
        ShopCategoryNotifier.new);

/// 검색어.
class ShopQueryNotifier extends Notifier<String> {
  @override
  String build() => '';

  void set(String value) => state = value;
}

final shopQueryProvider =
    NotifierProvider<ShopQueryNotifier, String>(ShopQueryNotifier.new);

/// 활성 펫의 종.
final _activeSpeciesProvider = Provider<PetSpecies?>((ref) {
  return ref.watch(activePetProvider)?.species;
});

/// 필터(종+카테고리+검색어)가 반영된 상품 목록.
final productListProvider = FutureProvider<List<Product>>((ref) async {
  final species = ref.watch(_activeSpeciesProvider);
  final category = ref.watch(shopCategoryProvider);
  final query = ref.watch(shopQueryProvider);
  return ref.watch(shopRepositoryProvider).fetchProducts(
        species: species,
        category: category,
        query: query,
      );
});

/// 단일 상품 조회.
final productDetailProvider =
    FutureProvider.family<Product, String>((ref, id) async {
  return ref.watch(shopRepositoryProvider).fetchProduct(id);
});

/// AI 추천(맞춤 점수 상위) 상품.
final recommendedProductsProvider = FutureProvider<List<Product>>((ref) async {
  final pet = ref.watch(activePetProvider);
  final petId = pet?.id ?? '';
  return ref.watch(shopRepositoryProvider).fetchRecommended(petId);
});

/// 찜(위시리스트) 상품 id 집합.
class WishlistNotifier extends Notifier<Set<String>> {
  @override
  Set<String> build() => {};

  void toggle(String productId) {
    final next = {...state};
    if (!next.remove(productId)) next.add(productId);
    state = next;
  }
}

final wishlistProvider =
    NotifierProvider<WishlistNotifier, Set<String>>(WishlistNotifier.new);

/// 장바구니.
class CartNotifier extends Notifier<List<CartItem>> {
  @override
  List<CartItem> build() => const [];

  void add(Product product, {int quantity = 1}) {
    final i = state.indexWhere((c) => c.product.id == product.id);
    if (i == -1) {
      state = [...state, CartItem(product: product, quantity: quantity)];
    } else {
      final updated = state[i].copyWith(quantity: state[i].quantity + quantity);
      state = [...state]..[i] = updated;
    }
  }

  void setQuantity(String productId, int quantity) {
    if (quantity <= 0) {
      remove(productId);
      return;
    }
    state = [
      for (final c in state)
        c.product.id == productId ? c.copyWith(quantity: quantity) : c,
    ];
  }

  void remove(String productId) {
    state = state.where((c) => c.product.id != productId).toList();
  }

  void clear() => state = const [];

  // TODO: 결제 연동. 지금은 목 checkout 후 장바구니 비움.
  Future<void> checkout() async {
    await ref.read(shopRepositoryProvider).checkout(state);
    clear();
  }
}

final cartProvider =
    NotifierProvider<CartNotifier, List<CartItem>>(CartNotifier.new);

/// 파생 provider: 장바구니 합계 금액.
final cartTotalProvider = Provider<int>((ref) {
  final items = ref.watch(cartProvider);
  return items.fold(0, (sum, item) => sum + item.subtotal);
});

/// 파생 provider: 장바구니 총 수량.
final cartCountProvider = Provider<int>((ref) {
  final items = ref.watch(cartProvider);
  return items.fold(0, (sum, item) => sum + item.quantity);
});

/// 홈 '건강 콘텐츠' 목록.
final healthContentsProvider = FutureProvider<List<HealthContent>>((ref) async {
  return ref.watch(contentRepositoryProvider).fetchHealthContents();
});
