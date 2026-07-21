import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../core/router/routes.dart';
import '../../core/theme/theme.dart';
import '../../core/widgets/widgets.dart';
import '../../state/auth_provider.dart';
import '../../state/pet_provider.dart';
import 'widgets/auth_text_field.dart';

/// 로그인 화면. 이메일/비밀번호 + 소셜(카카오/구글) 로그인.
class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({super.key});

  @override
  ConsumerState<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> {
  final _email = TextEditingController(text: 'demo@petmily.app');
  final _password = TextEditingController(text: 'password');

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    final ok = await ref
        .read(authProvider.notifier)
        .signInWithEmail(_email.text.trim(), _password.text);
    if (ok) await _routeAfterAuth();
  }

  Future<void> _social(Future<bool> Function() action) async {
    final ok = await action();
    if (ok) await _routeAfterAuth();
  }

  /// 로그인 후 최초 1회 분기: 등록된 펫이 없으면 펫 등록, 있으면 홈.
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
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(AppSpacing.xl),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: AppSpacing.xxxl),
              Center(
                child: Container(
                  width: 76,
                  height: 76,
                  decoration: BoxDecoration(
                    gradient: AppColors.headerGradient,
                    borderRadius: BorderRadius.circular(AppRadius.xl),
                  ),
                  child: const Icon(Icons.pets, color: Colors.white, size: 40),
                ),
              ),
              const SizedBox(height: AppSpacing.lg),
              Text(
                '펫밀리에 로그인',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              const SizedBox(height: AppSpacing.xxxl),
              AuthTextField(
                controller: _email,
                label: '이메일',
                hint: 'example@petmily.app',
                keyboardType: TextInputType.emailAddress,
              ),
              const SizedBox(height: AppSpacing.lg),
              AuthTextField(
                controller: _password,
                label: '비밀번호',
                hint: '비밀번호를 입력하세요',
                obscure: true,
              ),
              const SizedBox(height: AppSpacing.xxl),
              PrimaryButton(
                label: '로그인',
                loading: busy,
                onPressed: busy ? null : _submit,
              ),
              const SizedBox(height: AppSpacing.md),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('아직 회원이 아니신가요?',
                      style: TextStyle(color: AppColors.textMuted)),
                  TextButton(
                    onPressed: busy ? null : () => context.push(Routes.signup),
                    child: const Text('회원가입'),
                  ),
                ],
              ),
              const _OrDivider(),
              const SizedBox(height: AppSpacing.lg),
              PrimaryButton(
                label: '카카오로 시작하기',
                icon: Icons.chat_bubble,
                variant: AppButtonVariant.kakao,
                onPressed: busy
                    ? null
                    : () => _social(
                        ref.read(authProvider.notifier).signInWithKakao),
              ),
              const SizedBox(height: AppSpacing.md),
              PrimaryButton(
                label: 'Google로 시작하기',
                icon: Icons.g_mobiledata,
                variant: AppButtonVariant.google,
                onPressed: busy
                    ? null
                    : () => _social(
                        ref.read(authProvider.notifier).signInWithGoogle),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _OrDivider extends StatelessWidget {
  const _OrDivider();

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(vertical: AppSpacing.lg),
      child: Row(
        children: [
          Expanded(child: Divider(color: AppColors.border)),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: AppSpacing.md),
            child: Text('또는', style: TextStyle(color: AppColors.textMuted)),
          ),
          Expanded(child: Divider(color: AppColors.border)),
        ],
      ),
    );
  }
}
