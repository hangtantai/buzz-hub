import 'package:buzz_hub/core/values/constant.dart';
import 'package:buzz_hub/services/auth_service.dart';
import 'package:buzz_hub/services/conversation_service.dart';
import 'package:buzz_hub/services/dto/requests/login_request.dart';
import 'package:buzz_hub/services/dto/responses/conversation_response.dart';
import 'package:buzz_hub/services/dto/responses/current_user_response.dart';
import 'package:buzz_hub/services/friend_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ConversationController extends GetxController {
  RxList<ConversationResponse> listConversation =
      RxList<ConversationResponse>([]);
  RxList<CurrentUserResponse> listFriend = RxList<CurrentUserResponse>([]);

  @override
  void onInit() async {
    super.onInit();
    listConversation.value = await onLoadConversation() ?? [];
    listFriend.value = await onLoadFriend() ?? [];
  }

  Future<List<ConversationResponse>?> onLoadConversation() async {
    ConversationService conversationService = ConversationService();
    final res = await conversationService.getConversation();
    if (res == null) {
      return null;
    }
    return res;
  }

  Future<List<CurrentUserResponse>?> onLoadFriend() async {
    FriendService friendService = FriendService();
    final res = await friendService.getAllFriend();
    if (res == null) {
      return null;
    }
    return res;
  }
}
