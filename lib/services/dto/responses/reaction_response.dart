import 'package:json_annotation/json_annotation.dart';

part 'reaction_response.g.dart';

@JsonSerializable()
class ReactionResponse {
  final String senderId;
  final String messageId;
  final String type;
  final String conversationId;
  final String senderName;
  final String senderAvatar;

  ReactionResponse({
    required this.senderId,
    required this.messageId,
    required this.type,
    required this.conversationId,
    required this.senderName,
    required this.senderAvatar,
  });

  factory ReactionResponse.fromJson(Map<String, dynamic> json) =>
      _$ReactionResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ReactionResponseToJson(this);
}