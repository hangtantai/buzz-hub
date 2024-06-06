// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'like_post_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LikePostRequest _$LikePostRequestFromJson(Map<String, dynamic> json) =>
    LikePostRequest(
      postId: json['postId'] as String,
      userId: json['userId'] as String,
    );

Map<String, dynamic> _$LikePostRequestToJson(LikePostRequest instance) =>
    <String, dynamic>{
      'postId': instance.postId,
      'userId': instance.userId,
    };
