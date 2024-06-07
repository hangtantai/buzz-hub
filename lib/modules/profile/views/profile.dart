import 'package:buzz_hub/core/values/app_colors.dart';
import 'package:buzz_hub/modules/auth/views/login_page.dart';
import 'package:buzz_hub/modules/bookmarks/views/bookmarks_screen.dart';
import 'package:buzz_hub/modules/account/views/accountdetails_page.dart';
import 'package:buzz_hub/modules/friend_request/controller/friend_request_controller.dart';
import 'package:buzz_hub/services/dto/responses/post_response.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:buzz_hub/services/dto/responses/current_user_response.dart';
import 'package:buzz_hub/core/values/constant.dart';
import 'package:buzz_hub/services/get_post_by_user.dart';
import 'package:buzz_hub/modules/profile/views/friend_button.dart';
import 'package:buzz_hub/services/dto/responses/post_user_response.dart';
import 'package:buzz_hub/widgets/post_item_user.dart' as post_user;
import 'package:buzz_hub/modules/profile/views/list_friend_page.dart';
import 'package:buzz_hub/services/friend_service.dart';
import 'package:intl/intl.dart';
import 'package:timeago/timeago.dart' as timeago;

import '../../../widgets/post_clone_item.dart';

class Controller extends GetxController {
  var isFavorited = false.obs;
  // RxList<PostResponse> listPost = RxList<PostResponse>([]);

  @override
  void onInit() async {
    super.onInit();
  }

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

  Future<List<PostResponse>?> onLoadPost(String userName) async {
    final res = await PostServiceByUser().getPostByUser(userName ?? '');
    if (res == null) {
      return null;
    }
    res.sort(((a, b) => b.createdAt!.compareTo(a.createdAt!)));
    return res;
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
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        textStyle: const TextStyle(fontSize: 16),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('$_friendCount'),
          Text('Bạn bè'),
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

  Controller controller = Get.put(Controller());

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
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: user!.userName != LoginPage.currentUser!.userName,
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
            padding: const EdgeInsets.all(20.0),
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
                              radius: 40,
                              backgroundImage: getAvatarImage(user!),
                            )),
                        SizedBox(width: 20), // Add some space
                        Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              const FriendButton(),
                              SizedBox(
                                width: 20,
                              ),
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
                              )
                            ])
                      ],
                    ),
                    SizedBox(width: 20), // Add some space
                    Row(
                      children: <Widget>[
                        Text(
                          user?.fullName ?? 'Default Name',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Icon(Icons.check_circle, color: Colors.blue),
                      ],
                    ),
                    Text('@${user?.userName}'), //
                    SizedBox(height: 8),
                    Row(
                      children: <Widget>[
                        Icon(Icons.link),
                        Text('${user?.email}'),
                        Spacer(),
                        Icon(Icons.cake),
                        Text(
                            '${DateFormat('dd/MM/yyyy').format(user?.dob ?? DateTime(2017))}'), // Replace with actual date of birth
                      ],
                    ),
                    SizedBox(height: 12),
                    FutureBuilder(
                      future: controller.onLoadPost(user?.userName ?? ''),
                      builder: (context, snapshot) {
                        if (snapshot.hasData && snapshot.data != null) {
                          List<PostResponse> list = snapshot.data!;
                          return ListView.builder(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index) {
                              return PostItem(post: list[index]);
                            },
                            itemCount: list.length,
                          );
                        }
                        return SizedBox();
                      },
                    )
                  ]),
            )));
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

class FriendPage extends StatelessWidget {
  FriendPage({super.key});
  FriendRequestController controller = Get.put(FriendRequestController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Lời mời kết bạn'),
        ),
        body: RefreshIndicator(
          onRefresh: () async {
            controller.listRequest.value =
                await controller.onLoadRequest() ?? [];
          },
          child: Obx(
            () => ListView.builder(
              itemCount: controller.listRequest.length,
              itemBuilder: (context, index) {
                var friend = controller.listRequest[index];

                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: 50,
                        backgroundImage: NetworkImage(
                            Constants.HOST_AVATAR_URL + friend.avatar!),
                      ),
                      const SizedBox(width: 20),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(children: [
                              Text(
                                friend.name!,
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const Spacer(),
                              Padding(
                                  padding: const EdgeInsets.only(left: 8.0),
                                  child: Text(
                                      timeago.format(friend.sentAt!
                                          .add(Duration(hours: 7))),
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
                                    onPressed: () async {
                                      var isSuccess = await controller
                                          .onAccept(friend.userId!);
                                      if (isSuccess) {
                                        showDialog<void>(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return AlertDialog(
                                              title: const Text('Thông báo'),
                                              content: Text(
                                                'Bạn và ${friend.name} đã trở thành bạn bè',
                                              ),
                                              actions: <Widget>[
                                                TextButton(
                                                  style: TextButton.styleFrom(
                                                    textStyle: Theme.of(context)
                                                        .textTheme
                                                        .labelLarge,
                                                  ),
                                                  child: const Text('OK'),
                                                  onPressed: () async {
                                                    Get.back();
                                                    controller.listRequest
                                                        .value = await controller
                                                            .onLoadRequest() ??
                                                        [];
                                                  },
                                                ),
                                              ],
                                            );
                                          },
                                        );
                                      }
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: AppColors.Purple,
                                      minimumSize: const Size.fromHeight(40),
                                    ),
                                    child: const Text('Accept',
                                        style: TextStyle(color: Colors.white)),
                                  ),
                                ),
                                const SizedBox(width: 8),
                                Expanded(
                                  child: ElevatedButton(
                                    onPressed: () async {
                                      bool isSuccess = await controller
                                          .onDecline(friend.userId!);

                                      if (isSuccess) {
                                        controller.listRequest.value =
                                            await controller.onLoadRequest() ??
                                                [];
                                      }
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: AppColors.Grey,
                                      minimumSize: const Size.fromHeight(40),
                                    ),
                                    child: const Text('Remove',
                                        style:
                                            TextStyle(color: AppColors.Grey2)),
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
          ),
        ));
  }
}
