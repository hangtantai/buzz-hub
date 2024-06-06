import 'package:json_annotation/json_annotation.dart';

part 'get_post_id_request.g.dart';

@JsonSerializable()
class GetPostByIdRequest {
  final String postId;

  GetPostByIdRequest({required this.postId});

  factory GetPostByIdRequest.fromJson(Map<String, dynamic> json) =>
      _$GetPostByIdRequestFromJson(json);

  Map<String, dynamic> toJson() => _$GetPostByIdRequestToJson(this);
}
