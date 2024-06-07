import 'package:buzz_hub/services/dto/responses/post_user_response.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:buzz_hub/core/values/constant.dart';


class PostServiceByUser {
  static const endpoint = 'Posts/GetByUser';

  Future<List<PostUserResponse>?> getPostByUser(String userName) async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final String? accessToken = prefs.getString(Constants.ACCESS_TOKEN);

      if (accessToken == null) {
        // Handle the case where access token is not available
        // print('Access token is missing');
        return null;
      }

      final url = '${Constants.BASE_URL}/$endpoint/$userName';
      final res = await Dio().get(
        url,
        options: Options(headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $accessToken",
        }),
      );

      if (res.statusCode == 200) {
        List<dynamic> postList = res.data['data'] as List<dynamic>;
        // Parse the response data
        List<PostUserResponse> posts = postList
            .map((json) => PostUserResponse.fromJson(json))
            .toList();
        return posts;
      } else {
        // Handle different status codes appropriately
        // print('Failed to load posts. Status code: ${res.statusCode}');
        return null;
      }
    } 
    catch (e) {
      // Handle any exceptions that occur during the request
      // print('Error occurred while fetching posts: $e');
      return null;
    }
  }
}