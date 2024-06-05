// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'check_status_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CheckStatusRequest _$CheckStatusRequestFromJson(Map<String, dynamic> json) =>
    CheckStatusRequest(
      senderID: json['senderID'] as String,
      receiverID: json['receiverID'] as String,
      status: json['status'] as String,
    );

Map<String, dynamic> _$CheckStatusRequestToJson(CheckStatusRequest instance) =>
    <String, dynamic>{
      'senderID': instance.senderID,
      'receiverID': instance.receiverID,
      'status': instance.status,
    };
