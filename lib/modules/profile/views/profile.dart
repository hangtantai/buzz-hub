import 'package:buzz_hub/modules/auth/views/login_page.dart';
import 'package:buzz_hub/modules/bookmarks/views/bookmarks_screen.dart';
import 'package:buzz_hub/modules/account/views/accountdetails_page.dart';
import 'package:buzz_hub/services/dto/responses/post_response.dart';
import 'package:buzz_hub/widgets/post_item.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:share/share.dart';
import 'package:buzz_hub/services/dto/responses/current_user_response.dart';
import 'package:buzz_hub/core/values/constant.dart';
import 'package:buzz_hub/modules/profile/views/list_friend_page.dart';
import 'package:buzz_hub/services/friend_service.dart';
class Controller extends GetxController {
  var isFavorited = false.obs;
  void toggleFavorite() {
    isFavorited.toggle();
  }

  void savePost(BuildContext context) {
    // Implement your logic to save a post here
    // For example, you might want to add the post to a database

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('You have saved this post!')),
    );
  }
}

class FriendButton extends StatefulWidget {
  const FriendButton({Key? key}) : super(key: key);

  @override
  State<FriendButton> createState() => _FriendButtonState();
}

class _FriendButtonState extends State<FriendButton> {
  int _friendCount = 0;
  final FriendService _friendService = FriendService();

  @override
  void initState() {
    super.initState();
    _fetchFriendCount();
  }

  Future<void> _fetchFriendCount() async {
    final friends = await _friendService.getAllFriend();
    setState(() {
      _friendCount = friends?.length ?? 0;
    });
  }

  Future<void> _navigateToFriendList() async {
    final friends = await _friendService.getAllFriend();
    if (friends != null) {
      Get.to(() => FriendListPage(friends: friends));
    } else {
      Get.snackbar('Error', 'Failed to load friends');
    }
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: _navigateToFriendList,
      style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
              foregroundColor: Colors.black,
              padding: const EdgeInsets.symmetric(
              horizontal: 16, vertical: 10),
              textStyle: const TextStyle(fontSize: 16),
            ),
    child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
              Text('$_friendCount'),
              Text('Friends'),
            ],
        ),
      // child: Column(
      //   mainAxisAlignment: MainAxisAlignment.center,
      //   children: [
      //     Text(
      //       '$_friendCount',
      //       style: const TextStyle(
      //         fontSize: 20,
      //         fontWeight: FontWeight.bold,
      //         color: Colors.black,
      //         backgroundColor: Colors.white,
      //       ),
      //     ),
      //     const Text(
      //       'Friends',
      //       style: TextStyle(color: Colors.black),
      //       ),
      //   ],
      // ),
    );
  }
}





class ProfileScreen extends StatelessWidget {
  final CurrentUserResponse? user;
  ProfileScreen({Key? key, this.user}) : super(key: key);
  PostResponse postResponse = PostResponse(
      postId: "1",
      textContent:
          "It is a long established fact that a reader will bee distracted by the readable content ... 100000000000000000000000000000000000000000000000000000000",
      imageContent: [LoginPage.currentUser!.avatarUrl!],
      author: LoginPage.currentUser,
      createdAt: DateTime.now());

  void navigateToAccountDetailsPage() {
    Get.to(AccountDetailsPage());
  }

  ImageProvider getAvatarImage(CurrentUserResponse user) {
      if (user.avatarUrl != 'string' && user.avatarUrl != '') {
        return NetworkImage(Constants.HOST_AVATAR_URL + user.avatarUrl!);
      } else {
        return const AssetImage('assets/images/user.jpg');
      }
    }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back), // Use the back arrow icon
            onPressed: () {
              // Handle the back button press (e.g., navigate back)
              Navigator.of(context).pop();
            },
          ),
          title: Text("Trang cá nhân"),
          centerTitle: false,
          actions: [
            IconButton(
                onPressed: () {
                  navigateToAccountDetailsPage();
                  // Obx(() => IconButton(
                  //     icon: Icon(
                  //       c.isFavorited.value
                  //           ? Icons.favorite
                  //           : Icons.favorite_border,
                  //       color: c.isFavorited.value ? Colors.pink : null,
                  //     ),
                  //     onPressed: c.toggleFavorite));
                },
                icon: Icon(Icons.settings)),
            IconButton(
                onPressed: () {
                  Get.to(BookMarks());
                },
                icon: Icon(Icons.bookmark)),
          ],
        ),
        body: Container(
            width: double.infinity,
            height: Get.height - 80,
            padding: const EdgeInsets.all(8.0),
            child: SingleChildScrollView(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        GestureDetector(
                            onTap: () {
                              // write function here
                              showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      content: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: <Widget>[
                                            Container(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.6,
                                              child: Image.asset(
                                                  'assets/images/user.jpg'),
                                            ),
                                            TextButton(
                                                onPressed: () {
                                                  // write function here
                                                },
                                                child: Text('Change Image'))
                                          ]),
                                    );
                                  });
                            },
                            child: CircleAvatar(
                              radius: 50,
                              backgroundImage:
                                  getAvatarImage(user!),
                            )),
                        SizedBox(width: 20), // Add some space
                        Row(
                        children: [
                          Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              '250K',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text('Follower'), // Replace with actual number
                          ],
                        ),
                        SizedBox(width: 10), // Add some space
                        Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                        const FriendButton(),
                            ElevatedButton(
                              onPressed: () {
                                Get.to(FriendPage());
                                // write function here
                              },
                              style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.white,
                                        foregroundColor: Colors.black,
                                        padding: const EdgeInsets.symmetric(
                                        horizontal: 16, vertical: 10),
                                        textStyle: const TextStyle(fontSize: 16),
                                      ),
                              child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                        Text('Lời mời'),
                                        Text('kết bạn'),
                                      ],
                                  ),
                            )])])
                      ],
                    ),
                    SizedBox(width: 10), // Add some space
                    Row(
                      children: <Widget>[
                        Text(
                          user?.userName ?? 'Default Name',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Icon(Icons.check_circle, color: Colors.blue),
                      ],
                    ),
                    Text('@search_id'), // Replace with actual search id
                    SizedBox(height: 15),
                    Text(
                      'Bio text goes here, habit, interest, passion like this,...',
                      style: TextStyle(color: Colors.black),
                    ), // Replace with actual bio
                    SizedBox(height: 5),
                    Row(
                      children: <Widget>[
                        Icon(Icons.location_on),
                        Text('Address'), // Replace with actual address
                        Spacer(),
                        Icon(Icons.cake),
                        Text(
                            'Date of Birth'), // Replace with actual date of birth
                      ],
                    ),
                    SizedBox(height: 5),
                    Row(
                      children: <Widget>[
                        Icon(Icons.link),
                        Text('www.example.com'), // Replace with actual link
                      ],
                    ),
                    SizedBox(height: 10),
                    ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        return PostItem(post: postResponse);
                      },
                      itemCount: 3,
                    )
                  ]),
            )));
  }
}

