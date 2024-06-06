import 'package:buzz_hub/core/values/app_colors.dart';
import 'package:buzz_hub/modules/root_view/controller/root_view_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:stylish_bottom_bar/stylish_bottom_bar.dart';
import 'package:buzz_hub/modules/post/views/create_post_page.dart';

class RootViewScreen extends StatelessWidget {
  const RootViewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final rootViewController = Get.put(RootViewController(), permanent: true);
    return AnnotatedRegion(
      value: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
        statusBarBrightness: Brightness.dark,
        systemNavigationBarIconBrightness: Brightness.dark,
      ),
      child: Material(
        color: Colors.transparent,
        child: Scaffold(
          body: PageView(
            onPageChanged: rootViewController.animateToTab,
            controller: rootViewController.pageController,
            // physics: const NeverScrollableScrollPhysics(),
            children: rootViewController.screens,
          ),
          bottomNavigationBar: Obx(() => StylishBottomBar(
                option: AnimatedBarOptions(
                  iconSize: 24,
                  iconStyle: IconStyle.Default,
                  opacity: 0.3,
                ),
                items: [
                  BottomBarItem(
                    selectedIcon: const Icon(Icons.home),
                    title: const Text(
                      'Trang chủ',
                      style: TextStyle(fontSize: 12),
                    ),
                    selectedColor: AppColors.DarkBg,
                    icon: Icon(Icons.home_outlined),
                  ),
                  BottomBarItem(
                    selectedIcon: const Icon(Icons.search),
                    title: const Text(
                      'Tìm kiếm',
                      style: TextStyle(fontSize: 12),
                    ),
                    selectedColor: AppColors.DarkBg,
                    icon: Icon(Icons.search_outlined),
                  ),
                  BottomBarItem(
                    selectedIcon: const Icon(Icons.sms),
                    title: const Text(
                      'Tin nhắn',
                      style: TextStyle(fontSize: 12),
                    ),
                    selectedColor: AppColors.DarkBg,
                    icon: Icon(Icons.sms_outlined),
                  ),
                  BottomBarItem(
                    selectedIcon: const Icon(Icons.person),
                    title: const Text(
                      'Tài khoản',
                      style: TextStyle(fontSize: 12),
                    ),
                    selectedColor: AppColors.DarkBg,
                    icon: Icon(Icons.person_outline),
                  ),
                ],
                fabLocation: StylishBarFabLocation.center,
                hasNotch: true,
                notchStyle: NotchStyle.circle,
                currentIndex: rootViewController.currentPage.value,
                onTap: (index) {
                  rootViewController.onChangePage(index);
                },
              )),
          floatingActionButton: FloatingActionButton(
            shape: CircleBorder(),
            onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => CreatePost()),
                );
            },
            backgroundColor: AppColors.Purple,
            child: const Icon(
              CupertinoIcons.add,
              color: Colors.white,
            ),
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
        ),
      ),
    );
  }
}
