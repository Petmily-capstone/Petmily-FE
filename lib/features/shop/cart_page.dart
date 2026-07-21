import 'package:flutter/material.dart';

/// 장바구니 화면 스텁. Phase 5에서 실제 UI로 대체한다.
class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('장바구니')),
      body: const Center(child: Text('장바구니')),
    );
  }
}
