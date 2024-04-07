import 'package:buzz_hub/core/values/constant.dart';
import 'package:buzz_hub/services/base_response.dart';
import 'package:buzz_hub/services/dto/responses/conversation_response.dart';
import 'package:dio/dio.dart';
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
}
