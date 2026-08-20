import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../core/config/app_config.dart';
import '../../core/router/routes.dart';
import '../../core/theme/theme.dart';
import '../../core/widgets/widgets.dart';
import '../../state/auth_provider.dart';
import '../../state/pet_provider.dart';
import 'kakao_webview_page.dart';

/// 로그인 화면. 카카오 소셜 로그인만 제공한다.
class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({super.key});

  @override
  ConsumerState<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> {
  Future<void> _signInWithKakao() async {
    // 1) 인가 코드 획득. 목 모드에선 WebView 없이 더미 코드로 흐름만 태운다.
    String code = 'mock-code';
    if (!AppConfig.dev.useMock) {
      final captured = await Navigator.of(context).push<String>(
        MaterialPageRoute(builder: (_) => const KakaoAuthWebView()),
      );
      if (captured == null) return; // 사용자가 취소
      code = captured;
    }

    // 2) 코드를 서버에 넘겨 세션 발급.
    final result = await ref.read(authProvider.notifier).loginWithKakao(code);
    if (result == null || !mounted) return;

    // 3) 신규/기존 분기.
    await _routeAfterAuth(isNewUser: result.isNewUser);
  }

  /// 로그인 후 라우팅.
  ///
  /// 신규 회원은 온보딩(펫 등록)부터 시작. 기존 회원은 등록된 펫 유무로 홈/펫등록 분기.
  /// TODO: 신규 회원 추가정보 입력 화면이 필요해지면 여기서 분기.
  Future<void> _routeAfterAuth({required bool isNewUser}) async {
    if (isNewUser) {
      if (mounted) context.go(Routes.petSetup);
      return;
    }
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
