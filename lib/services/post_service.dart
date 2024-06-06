import 'package:buzz_hub/services/dto/responses/post_response.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:buzz_hub/core/values/constant.dart';
import 'package:buzz_hub/services/dto/requests/count_like_post_request.dart';
import 'package:buzz_hub/services/dto/requests/like_post_request.dart';
import 'package:buzz_hub/services/dto/requests/dislike_post_request.dart';
import 'package:buzz_hub/services/dto/responses/count_like_post_response.dart';


class PostService {
  static const endpoint = 'Posts';

  Future<PostResponse?> getPostById(String postId) async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final String? accessToken = prefs.getString(Constants.ACCESS_TOKEN);

      if (accessToken == null) {
        // Handle the case where access token is not available
        // print('Access token is missing');
        return null;
      }

      final url = '${Constants.BASE_URL}/$endpoint/$postId';
      final res = await Dio().get(
        url,
        options: Options(headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $accessToken",
        }),
      );

      if (res.statusCode == 200) {
        // Parse the response data
        return PostResponse.fromJson(res.data);
      } else {
        // Handle different status codes appropriately
        // print('Failed to load post. Status code: ${res.statusCode}');
        return null;
      }
    } catch (e) {
      // Handle any exceptions that occur during the request
      // print('Error occurred while fetching post: $e');
      return null;
    }
  }

  Future<List<PostResponse>?> getAllPost() async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final String? accessToken = prefs.getString(Constants.ACCESS_TOKEN);

      if (accessToken == null) {
        // Handle the case where access token is not available
        // print('Access token is missing');
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
        // Parse the response data
        List<PostResponse> posts = (res.data as List)
            .map((json) => PostResponse.fromJson(json))
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

  Future<int> getCountLike(String? postId) async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final String? accessToken = prefs.getString(Constants.ACCESS_TOKEN);

      if (accessToken == null) {
        // Handle the case where access token is not available
        // print('Access token is missing');
        return 0;
      }

      final url = '${Constants.BASE_URL}/$endpoint/$postId/likesCount';
      final res = await Dio().get(
        url,
        options: Options(headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $accessToken",
        }),
      );

      if (res.statusCode == 200) {
        // Assuming the response data contains the like count as an integer
        return res.data as int;
      } 
      else {
        // Handle different status codes appropriately
        // print('Failed to load like count. Status code: ${res.statusCode}');
        return 0;
      }
    } 
    catch (e) {
      // Handle any exceptions that occur during the request
      // print('Error occurred while fetching like count: $e');
      return 0;
    }
  }

  Future<bool> likePost(LikePostRequest request) async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final String? accessToken = prefs.getString(Constants.ACCESS_TOKEN);

      if (accessToken == null) {
        // Handle the case where access token is not available
        // print('Access token is missing');
        return false;
      }

      final url = '${Constants.BASE_URL}/$endpoint/${request.postId}/like';
      final res = await Dio().post(
        url,
        data: request.toJson(),
        options: Options(headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $accessToken",
        }),
      );

      if (res.statusCode == 200) {
        // Assuming a successful like operation returns status 200
        return true;
      } else {
        // Handle different status codes appropriately
        print('Failed to like post. Status code: ${res.statusCode}');
        return false;
      }
    } 
    catch (e) {
      // Handle any exceptions that occur during the request
      print('Error occurred while liking post: $e');
      return false;
    }
  }

  Future<bool> dislikePost(DislikePostRequest request) async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final String? accessToken = prefs.getString(Constants.ACCESS_TOKEN);

      if (accessToken == null) {
        // Handle the case where access token is not available
        // print('Access token is missing');
        return false;
      }

      final url = '${Constants.BASE_URL}/$endpoint/${request.postId}/like';
      final res = await Dio().delete(
        url,
        data: request.toJson(),
        options: Options(headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $accessToken",
        }),
      );

      if (res.statusCode == 200) {
        // Assuming a successful dislike operation returns status 200
        return true;
      } else {
        // Handle different status codes appropriately
        // print('Failed to dislike post. Status code: ${res.statusCode}');
        return false;
      }
    } catch (e) {
      // Handle any exceptions that occur during the request
      // print('Error occurred while disliking post: $e');
      return false;
    }
  }



}