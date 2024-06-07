import 'package:buzz_hub/services/dto/responses/current_user_response.dart';
import 'package:json_annotation/json_annotation.dart';

part 'post_user_response.g.dart';

@JsonSerializable()
class PostUserResponse {
  final int? id;
  final String? textContent;
  final List<String>? imageContent;
  final String? authorName;
  final DateTime? createdAt;

  PostUserResponse({
     this.id,
     this.textContent,
     this.imageContent,
     this.authorName,
     this.createdAt,
  });

  factory PostUserResponse.fromJson(Map<String, dynamic> json) =>
      _$PostUserResponseFromJson(json);

  Map<String, dynamic> toJson() => _$PostUserResponseToJson(this);
}
