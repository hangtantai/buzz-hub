import 'package:buzz_hub/core/values/constant.dart';
import 'package:buzz_hub/services/auth_service.dart';
import 'package:buzz_hub/services/conversation_service.dart';
import 'package:buzz_hub/services/dto/requests/login_request.dart';
import 'package:buzz_hub/services/dto/responses/conversation_response.dart';
import 'package:buzz_hub/services/dto/responses/current_user_response.dart';
import 'package:buzz_hub/services/dto/responses/get_friend_request_response.dart';
import 'package:buzz_hub/services/friend_request_service.dart';
import 'package:buzz_hub/services/friend_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FriendRequestController extends GetxController {
  RxList<GetFriendRequestResponse> listRequest =
      RxList<GetFriendRequestResponse>([]);
  RxList<CurrentUserResponse> listFriend = RxList<CurrentUserResponse>([]);

  @override
  void onInit() async {
    super.onInit();
    listRequest.value = await onLoadRequest() ?? [];
    //listFriend.value = await onLoadFriend() ?? [];
  }
  Future<bool>onDecline(String userName) async{
 FriendRequestService friendRequestService = FriendRequestService();
    bool res = await friendRequestService.declineFriendRequest(userName);

    return res;
  }
  Future<bool> onAccept(String userName) async{
    FriendRequestService friendRequestService = FriendRequestService();
    final res = await friendRequestService.acceptFriendRequest(userName);
    return res;
  }
  Future<List<GetFriendRequestResponse>?> onLoadRequest() async {
    FriendRequestService friendRequestService = FriendRequestService();
    final res = await friendRequestService.getAllFriendRequest();
    if (res == null) {
      return null;
    }
    return res;
  }

  // Future<List<CurrentUserResponse>?> onLoadFriend() async {
  //   FriendService friendService = FriendService();
  //   final res = await friendService.getAllFriend();
  //   if (res == null) {
  //     return null;
  //   }
  //   return res;
  // }
}
