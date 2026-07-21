import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../features/auth/login_page.dart';
import '../../features/auth/signup_page.dart';
import '../../features/diagnosis/diagnosis_page.dart';
import '../../features/home/home_page.dart';
import '../../features/mypage/mypage_page.dart';
import '../../features/onboarding/onboarding_page.dart';
import '../../features/pet_setup/pet_setup_page.dart';
import '../../features/shell/main_shell.dart';
import '../../features/shop/cart_page.dart';
import '../../features/shop/product_detail_page.dart';
import '../../features/shop/shop_page.dart';
import '../../features/splash/splash_page.dart';
import 'routes.dart';

/// 각 탭 스택용 네비게이터 키.
final _rootKey = GlobalKey<NavigatorState>();
final _homeKey = GlobalKey<NavigatorState>();
final _diagnosisKey = GlobalKey<NavigatorState>();
final _shopKey = GlobalKey<NavigatorState>();
final _mypageKey = GlobalKey<NavigatorState>();

/// 앱 라우터. 스플래시 → 온보딩/인증 → 메인 탭 셸.
final appRouter = GoRouter(
  navigatorKey: _rootKey,
  initialLocation: Routes.splash,
  routes: [
    GoRoute(
      path: Routes.splash,
      builder: (_, _) => const SplashPage(),
    ),
    GoRoute(
      path: Routes.onboarding,
      builder: (_, _) => const OnboardingPage(),
    ),
    GoRoute(
      path: Routes.login,
      builder: (_, _) => const LoginPage(),
    ),
    GoRoute(
      path: Routes.signup,
      builder: (_, _) => const SignupPage(),
    ),
    GoRoute(
      path: Routes.petSetup,
      builder: (_, _) => const PetSetupPage(),
    ),
    GoRoute(
      path: Routes.cart,
      builder: (_, _) => const CartPage(),
    ),
    // 메인 탭 셸: 탭별 독립 스택.
    StatefulShellRoute.indexedStack(
      builder: (_, _, shell) => MainShell(navigationShell: shell),
      branches: [
        StatefulShellBranch(
          navigatorKey: _homeKey,
          routes: [
            GoRoute(path: Routes.home, builder: (_, _) => const HomePage()),
          ],
        ),
        StatefulShellBranch(
          navigatorKey: _diagnosisKey,
          routes: [
            GoRoute(
              path: Routes.diagnosis,
              builder: (_, _) => const DiagnosisPage(),
            ),
          ],
        ),
        StatefulShellBranch(
          navigatorKey: _shopKey,
          routes: [
            GoRoute(
              path: Routes.shop,
              builder: (_, _) => const ShopPage(),
              routes: [
                GoRoute(
                  path: ':id',
                  parentNavigatorKey: _rootKey, // 상세는 셸 위에 전체 화면으로.
                  builder: (_, state) => ProductDetailPage(
                    productId: state.pathParameters['id']!,
                  ),
                ),
              ],
            ),
          ],
        ),
        StatefulShellBranch(
          navigatorKey: _mypageKey,
          routes: [
            GoRoute(path: Routes.mypage, builder: (_, _) => const MyPage()),
          ],
        ),
      ],
    ),
  ],
);
