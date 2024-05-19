// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'current_user_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CurrentUserResponse _$CurrentUserResponseFromJson(Map<String, dynamic> json) =>
    CurrentUserResponse(
      json['userName'] as String?,
      json['fullName'] as String?,
      json['email'] as String?,
      json['avatarUrl'] as String?,
      json['dob'] == null ? null : DateTime.parse(json['dob'] as String),
      json['gender'] as String?,
      json['isFriend'] as bool?,
    );

Map<String, dynamic> _$CurrentUserResponseToJson(
        CurrentUserResponse instance) =>
    <String, dynamic>{
      'userName': instance.userName,
      'fullName': instance.fullName,
      'email': instance.email,
      'avatarUrl': instance.avatarUrl,
      'dob': instance.dob?.toIso8601String(),
      'gender': instance.gender,
      'isFriend': instance.isFriend,
    };
