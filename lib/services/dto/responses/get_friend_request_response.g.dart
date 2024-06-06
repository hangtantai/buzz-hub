// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_friend_request_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetFriendRequestResponse _$GetFriendRequestResponseFromJson(
        Map<String, dynamic> json) =>
    GetFriendRequestResponse(
      json['userId'] as String?,
      json['status'] as String?,
      json['sentAt'] == null ? null : DateTime.parse(json['sentAt'] as String),
      json['avatar'] as String?,
      json['name'] as String?,
    );

Map<String, dynamic> _$GetFriendRequestResponseToJson(
        GetFriendRequestResponse instance) =>
    <String, dynamic>{
      'userId': instance.userId,
      'status': instance.status,
      'sentAt': instance.sentAt?.toIso8601String(),
      'avatar': instance.avatar,
      'name': instance.name,
    };
