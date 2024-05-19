import 'package:json_annotation/json_annotation.dart';

part 'current_user_response.g.dart';

@JsonSerializable()
class CurrentUserResponse {
  final String? userName;
  final String? fullName;
  final String? email;
  final String? avatarUrl;
  final DateTime? dob;
  final String? gender;
  final bool? isFriend;

  CurrentUserResponse(
    this.userName,
    this.fullName,
    this.email,
    this.avatarUrl,
    this.dob,
    this.gender,
    this.isFriend,
  );

  factory CurrentUserResponse.fromJson(Map<String, dynamic> json) =>
      _$CurrentUserResponseFromJson(json);

  Map<String, dynamic> toJson() => _$CurrentUserResponseToJson(this);
}
