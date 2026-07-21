import 'package:flutter/material.dart';

/// 마이페이지 화면 스텁. Phase 5에서 실제 UI로 대체한다.
class MyPage extends StatelessWidget {
  const MyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('마이페이지')),
      body: const Center(child: Text('마이페이지')),
    );
  }
}
