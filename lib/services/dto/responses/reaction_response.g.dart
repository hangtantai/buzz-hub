// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reaction_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ReactionResponse _$ReactionResponseFromJson(Map<String, dynamic> json) =>
    ReactionResponse(
      senderId: json['senderId'] as String,
      messageId: json['messageId'] as String,
      type: json['type'] as String,
      conversationId: json['conversationId'] as String,
      senderName: json['senderName'] as String,
      senderAvatar: json['senderAvatar'] as String,
    );

Map<String, dynamic> _$ReactionResponseToJson(ReactionResponse instance) =>
    <String, dynamic>{
      'senderId': instance.senderId,
      'messageId': instance.messageId,
      'type': instance.type,
      'conversationId': instance.conversationId,
      'senderName': instance.senderName,
      'senderAvatar': instance.senderAvatar,
    };
