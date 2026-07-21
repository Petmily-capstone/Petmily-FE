import 'package:flutter/material.dart';

/// 스플래시. 초기 분기는 Phase 5에서 구현한다.
class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: Center(child: Text('펫밀리')));
  }
}