class CommentScreen extends StatelessWidget {
  final TextEditingController _commentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Comments'),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: ListView(
              // This is where the comments would go.
              // You might want to replace this with a StreamBuilder if you're loading comments from a database.
              children: <Widget>[
                ListTile(
                  title: Text('User1'),
                  subtitle: Text('This is a comment.'),
                ),
                ListTile(
                  title: Text('User2'),
                  subtitle: Text('This is another comment.'),
                ),
                // Add more ListTiles for more comments
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: TextField(
                    controller: _commentController,
                    decoration: InputDecoration(
                      labelText: 'Write a comment...',
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.send),
                  onPressed: () {
                    // Implement your comment posting logic here
                    // For example, you might want to add the comment to your database
                    print('Comment: ${_commentController.text}');
                    _commentController.clear();
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class FriendRequest {
  final AssetImage avatarUrl;
  final String name;
  final DateTime requestTime;

  FriendRequest({
    required this.avatarUrl,
    required this.name,
    required this.requestTime,
  });
}

class FriendPage extends StatefulWidget {
  const FriendPage({Key? key}) : super(key: key);

  @override
  State<FriendPage> createState() => _FriendPageState();
}

class _FriendPageState extends State<FriendPage> {
  final List<FriendRequest> friends = [
    FriendRequest(
      avatarUrl: const AssetImage('assets/images/user.jpg'),
      name: 'Alice Johnson',
      requestTime: DateTime.now()
          .subtract(const Duration(minutes: 5)), // Example: 5 minutes ago
    ),
    FriendRequest(
      avatarUrl: const AssetImage('assets/images/user.jpg'),
      name: 'Bob Williams',
      requestTime: DateTime.now()
          .subtract(const Duration(hours: 2)), // Example: 2 hours ago
    ),
    // ... more friend requests
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Friend Requests'),
      ),
      body: ListView.builder(
        itemCount: friends.length,
        itemBuilder: (context, index) {
          final friend = friends[index];

          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 50,
                  backgroundImage: friend.avatarUrl,
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(children: [
                        Text(
                          friend.name,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const Spacer(),
                        Padding(
                            padding: const EdgeInsets.only(left: 8.0),
                            child:
                                Text(_formatTimeDifference(friend.requestTime),
                                    style: const TextStyle(
                                      fontSize: 12,
                                      color: Colors.grey,
                                    )))
                      ]),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          Expanded(
                            child: ElevatedButton(
                              onPressed: () {
                                // Handle accept button press for friend at index
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.blue,
                                minimumSize: const Size.fromHeight(40),
                              ),
                              child: const Text('Accept',
                                  style: TextStyle(color: Colors.white)),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: ElevatedButton(
                              onPressed: () {
                                // Handle remove button press for friend at index
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.grey,
                                minimumSize: const Size.fromHeight(40),
                              ),
                              child: const Text('Remove',
                                  style: TextStyle(color: Colors.white)),
                            ),
                          ),
                        ],
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

  String _formatTimeDifference(DateTime requestTime) {
    Duration difference = DateTime.now().difference(requestTime);
    if (difference.inDays > 0) {
      return '${difference.inDays}d ago';
    } else if (difference.inHours > 0) {
      return '${difference.inHours}h ago';
    } else if (difference.inMinutes > 0) {
      return '${difference.inMinutes}m ago';
    } else {
      return 'Just now';
    }
  }
}
