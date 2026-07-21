import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../core/router/routes.dart';
import '../../core/theme/theme.dart';
import '../../state/auth_provider.dart';

/// 스플래시.
///
/// 로고를 잠깐 보여준 뒤 인증 상태에 따라 초기 화면으로 분기한다.
/// (인증됨 → 홈, 아니면 → 온보딩)
class SplashPage extends ConsumerStatefulWidget {
  const SplashPage({super.key});

  @override
  ConsumerState<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends ConsumerState<SplashPage> {
  bool _minDelayPassed = false;

  @override
  void initState() {
    super.initState();
    // 최소 노출 시간 확보(로고 깜빡임 방지).
    Future.delayed(const Duration(milliseconds: 1300), () {
      if (!mounted) return;
      setState(() => _minDelayPassed = true);
      _maybeGo();
    });
  }

  void _maybeGo() {
    if (!_minDelayPassed) return;
    final status = ref.read(authProvider).status;
    if (status == AuthStatus.unknown) return; // 세션 복원 대기
    context.go(
      status == AuthStatus.authenticated ? Routes.home : Routes.onboarding,
    );
  }

  @override
  Widget build(BuildContext context) {
    // 세션 복원이 끝나면(=unknown 탈출) 분기 시도.
    ref.listen(authProvider.select((s) => s.status), (_, _) => _maybeGo());

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(gradient: AppColors.headerGradient),
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 96,
              height: 96,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(AppRadius.xxl),
                boxShadow: AppShadows.card,
              ),
              child: const Icon(
                Icons.pets,
                size: 52,
                color: AppColors.primary,
              ),
            ),
            const SizedBox(height: AppSpacing.xl),
            const Text(
              '펫밀리',
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.w800,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: AppSpacing.sm),
            const Text(
              '우리 아이의 매일을 함께',
              style: TextStyle(fontSize: 15, color: Colors.white70),
            ),
            const SizedBox(height: AppSpacing.xxxl),
            const SizedBox(
              width: 26,
              height: 26,
              child: CircularProgressIndicator(
                strokeWidth: 2.4,
                valueColor: AlwaysStoppedAnimation(Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
