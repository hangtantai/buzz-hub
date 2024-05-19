import 'package:buzz_hub/modules/conversation/view/conversation_page.dart';
import 'package:buzz_hub/modules/profile/views/profile.dart';
import 'package:buzz_hub/modules/search/views/search_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RootViewController extends GetxController {
  late PageController pageController;
  var currentPage = Rx<int>(0);
  var isRead = Rx<bool>(false);
  var isReadList = Rx<List<String>>([]);
  final text = TextEditingController();

  final screens = <Widget>[
    SizedBox(), //home page
    MySearchBarApp(), //search page
    ConversationPage(),
    ProfileScreen(), //account page
  ];

  @override
  void onInit() {
    // Get.lazyPut(() => HomeScreen());
    // Get.lazyPut(() => CommnityScreen());
    // // Get.lazyPut(() => const HomeworkScreen());
    // Get.lazyPut(() => const GameScreen());
    // Get.lazyPut(() => const ProfileScreen());

    pageController = PageController(initialPage: 0);
    super.onInit();
  }

  @override
  void onClose() {
    pageController.dispose();
    super.onClose();
  }

  void onChangePage(int index) {
    currentPage.value = index;
    pageController.jumpToPage(index);
  }

  void animateToTab(int page) {
    currentPage.value = page;
    pageController.animateToPage(page,
        duration: const Duration(milliseconds: 300), curve: Curves.ease);
  }
}