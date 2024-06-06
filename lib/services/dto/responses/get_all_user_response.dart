import 'package:json_annotation/json_annotation.dart';

part 'get_all_user_response.g.dart'; // Rename this file to user_response.g.dart

@JsonSerializable()
class UserResponse {
  final String userName;
  final String fullName;
  final String email;
  final String avatarUrl;
  final DateTime dob;
  final String gender;
  final bool isFriend;

  UserResponse({
    required this.userName,
    required this.fullName,
    required this.email,
    required this.avatarUrl,
    required this.dob,
    required this.gender,
    required this.isFriend,
  });

  factory UserResponse.fromJson(Map<String, dynamic> json) =>
      _$UserResponseFromJson(json);

  Map<String, dynamic> toJson() => _$UserResponseToJson(this);

  // Provide default values for fields that can be null
  UserResponse.withDefaults(Map<String, dynamic> json)
      : userName = json['userName'] ?? '',
        fullName = json['fullName'] ?? '',
        email = json['email'] ?? '',
        avatarUrl = json['avatarUrl'] ?? '',
        dob = DateTime.tryParse(json['dob'] ?? '') ?? DateTime.now(),
        gender = json['gender'] ?? '',
        isFriend = json['isFriend'] ?? false;
}