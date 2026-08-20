// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_result.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_AuthResult _$AuthResultFromJson(Map<String, dynamic> json) => _AuthResult(
  accessToken: json['accessToken'] as String,
  refreshToken: json['refreshToken'] as String,
  userId: (json['userId'] as num).toInt(),
  nickname: json['nickname'] as String,
  isNewUser: json['isNewUser'] as bool,
);

Map<String, dynamic> _$AuthResultToJson(_AuthResult instance) =>
    <String, dynamic>{
      'accessToken': instance.accessToken,
      'refreshToken': instance.refreshToken,
      'userId': instance.userId,
      'nickname': instance.nickname,
      'isNewUser': instance.isNewUser,
    };
