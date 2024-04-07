// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'conversation_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ConversationResponse _$ConversationResponseFromJson(
        Map<String, dynamic> json) =>
    ConversationResponse(
      conversationId: json['conversationId'] as String,
      conversationName: json['conversationName'] as String,
      conversationAvatar: json['conversationAvatar'] as String,
      lastMessage:
          MessageResponse.fromJson(json['lastMessage'] as Map<String, dynamic>),
      conversationType: json['conversationType'] as String,
      isFriend: json['isFriend'] as bool,
    );

Map<String, dynamic> _$ConversationResponseToJson(
        ConversationResponse instance) =>
    <String, dynamic>{
      'conversationId': instance.conversationId,
      'conversationName': instance.conversationName,
      'conversationAvatar': instance.conversationAvatar,
      'lastMessage': instance.lastMessage,
      'conversationType': instance.conversationType,
      'isFriend': instance.isFriend,
    };
