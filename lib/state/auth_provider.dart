import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/models/models.dart';
import 'repository_providers.dart';

enum AuthStatus { unknown, authenticated, unauthenticated }

/// 인증 화면 상태.
class AuthState {
  const AuthState({
    this.status = AuthStatus.unknown,
    this.user,
    this.isSubmitting = false,
    this.error,
  });

  final AuthStatus status;
  final AppUser? user;
  final bool isSubmitting;
  final String? error;

  bool get isAuthenticated => status == AuthStatus.authenticated;

  AuthState copyWith({
    AuthStatus? status,
    AppUser? user,
    bool? isSubmitting,
    String? error,
  }) {
    return AuthState(
      status: status ?? this.status,
      user: user ?? this.user,
      isSubmitting: isSubmitting ?? this.isSubmitting,
      // error는 매 액션마다 명시적으로 넘겨 초기화한다.
      error: error,
    );
  }
}

/// 인증 유스케이스. Auth 도메인 전용 provider.
class AuthNotifier extends Notifier<AuthState> {
  @override
  AuthState build() {
    _restoreSession();
    return const AuthState();
  }

  Future<void> _restoreSession() async {
    final user = await ref.read(authRepositoryProvider).currentUser();
    state = AuthState(
      status:
          user == null ? AuthStatus.unauthenticated : AuthStatus.authenticated,
      user: user,
    );
  }

  Future<bool> signInWithEmail(String email, String password) {
    return _run(() =>
        ref.read(authRepositoryProvider).signInWithEmail(email, password));
  }

  Future<bool> signUpWithEmail({
    required String name,
    required String email,
    required String password,
  }) {
    return _run(() => ref.read(authRepositoryProvider).signUpWithEmail(
          name: name,
          email: email,
          password: password,
        ));
  }

  Future<bool> signInWithKakao() =>
      _run(() => ref.read(authRepositoryProvider).signInWithKakao());

  Future<bool> signInWithGoogle() =>
      _run(() => ref.read(authRepositoryProvider).signInWithGoogle());

  Future<void> signOut() async {
    await ref.read(authRepositoryProvider).signOut();
    state = const AuthState(status: AuthStatus.unauthenticated);
  }

  /// 공통 실행 래퍼: 제출중 표시 → 실행 → 성공/에러 상태 반영.
  Future<bool> _run(Future<AppUser> Function() action) async {
    state = state.copyWith(isSubmitting: true);
    try {
      final user = await action();
      state = AuthState(status: AuthStatus.authenticated, user: user);
      return true;
    } catch (e) {
      state = state.copyWith(
        status: AuthStatus.unauthenticated,
        isSubmitting: false,
        error: '요청을 처리하지 못했습니다. 다시 시도해 주세요.',
      );
      return false;
    }
  }
}

final authProvider =
    NotifierProvider<AuthNotifier, AuthState>(AuthNotifier.new);
