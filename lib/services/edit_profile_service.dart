import 'package:buzz_hub/core/values/constant.dart';
import 'package:buzz_hub/services/base_response.dart';
import 'package:buzz_hub/services/dto/requests/edit_user_request.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EditProfileService {
  static const endpoint = 'User';
  Future<Response> updateUser(EditUserRequest request) async {
    
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final String? accessToken = prefs.getString(Constants.ACCESS_TOKEN);
      const url = '${Constants.BASE_URL}/$endpoint/';
      final res = await Dio()
        .put(url,
              options: Options(headers: {
                "Content-Type": "application/json",
                "Authorization": "Bearer $accessToken",
              }
            ), 
            data: request.toJson()
          );
      return res;//res.statusCode == 200; 
    
  }
}
