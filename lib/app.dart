import 'package:flutter/material.dart';

import 'core/theme/theme.dart';

/// 펫밀리 앱 루트.
///
/// 디자인 토큰(Theme)을 적용한다. go_router 기반 라우팅(`MaterialApp.router`)은
/// Phase 4에서 붙인다.
class PetmilyApp extends StatelessWidget {
  const PetmilyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '펫밀리',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
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
