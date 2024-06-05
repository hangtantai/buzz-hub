// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_all_user_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserResponse _$UserResponseFromJson(Map<String, dynamic> json) => UserResponse(
      userName: json['userName'] as String,
      fullName: json['fullName'] as String,
      email: json['email'] as String,
      avatarUrl: json['avatarUrl'] as String,
      dob: DateTime.parse(json['dob'] as String),
      gender: json['gender'] as String,
      isFriend: json['isFriend'] as bool,
    );

Map<String, dynamic> _$UserResponseToJson(UserResponse instance) =>
    <String, dynamic>{
      'userName': instance.userName,
      'fullName': instance.fullName,
      'email': instance.email,
      'avatarUrl': instance.avatarUrl,
      'dob': instance.dob.toIso8601String(),
      'gender': instance.gender,
      'isFriend': instance.isFriend,
    };
