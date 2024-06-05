import 'package:json_annotation/json_annotation.dart';

// class CountLikePostResponse {
//   final int postId;
//   final int likeCount;

//   CountLikePostResponse({required this.postId, required this.likeCount});

//   // Factory method to create an instance from JSON
//   factory CountLikePostResponse.fromJson(Map<String, dynamic> json) {
//     return CountLikePostResponse(
//       postId: json['postId'],
//       likeCount: json['likeCount'],
//     );
//   }

//   // Method to convert an instance to JSON
//   Map<String, int> toJson() {
//     return {
//       'postId': postId,
//       'likeCount': likeCount,
//     };
//   }
// }

class CountLikePostResponse {
  final int likeCount;

  CountLikePostResponse({required this.likeCount});

  factory CountLikePostResponse.fromJson(int json) {
    return CountLikePostResponse(
      likeCount: json,
    );
  }

  
  int toJson() {
    return likeCount;
  }
}