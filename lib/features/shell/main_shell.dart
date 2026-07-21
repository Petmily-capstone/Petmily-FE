import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../core/widgets/widgets.dart';

/// 메인 탭 셸. 하단 [AppBottomNav]로 홈/진단/쇼핑/마이 탭을 전환한다.
///
/// 각 탭은 독립 네비게이션 스택을 갖는다(StatefulShellRoute.indexedStack).
class MainShell extends StatelessWidget {
  const MainShell({super.key, required this.navigationShell});

  final StatefulNavigationShell navigationShell;

  static const _items = [
    AppBottomNavItem(icon: Icons.home_rounded, label: '홈'),
    AppBottomNavItem(icon: Icons.medical_services_outlined, label: 'AI 진단'),
    AppBottomNavItem(icon: Icons.shopping_bag_outlined, label: '쇼핑'),
    AppBottomNavItem(icon: Icons.person_outline_rounded, label: '마이'),
  ];

  void _onTap(int index) {
    // 같은 탭 재선택 시 해당 탭의 스택을 초기화한다.
    navigationShell.goBranch(
      index,
      initialLocation: index == navigationShell.currentIndex,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: navigationShell,
      bottomNavigationBar: AppBottomNav(
        currentIndex: navigationShell.currentIndex,
        items: _items,
        onTap: _onTap,
      ),
    );
  }
}
