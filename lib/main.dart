import 'dart:io';
import 'package:buzz_hub/modules/auth/views/home_page.dart';
import 'package:buzz_hub/modules/search/views/search_bar.dart';
import 'package:buzz_hub/services/auth_service.dart';
import 'package:buzz_hub/services/dto/requests/login_request.dart';
import 'package:buzz_hub/modules/search/views/search_bar.dart' as BuzzHubSearchBar;
import 'package:buzz_hub/modules/auth/views/forgot_password_page.dart';
import 'package:buzz_hub/modules/auth/views/login_page.dart';
import 'package:buzz_hub/modules/message/views/message_list_page.dart';
import 'package:buzz_hub/modules/root_view/view/root_view_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:buzz_hub/modules/post/views/create_post_page.dart';
import 'package:buzz_hub/modules/bookmarks/views/bookmarks_screen.dart';
import 'package:buzz_hub/modules/bookmarks/views/bookmarks_null.dart';

void main(List<String> arguments) async {
  HttpOverrides.global = MyHttpOverrides();
 

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        useMaterial3: true,
        fontFamily: 'Manrope',
      ),
      //home: AccountDetailsPage(),
      home: LoginPage(),
      // home: CreatePost(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}
