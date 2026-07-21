import 'package:flutter/material.dart';

import 'core/router/app_router.dart';
import 'core/theme/theme.dart';

/// 펫밀리 앱 루트. go_router 기반 라우팅 + 디자인 토큰 테마.
class PetmilyApp extends StatelessWidget {
  const PetmilyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: '펫밀리',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      routerConfig: appRouter,
    );
  }
}
