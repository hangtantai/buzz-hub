// // GENERATED CODE - DO NOT MODIFY BY HAND

// part of 'post_user_response.dart';

// // **************************************************************************
// // JsonSerializableGenerator
// // **************************************************************************

// PostUserResponse _$PostUserResponseFromJson(Map<String, dynamic> json) =>
//     PostUserResponse(
//       id: (json['id'] as num?)?.toInt(),
//       textContent: json['textContent'] as String?,
//       imageContent: (json['imageContent'] as List<dynamic>?)
//           ?.map((e) => e as String)
//           .toList(),
//       authorName: json['authorName'] as String?,
//       createdAt: json['createdAt'] == null
//           ? null
//           : DateTime.parse(json['createdAt'] as String),
//     );

// Map<String, dynamic> _$PostUserResponseToJson(PostUserResponse instance) =>
//     <String, dynamic>{
//       'id': instance.id,
//       'textContent': instance.textContent,
//       'imageContent': instance.imageContent,
//       'authorName': instance.authorName,
//       'createdAt': instance.createdAt?.toIso8601String(),
//     };
