import 'package:json_annotation/json_annotation.dart';

part 'like_post_request.g.dart';

@JsonSerializable()
class LikePostRequest {
  final String postId;
  final String userId;

  LikePostRequest({
    required this.postId,
    required this.userId,
  });

  factory LikePostRequest.fromJson(Map<String, dynamic> json) =>
      _$LikePostRequestFromJson(json);

  Map<String, dynamic> toJson() => _$LikePostRequestToJson(this);
}
