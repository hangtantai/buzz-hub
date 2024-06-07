import 'package:buzz_hub/modules/post/models/post_model.dart';
import 'package:buzz_hub/services/base_response.dart';
import 'package:buzz_hub/services/dto/responses/post_response.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:buzz_hub/core/values/constant.dart';
import 'package:buzz_hub/services/dto/requests/dislike_post_request.dart';
import 'package:buzz_hub/services/dto/responses/count_like_post_response.dart';


class PostService {
  static const endpoint = 'Posts';

  Future<PostResponse> getPostById(int id) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? accessToken = prefs.getString(Constants.ACCESS_TOKEN);
    final url = '${Constants.BASE_URL}/$endpoint/$id'; // Adjust the endpoint as needed

    final Response response = await Dio().get(
      url,
      options: Options(headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $accessToken",
      }),
    );
      return PostResponse.fromJson(response.data);
  }

  Future<List<PostResponse>?> getAllPost() async {
    // try {
    //   final SharedPreferences prefs = await SharedPreferences.getInstance();
    //   final String? accessToken = prefs.getString(Constants.ACCESS_TOKEN);

    //   final url = '${Constants.BASE_URL}/$endpoint/';
    //   final res = await Dio()
    //     .get(
    //       url,
    //       options: Options(headers: {
    //         "Content-Type": "application/json",
    //         "Authorization": "Bearer $accessToken",
    //       }))
    //     .then((value) {
    //       List<dynamic> list = BaseResponse.fromJson(value.data).data;
    //       List<PostResponse> posts = [];

    //       for (var i in list) {
    //         PostResponse postResponse = PostResponse.fromJson(i);
    //         posts.add(postResponse);
    //       }
    //       return posts;
    //     });
    //     return res;
    // } catch (e) {
    //   return null;
    // }

    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final String? accessToken = prefs.getString(Constants.ACCESS_TOKEN);

      if (accessToken == null) {
        print('Access token is null');
        return null;
      }

      final url = '${Constants.BASE_URL}/$endpoint/';
      final res = await Dio().get(
        url,
        options: Options(headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $accessToken",
        }),
      );

      if (res.statusCode == 200) {
        // Debug: Log the raw response data
        print('Response data: ${res.data}');

        List<dynamic> list = BaseResponse.fromJson(res.data).data;
        List<PostResponse> posts = list.map((i) => PostResponse.fromJson(i)).toList();
        print(posts);
        return posts;
      } else {
        print('Failed to load posts. Status code: ${res.statusCode}');
        return null;
      }
    } catch (e) {
      print('Error occurred while fetching posts: $e');
      return null;
    }
  }

  Future<int> getCountLike(int? postId) async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final String? accessToken = prefs.getString(Constants.ACCESS_TOKEN);
      // final url = '${Constants.BASE_URL}/$endpoint/CountPostLike?postId=$postId';
      final url = 'https://chatable.azurewebsites.net/api/v1/Posts/CountPostLike?$postId';
      final res = await Dio()
        .get(
          url,
          options: Options(headers: {
            "Content-Type": "application/json",
            "Authorization": "Bearer $accessToken",
          }),
        )
        .then((value) {
          int count = BaseResponse.fromJson(value.data).data;

          return count;
        });
      return res;
    } 
    catch (e) {
      // Handle any exceptions that occur during the request
      // print('Error occurred while fetching like count: $e');
      return 0;
    }
  }

  Future<bool> likePost(int Id) async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final String? accessToken = prefs.getString(Constants.ACCESS_TOKEN);

      if (accessToken == null) {
        // Handle the case where access token is not available
        // print('Access token is missing');
        return false;
      }

      final url = '${Constants.BASE_URL}/$endpoint/Like/$Id';
      final res = await Dio().post(
        url,
        options: Options(headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $accessToken",
        }),
      );

      if (res.statusCode == 200 || res.statusCode == 201) {
        // Assuming the API returns 200 or 201 for a successful request
        return true;
      } else {
        // Handle unexpected status codes
        // print('Failed to like post: ${res.statusCode} - ${res.statusMessage}');
        return false;
      }
    } 
    catch (e) {
      // Handle any exceptions that occur during the request
      print('Error occurred while liking post: $e');
      return false;
    }
  }

  Future<bool> dislikePost(int Id) async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final String? accessToken = prefs.getString(Constants.ACCESS_TOKEN);

      if (accessToken == null) {
        // Handle the case where access token is not available
        // print('Access token is missing');
        return false;
      }

      final url = '${Constants.BASE_URL}/$endpoint/DisLike/$Id';
      final res = await Dio().delete(
        url,
        options: Options(headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $accessToken",
        }),
      );

      if (res.statusCode == 200 || res.statusCode == 201) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      // Handle any exceptions that occur during the request
      // print('Error occurred while disliking post: $e');
      return false;
    }
  }



}