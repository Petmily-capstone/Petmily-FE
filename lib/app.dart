import 'package:flutter/material.dart';

/// 펫밀리 앱 루트.
///
/// 지금은 진입점 골격만 둔다. 디자인 토큰(Theme)은 Phase 1,
/// go_router 기반 라우팅(`MaterialApp.router`)은 Phase 4에서 붙인다.
class PetmilyApp extends StatelessWidget {
  const PetmilyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '펫밀리',
      debugShowCheckedModeBanner: false,
      home: const _BootstrapScreen(),
    );
  }
}

class _BootstrapScreen extends StatelessWidget {
  const _BootstrapScreen();

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: Text('펫밀리')),
    );
  }
}
