import 'package:buzz_hub/services/dto/responses/message_response.dart';
import 'package:json_annotation/json_annotation.dart';

part 'conversation_response.g.dart';

@JsonSerializable()
class ConversationResponse {
  final String conversationId;
  final String conversationName;
  final String conversationAvatar;
  final MessageResponse lastMessage;
  final String conversationType;
  final bool isFriend;

  ConversationResponse({
    required this.conversationId,
    required this.conversationName,
    required this.conversationAvatar,
    required this.lastMessage,
    required this.conversationType,
    required this.isFriend,
  });

  factory ConversationResponse.fromJson(Map<String, dynamic> json) =>
      _$ConversationResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ConversationResponseToJson(this);
}