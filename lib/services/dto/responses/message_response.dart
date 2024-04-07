

import 'package:buzz_hub/services/dto/responses/reaction_response.dart';
import 'package:json_annotation/json_annotation.dart';

part 'message_response.g.dart';

@JsonSerializable()
class MessageResponse {
  final String? messageId;
  final String? senderId;
  final String? messageType;
  final String? content;
  final String? groupId;
  final String? senderName;
  final String? senderAvatar;
  final List<ReactionResponse>? reactions;
  

  MessageResponse({
     this.messageId,
     this.senderId,
     this.messageType,
     this.content,
    this.groupId,
    this.senderName,
    this.senderAvatar,
    this.reactions,
  });

  factory MessageResponse.fromJson(Map<String, dynamic> json) =>
      _$MessageResponseFromJson(json);

  Map<String, dynamic> toJson() => _$MessageResponseToJson(this);
}