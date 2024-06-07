// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PostResponse _$PostResponseFromJson(Map<String, dynamic> json) => PostResponse(
      postId: json['postId'] as int?,
      textContent: json['textContent'] as String?,
      imageContent: (json['imageContent'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      author: json['author'] == null
          ? null
          : CurrentUserResponse.fromJson(
              json['author'] as Map<String, dynamic>),
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
    );

Map<String, dynamic> _$PostResponseToJson(PostResponse instance) =>
    <String, dynamic>{
      'postId': instance.postId,
      'textContent': instance.textContent,
      'imageContent': instance.imageContent,
      'author': instance.author,
      'createdAt': instance.createdAt?.toIso8601String(),
    };
