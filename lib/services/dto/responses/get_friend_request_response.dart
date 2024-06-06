import 'package:json_annotation/json_annotation.dart';

part 'get_friend_request_response.g.dart';

@JsonSerializable()
class GetFriendRequestResponse {
  final String? userId;
  final String? status;
  final DateTime? sentAt;
  final String? avatar;
  final String? name;


  GetFriendRequestResponse(
    this.userId,
    this.status,
    this.sentAt,
    this.avatar,
    this.name,
  );

  factory GetFriendRequestResponse.fromJson(Map<String, dynamic> json) =>
      _$GetFriendRequestResponseFromJson(json);

  Map<String, dynamic> toJson() => _$GetFriendRequestResponseToJson(this);
}
