// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dislike_post_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DislikePostRequest _$DislikePostRequestFromJson(Map<String, dynamic> json) =>
    DislikePostRequest(
      postId: json['postId'] as String,
      userId: json['userId'] as String,
    );

Map<String, dynamic> _$DislikePostRequestToJson(DislikePostRequest instance) =>
    <String, dynamic>{
      'postId': instance.postId,
      'userId': instance.userId,
    };
