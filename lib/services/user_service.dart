import 'package:buzz_hub/core/values/constant.dart';
import 'package:buzz_hub/services/base_response.dart';
import 'package:buzz_hub/services/dto/requests/login_request.dart';
import 'package:buzz_hub/services/dto/responses/current_user_response.dart';
import 'package:buzz_hub/services/dto/responses/login_response.dart';
import 'package:buzz_hub/services/dto/requests/register_request.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserService {
  static const endpoint = 'User';

  Future<CurrentUserResponse?> getCurrentUser() async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final String? accessToken = prefs.getString(Constants.ACCESS_TOKEN);
      const url = '${Constants.BASE_URL}/$endpoint/CurrentUser';
      final res = await Dio()
          .get(url,
              options: Options(headers: {
                "Content-Type": "application/json",
                "Authorization": "Bearer $accessToken",
              }))
          .then((value) => CurrentUserResponse.fromJson(
              BaseResponse.fromJson(value.data).data));
      return res;
    } catch (e) {
      return null;
    }
  }

  Future<CurrentUserResponse?> getAuthor(String userName) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? accessToken = prefs.getString(Constants.ACCESS_TOKEN);

    if (accessToken == null) {
      // Handle the case where the access token is not available
      print('Access token is null');
      return null;
    }

    final String url = '${Constants.BASE_URL}/$endpoint/$userName';

    try {
      final res = await Dio().get(
        url,
        options: Options(headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $accessToken",
        }),
      );

      if (res.statusCode == 200) {
        return CurrentUserResponse.fromJson(res.data);
      } else {
        print('Failed to fetch user data. Status code: ${res.statusCode}');
        return null;
      }
    } catch (e) {
      print('Error occurred while fetching user data: $e');
      return null;
    }
  }
}
