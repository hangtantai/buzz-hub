import 'package:buzz_hub/core/values/constant.dart';
import 'package:buzz_hub/services/base_response.dart';
import 'package:buzz_hub/services/dto/responses/get_all_user_response.dart';
import 'package:dio/dio.dart';
import 'package:buzz_hub/services/dto/requests/friend_request.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:buzz_hub/core/values/constant.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FriendRequestService {
  static const endpoint = 'Request';

  Future<void> sendFriendRequest(FriendRequest request) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      final String? accessToken = prefs.getString(Constants.ACCESS_TOKEN);
      Uri url = Uri.parse('${Constants.BASE_URL}/$endpoint');
      final response = await http.post(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          "Authorization": "Bearer $accessToken"
        },
        body: jsonEncode({'receiverId': request.receiverId}),   
      );

      if (response.statusCode == 200) {
        // Request successful
        print('Friend request sent successfully');
      } else {
        // Request failed
        print('Failed to send friend request. Status code: ${response.statusCode}');
        print('Response body: ${response.body}');
        // You might want to throw an exception here to handle the error properly
        // throw Exception('Failed to send friend request');
      }
    } catch (e) {
      print('Error sending friend request: $e');
      // Handle the exception, maybe rethrow or show an error message
      // throw Exception('Failed to send friend request');
    }
  }
}


// class FriendRequestService {
//   Future<BaseResponse> sendFriendRequest(FriendRequest request) async {
//     try {
//       final response = await http.post(
//         '${Constants.BASE_URL}/$endpoint/${request.receiverId}',
//         // Add any necessary headers or authentication tokens here
//       );

//       if (response.statusCode == 200) {
//         final data = json.decode(response.body);
//         return BaseResponse.fromJson(data);
//       } else {
//         // Handle error cases (e.g., invalid response status)
//         return BaseResponse(success: false, message: 'Error sending friend request');
//       }
//     } catch (e) {
//       // Handle exceptions (e.g., network errors)
//       return BaseResponse(success: false, message: 'Error sending friend request');
//     }
//   }

//   // Implement the method for unfriending users similarly
// }