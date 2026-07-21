import 'package:flutter/material.dart';

/// 로그인 화면 스텁. Phase 5에서 실제 UI로 대체한다.
class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('로그인')),
      body: const Center(child: Text('로그인')),
    );
  }
}
