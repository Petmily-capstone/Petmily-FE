import 'package:flutter/material.dart';

/// 홈 화면 스텁. Phase 5에서 실제 UI로 대체한다.
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('홈')),
      body: const Center(child: Text('홈')),
    );
  }
}
