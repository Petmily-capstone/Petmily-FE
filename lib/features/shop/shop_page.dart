import 'package:flutter/material.dart';

/// 쇼핑 화면 스텁. Phase 5에서 실제 UI로 대체한다.
class ShopPage extends StatelessWidget {
  const ShopPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('쇼핑')),
      body: const Center(child: Text('쇼핑')),
    );
  }
}
