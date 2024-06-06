import 'package:buzz_hub/core/values/constant.dart';
import 'package:flutter/material.dart';
import 'package:buzz_hub/services/dto/responses/current_user_response.dart'; // Import your user model

class FriendListPage extends StatelessWidget {
  final List<CurrentUserResponse> friends;

  const FriendListPage({Key? key, required this.friends}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Friends'),
      ),
      body: ListView.builder(
        itemCount: friends.length,
        itemBuilder: (context, index) {
          final friend = friends[index];
          var avatar = Constants.HOST_AVATAR_URL+friend.avatarUrl!;
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
            child: Row(
              children: [
                // Avatar
                CircleAvatar(
                  radius: 30,
                  
                  backgroundImage: NetworkImage(avatar), // Use friend's avatar URL
                ),
                const SizedBox(width: 16), // Space between avatar and details
                // Username and Unfriend Button
                Expanded( // Expand to take available space
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween, // Align items to start and end
                    children: [
                      Text(
                        friend.userName ?? 'User', // Display friend's username
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      // Unfriend Button
                      ElevatedButton(
                        onPressed: () {
                          // TODO: Implement unfriend functionality
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red, // Red button color
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                          textStyle: const TextStyle(fontSize: 16),
                        ),
                        child: const Text('Unfriend'),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
