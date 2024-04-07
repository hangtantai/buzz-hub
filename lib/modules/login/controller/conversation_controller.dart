import 'package:buzz_hub/core/values/constant.dart';
import 'package:buzz_hub/services/auth_service.dart';
import 'package:buzz_hub/services/conversation_service.dart';
import 'package:buzz_hub/services/dto/requests/login_request.dart';
import 'package:buzz_hub/services/dto/responses/conversation_response.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ConversationController extends GetxController {
  RxList<ConversationResponse> listConversation = RxList<ConversationResponse>([]);

  @override
  void onInit() async {
    super.onInit();
    listConversation.value = await onLoadConversation() ?? [];
  }

  Future<List<ConversationResponse>?> onLoadConversation() async {
    ConversationService conversationService = ConversationService();
    final res = await conversationService.getConversation();
    if (res == null) {
      return null;
    }
    return res;
  }
}
