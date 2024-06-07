import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:buzz_hub/modules/profile/views/list_friend_page.dart';
import 'package:buzz_hub/services/friend_service.dart';



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
    );
  }
}