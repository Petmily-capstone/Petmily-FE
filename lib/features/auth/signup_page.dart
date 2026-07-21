import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../core/router/routes.dart';
import '../../core/theme/theme.dart';
import '../../core/widgets/widgets.dart';
import '../../state/auth_provider.dart';
import 'widgets/auth_text_field.dart';

/// 회원가입 화면. 이름/이메일/비밀번호로 가입 후 펫 등록으로 이동.
class SignupPage extends ConsumerStatefulWidget {
  const SignupPage({super.key});

  @override
  ConsumerState<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends ConsumerState<SignupPage> {
  final _name = TextEditingController();
  final _email = TextEditingController();
  final _password = TextEditingController();
  String? _validationError;

  @override
  void dispose() {
    _name.dispose();
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    final name = _name.text.trim();
    final email = _email.text.trim();
    final password = _password.text;
    if (name.isEmpty || email.isEmpty || password.length < 4) {
      setState(() =>
          _validationError = '이름/이메일을 입력하고 비밀번호는 4자 이상이어야 합니다.');
      return;
    }
    setState(() => _validationError = null);

    final ok = await ref.read(authProvider.notifier).signUpWithEmail(
          name: name,
          email: email,
          password: password,
        );
    // 신규 가입은 펫 등록 화면으로 유도.
    if (ok && mounted) context.go(Routes.petSetup);
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
      appBar: AppBar(
        foregroundColor: AppColors.textStrong,
        backgroundColor: AppColors.background,
        title: const Text('회원가입'),
      ),
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(AppSpacing.xl),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: AppSpacing.lg),
              AuthTextField(controller: _name, label: '이름', hint: '홍길동'),
              const SizedBox(height: AppSpacing.lg),
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
                hint: '4자 이상',
                obscure: true,
              ),
              if (_validationError != null) ...[
                const SizedBox(height: AppSpacing.md),
                Text(
                  _validationError!,
                  style: const TextStyle(
                    color: AppColors.danger,
                    fontSize: 13,
                  ),
                ),
              ],
              const SizedBox(height: AppSpacing.xxl),
              PrimaryButton(
                label: '가입하고 시작하기',
                loading: busy,
                onPressed: busy ? null : _submit,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
