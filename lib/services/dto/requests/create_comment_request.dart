import 'package:json_annotation/json_annotation.dart';

class CreateCommentRequest {
  final String content;
  final String postId;

  CreateCommentRequest({
    required this.content,
    required this.postId,
  });

  Map<String, String> toJson() {
    return {
      'content': content,
      'postId': postId,
    };
  }
}