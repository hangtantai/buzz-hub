import 'package:buzz_hub/core/values/constant.dart';
import 'package:buzz_hub/services/base_response.dart';
import 'package:buzz_hub/services/dto/requests/login_request.dart';
import 'package:buzz_hub/services/dto/responses/current_user_response.dart';
import 'package:buzz_hub/services/dto/responses/login_response.dart';
import 'package:buzz_hub/services/dto/requests/register_request.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FriendService {
  static const endpoint = 'Friend';
  Future<List<CurrentUserResponse>?> getAllFriend() async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final String? accessToken = prefs.getString(Constants.ACCESS_TOKEN);
      const url = '${Constants.BASE_URL}/$endpoint';
      final res = await Dio()
          .get(url,
              options: Options(headers: {
                "Content-Type": "application/json",
                "Authorization": "Bearer $accessToken",
              }))
          .then((value) {
        List<dynamic> list = BaseResponse.fromJson(value.data).data;
        List<CurrentUserResponse> friends = [];
        for (var i in list) {
          CurrentUserResponse currentUserResponse =
              CurrentUserResponse.fromJson(i);
          friends.add(currentUserResponse);
        }
        return friends;
      });
      return res;
    } catch (e) {
      return null;
    }
  }
}
