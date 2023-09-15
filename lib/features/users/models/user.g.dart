// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_UserProfileModel _$$_UserProfileModelFromJson(Map<String, dynamic> json) =>
    _$_UserProfileModel(
      hasAvatar: json['hasAvatar'] as bool,
      username: json['username'] as String,
      nickname: json['nickname'] as String,
      bio: json['bio'] as String,
      uid: json['uid'] as String,
    );

Map<String, dynamic> _$$_UserProfileModelToJson(_$_UserProfileModel instance) =>
    <String, dynamic>{
      'hasAvatar': instance.hasAvatar,
      'username': instance.username,
      'nickname': instance.nickname,
      'bio': instance.bio,
      'uid': instance.uid,
    };
