import 'package:buzz_hub/services/dto/responses/current_user_response.dart';
import 'package:json_annotation/json_annotation.dart';

part 'post_response.g.dart';

@JsonSerializable()
class PostResponse {
  final String? postId;
  final String? textContent;
  final List<String>? imageContent;
  final CurrentUserResponse? author;
  final DateTime? createdAt;

  PostResponse({
     this.postId,
     this.textContent,
     this.imageContent,
     this.author,
     this.createdAt,
  });

  factory PostResponse.fromJson(Map<String, dynamic> json) =>
      _$PostResponseFromJson(json);

  Map<String, dynamic> toJson() => _$PostResponseToJson(this);
}
