import 'dart:io';

import 'package:buzz_hub/core/values/constant.dart';
import 'package:buzz_hub/services/base_response.dart';
import 'package:buzz_hub/services/dto/responses/conversation_response.dart';
import 'package:buzz_hub/services/dto/responses/message_response.dart';
import 'package:dio/dio.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ConversationService {
  static const endpoint = 'Conversation';
  Future<List<ConversationResponse>?> getConversation() async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final String? accessToken = prefs.getString(Constants.ACCESS_TOKEN);
      const url = '${Constants.BASE_URL}/$endpoint/';
      final res = await Dio()
          .get(url,
              options: Options(headers: {
                "Content-Type": "application/json",
                "Authorization": "Bearer $accessToken",
              }))
          .then((value) {
        List<dynamic> list = BaseResponse.fromJson(value.data).data;
        List<ConversationResponse> conversations = [];
        for (var i in list) {
          ConversationResponse conversationResponse =
              ConversationResponse.fromJson(i);
          conversations.add(conversationResponse);
        }
        return conversations;
      });
      print(url);
      print(res[0].conversationName);
      return res;
    } catch (e) {
      return null;
    }
  }

  Future<List<MessageResponse>?> getMessagesFromAConversation(
      ConversationResponse conversationResponse) async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final String? accessToken = prefs.getString(Constants.ACCESS_TOKEN);
      var url =
          '${Constants.BASE_URL}/$endpoint/${conversationResponse.conversationType}/${conversationResponse.conversationId}/Messages';
      final res = await Dio()
          .get(url,
              options: Options(headers: {
                "Content-Type": "application/json",
                "Authorization": "Bearer $accessToken",
              }))
          .then((value) {
        List<dynamic> list = BaseResponse.fromJson(value.data).data;
        List<MessageResponse> messages = [];
        for (var i in list) {
          MessageResponse messageResponse = MessageResponse.fromJson(i);
          messages.add(messageResponse);
        }
        return messages;
      });
      return res;
    } catch (e) {
      return null;
    }
  }

  Future<void> sendFileMessage({
    required String conversationId,
    required String messageType,
    required XFile xfile,
  }) async {
    try {
      var url =
          '${Constants.BASE_URL}/$endpoint/Peer/$conversationId/Messages/$messageType';
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final String? accessToken = prefs.getString(Constants.ACCESS_TOKEN);
      print(url);

      File file = File(xfile.path);
      String fileName = file.path.split('/').last;
      FormData formData = FormData.fromMap({
        "file": await MultipartFile.fromFile(file.path, filename: fileName),
      });

      Response response = await Dio().post(url,
          data: formData,
          options: Options(headers: {
            "Content-Type": "application/json",
            "Authorization": "Bearer $accessToken",
          }));
      return;
    } catch (e) {
      return null;
    }
  }
}
