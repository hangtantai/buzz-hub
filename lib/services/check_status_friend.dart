import 'package:buzz_hub/core/values/constant.dart';
import 'package:buzz_hub/services/base_response.dart';
import 'package:buzz_hub/services/dto/requests/check_status_request.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';



class CheckFriendStatusService {
  static const endpoint = 'Request/Status';
  Future<bool?> checkFriendStatus(String username) async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final String? accessToken = prefs.getString(Constants.ACCESS_TOKEN);
      final url = '${Constants.BASE_URL}/$endpoint/$username';

      final response = await Dio().get(
        url,
        options: Options(
          headers: {
            "Content-Type": "application/json",
            "Authorization": "Bearer $accessToken",
          },
        ),
      );

      final checkStatusRequest = CheckStatusRequest.fromJson(response.data['data']);
      if (checkStatusRequest.senderID == "ronaldo") {
        return checkStatusRequest.status == "Pending";
      } else {
        return null;
      }
    } catch (e) {
      // Handle exceptions (e.g., network error, parsing error, etc.)
      return null;
    }
  }
}