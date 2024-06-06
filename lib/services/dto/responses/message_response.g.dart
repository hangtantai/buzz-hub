// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'message_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MessageResponse _$MessageResponseFromJson(Map<String, dynamic> json) =>
    MessageResponse(
      messageId: json['messageId'] as String?,
      senderId: json['senderId'] as String?,
      messageType: json['messageType'] as String?,
      content: json['content'] as String?,
      groupId: json['groupId'] as String?,
      senderName: json['senderName'] as String?,
      senderAvatar: json['senderAvatar'] as String?,
      sentAt: json['sentAt'] == null
          ? null
          : DateTime.parse(json['sentAt'] as String),
    );

Map<String, dynamic> _$MessageResponseToJson(MessageResponse instance) =>
    <String, dynamic>{
      'messageId': instance.messageId,
      'senderId': instance.senderId,
      'messageType': instance.messageType,
      'content': instance.content,
      'groupId': instance.groupId,
      'senderName': instance.senderName,
      'senderAvatar': instance.senderAvatar,
      'sentAt': instance.sentAt?.toIso8601String(),
    };
