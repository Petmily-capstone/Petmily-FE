import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../core/router/routes.dart';
import '../../core/theme/theme.dart';
import '../../core/widgets/widgets.dart';
import '../../state/auth_provider.dart';
import '../../state/pet_provider.dart';

/// 로그인 화면. 카카오 소셜 로그인만 제공한다.
class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({super.key});

  @override
  ConsumerState<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> {
  Future<void> _signInWithKakao() async {
    final ok = await ref.read(authProvider.notifier).signInWithKakao();
    if (!ok) return;
    await _routeAfterAuth();
  }

  /// 로그인 후 최초 1회 분기: 등록된 펫이 없으면 펫 등록, 있으면 홈.
  ///
  /// TODO: 신규 회원(isNewUser)은 추가 정보 입력 화면으로 보내는 분기 추가.
  Future<void> _routeAfterAuth() async {
    final petState = await ref.read(petProvider.future);
    if (!mounted) return;
    context.go(petState.pets.isEmpty ? Routes.petSetup : Routes.home);
  }

  @override
  Widget build(BuildContext context) {
    final busy = ref.watch(authProvider.select((s) => s.isSubmitting));

    ref.listen(authProvider.select((s) => s.error), (_, error) {
      if (error != null) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(error)));
      }
    });

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.xl),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Spacer(flex: 2),
              Center(
                child: Container(
                  width: 96,
                  height: 96,
                  decoration: BoxDecoration(
                    gradient: AppColors.headerGradient,
                    borderRadius: BorderRadius.circular(AppRadius.xxl),
                  ),
                  child: const Icon(Icons.pets, color: Colors.white, size: 48),
                ),
              ),
              const SizedBox(height: AppSpacing.xl),
              Text(
                '펫밀리',
                textAlign: TextAlign.center,
                style: Theme.of(context)
                    .textTheme
                    .headlineMedium
                    ?.copyWith(fontWeight: FontWeight.w800),
              ),
              const SizedBox(height: AppSpacing.sm),
              const Text(
                '우리 아이의 매일을 함께',
                textAlign: TextAlign.center,
                style: TextStyle(color: AppColors.textMuted, fontSize: 15),
              ),
              const Spacer(flex: 3),
              PrimaryButton(
                label: '카카오로 시작하기',
                icon: Icons.chat_bubble,
                variant: AppButtonVariant.kakao,
                loading: busy,
                onPressed: busy ? null : _signInWithKakao,
              ),
              const SizedBox(height: AppSpacing.md),
              const Text(
                '카카오 계정으로 간편하게 시작하세요',
                textAlign: TextAlign.center,
                style: TextStyle(color: AppColors.textMuted, fontSize: 12),
              ),
              const SizedBox(height: AppSpacing.xl),
            ],
          ),
        ),
      ),
    );
  }
}
