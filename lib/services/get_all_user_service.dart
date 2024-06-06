import 'package:buzz_hub/core/values/constant.dart';
import 'package:buzz_hub/services/base_response.dart';
import 'package:buzz_hub/services/dto/responses/get_all_user_response.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GetAllUserService {
  static const endpoint = 'User';

  Future<List<UserResponse>?> getAllUsers() async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final String? accessToken = prefs.getString(Constants.ACCESS_TOKEN);
      final url = '${Constants.BASE_URL}/$endpoint';

      final response = await Dio().get(
        url,
        options: Options(
          headers: {
            "Content-Type": "application/json",
            "Authorization": "Bearer $accessToken",
          },
        ),
      );

      final baseResponse = BaseResponse.fromJson(response.data);
      if (baseResponse.success) {
        final userResponseList = baseResponse.data as List<dynamic>;
        final userList = userResponseList
            .map((userData) => UserResponse.withDefaults(userData))
            .toList();


        return userList;
      } else {
        // Handle error case (e.g., log error, show a message, etc.)
        return null;
      }
    } catch (e) {
      // Handle exceptions (e.g., network error, parsing error, etc.)
      return null;
    }
  }
}
