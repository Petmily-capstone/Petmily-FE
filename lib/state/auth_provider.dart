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
      status: user == null
          ? AuthStatus.unauthenticated
          : AuthStatus.authenticated,
      user: user,
    );
  }

  /// 카카오 인가 코드로 로그인한다.
  ///
  /// 성공 시 [AuthResult](신규회원 여부 포함)를 반환하고, 실패 시 null.
  /// 화면은 반환값의 [AuthResult.isNewUser]로 이후 라우팅을 분기한다.
  Future<AuthResult?> loginWithKakao(String code) async {
    state = state.copyWith(isSubmitting: true);
    try {
      final result = await ref
          .read(authRepositoryProvider)
          .signInWithKakao(code);
      state = AuthState(
        status: AuthStatus.authenticated,
        user: AppUser(
          id: '${result.userId}',
          name: result.nickname,
          email: '',
          provider: AuthProvider.kakao,
        ),
      );
      return result;
    } catch (e) {
      state = state.copyWith(
        status: AuthStatus.unauthenticated,
        isSubmitting: false,
        error: '카카오 로그인에 실패했습니다. 다시 시도해 주세요.',
      );
      return null;
    }
  }

  Future<void> signOut() async {
    await ref.read(authRepositoryProvider).signOut();
    state = const AuthState(status: AuthStatus.unauthenticated);
  }

  /// 표시 이름을 변경한다.
  Future<void> updateDisplayName(String name) async {
    final trimmed = name.trim();
    if (trimmed.isEmpty) return;
    final user = await ref
        .read(authRepositoryProvider)
        .updateDisplayName(trimmed);
    state = state.copyWith(user: user);
  }
}

final authProvider = NotifierProvider<AuthNotifier, AuthState>(
  AuthNotifier.new,
);
