import 'package:json_annotation/json_annotation.dart';

part 'dislike_post_request.g.dart';

@JsonSerializable()
class DislikePostRequest {
  final String postId;
  final String userId;

  DislikePostRequest({
    required this.postId,
    required this.userId,
  });

  factory DislikePostRequest.fromJson(Map<String, dynamic> json) =>
      _$DislikePostRequestFromJson(json);

  Map<String, dynamic> toJson() => _$DislikePostRequestToJson(this);
}
