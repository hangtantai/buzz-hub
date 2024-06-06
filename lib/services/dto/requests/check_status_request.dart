import 'package:json_annotation/json_annotation.dart';

part 'check_status_request.g.dart';

@JsonSerializable()
class CheckStatusRequest {
  final String senderID;
  final String receiverID;
  final String status;

  CheckStatusRequest({
    required this.senderID,
    required this.receiverID,
    required this.status,
  });

  factory CheckStatusRequest.fromJson(Map<String, dynamic> json) =>
      _$CheckStatusRequestFromJson(json);

  Map<String, dynamic> toJson() => _$CheckStatusRequestToJson(this);
}