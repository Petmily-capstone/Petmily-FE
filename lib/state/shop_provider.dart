import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/models/models.dart';
import 'repository_providers.dart';

/// 상품 목록 필터.
class ShopFilter {
  const ShopFilter({this.species, this.query = ''});
  final PetSpecies? species;
  final String query;

  ShopFilter copyWith({PetSpecies? species, bool clearSpecies = false, String? query}) {
    return ShopFilter(
      species: clearSpecies ? null : (species ?? this.species),
      query: query ?? this.query,
    );
  }
}

/// 현재 상품 목록 필터 상태.
class ShopFilterNotifier extends Notifier<ShopFilter> {
  @override
  ShopFilter build() => const ShopFilter();

  void setSpecies(PetSpecies? species) {
    state = species == null
        ? state.copyWith(clearSpecies: true)
        : state.copyWith(species: species);
  }

  void setQuery(String query) => state = state.copyWith(query: query);
}

final shopFilterProvider =
    NotifierProvider<ShopFilterNotifier, ShopFilter>(ShopFilterNotifier.new);

/// 필터가 반영된 상품 목록. 필터 변경 시 자동 재조회.
final productListProvider = FutureProvider<List<Product>>((ref) async {
  final filter = ref.watch(shopFilterProvider);
  return ref.watch(shopRepositoryProvider).fetchProducts(
        species: filter.species,
        query: filter.query,
      );
});

/// 단일 상품 조회.
final productDetailProvider =
    FutureProvider.family<Product, String>((ref, id) async {
  return ref.watch(shopRepositoryProvider).fetchProduct(id);
});

/// 펫 성분 궁합 기반 맞춤 추천.
final recommendedProductsProvider =
    FutureProvider.family<List<Product>, String>((ref, petId) async {
  return ref.watch(shopRepositoryProvider).fetchRecommended(petId);
});

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
