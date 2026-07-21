import 'package:flutter/material.dart';

/// 온보딩 화면 스텁. Phase 5에서 실제 UI로 대체한다.
class OnboardingPage extends StatelessWidget {
  const OnboardingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('온보딩')),
      body: const Center(child: Text('온보딩')),
    );
  }
}
