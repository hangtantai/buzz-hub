import 'package:json_annotation/json_annotation.dart';

part 'count_like_post_request.g.dart';

@JsonSerializable()
class CountLikePostRequest {
  final String postId;

  CountLikePostRequest({required this.postId});

  factory CountLikePostRequest.fromJson(Map<String, dynamic> json) =>
      _$CountLikePostRequestFromJson(json);

  Map<String, dynamic> toJson() => _$CountLikePostRequestToJson(this);
}
