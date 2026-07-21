import 'package:flutter/material.dart';

/// 상품 상세 화면 스텁. Phase 5에서 실제 UI로 대체한다.
class ProductDetailPage extends StatelessWidget {
  const ProductDetailPage({super.key, required this.productId});

  final String productId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('상품 상세')),
      body: Center(child: Text('상품 상세: $productId')),
    );
  }
}
