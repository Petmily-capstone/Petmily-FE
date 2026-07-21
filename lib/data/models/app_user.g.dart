// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_AppUser _$AppUserFromJson(Map<String, dynamic> json) => _AppUser(
  id: json['id'] as String,
  email: json['email'] as String,
  name: json['name'] as String,
  provider:
      $enumDecodeNullable(_$AuthProviderEnumMap, json['provider']) ??
      AuthProvider.email,
  avatarUrl: json['avatarUrl'] as String?,
);

Map<String, dynamic> _$AppUserToJson(_AppUser instance) => <String, dynamic>{
  'id': instance.id,
  'email': instance.email,
  'name': instance.name,
  'provider': _$AuthProviderEnumMap[instance.provider]!,
  'avatarUrl': instance.avatarUrl,
};

const _$AuthProviderEnumMap = {
  AuthProvider.email: 'email',
  AuthProvider.kakao: 'kakao',
  AuthProvider.google: 'google',
};
