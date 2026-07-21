import 'package:freezed_annotation/freezed_annotation.dart';

import 'enums.dart';

part 'app_user.freezed.dart';
part 'app_user.g.dart';

/// 로그인 사용자.
@freezed
abstract class AppUser with _$AppUser {
  const factory AppUser({
    required String id,
    required String email,
    required String name,
    @Default(AuthProvider.email) AuthProvider provider,
    String? avatarUrl,
  }) = _AppUser;

  factory AppUser.fromJson(Map<String, dynamic> json) =>
      _$AppUserFromJson(json);
}
