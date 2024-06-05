// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'edit_user_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EditUserRequest _$EditUserRequestFromJson(Map<String, dynamic> json) =>
    EditUserRequest(
      fullName: json['fullName'] as String?,
      dob: json['dob'] as String?,
      email: json['email'] as String?,
    );

Map<String, dynamic> _$EditUserRequestToJson(EditUserRequest instance) =>
    <String, dynamic>{
      'fullName': instance.fullName,
      'dob': instance.dob,
      'email': instance.email,
    };
