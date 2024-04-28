import 'dart:io';
import 'package:buzz_hub/modules/search/views/search_bar.dart';
import 'package:buzz_hub/modules/login/views/conversation_page.dart';
import 'package:buzz_hub/modules/profile/views/profile.dart';
import 'package:buzz_hub/modules/login/views/login_page.dart';
import 'package:buzz_hub/modules/login/views/register_page.dart';
import 'package:buzz_hub/services/auth_service.dart';
import 'package:buzz_hub/services/dto/requests/login_request.dart';
import 'package:buzz_hub/modules/search/views/search_bar.dart' as BuzzHubSearchBar;
import 'package:flutter/material.dart';
import 'package:get/get.dart';



void main(List<String> arguments) async {
  HttpOverrides.global = MyHttpOverrides();
 

  runApp(const MyApp());
}

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return GetMaterialApp(
//       title: 'Flutter Demo',
//       theme: ThemeData(
//         useMaterial3: true,
//         fontFamily: 'Manrope',
//       ),
//       home: LoginPage(),
//       // actions: [Searchbar()],
//       debugShowCheckedModeBanner: false,
//     );
//   }
// }

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
      home: MySearchBarApp(),
      debugShowCheckedModeBanner: false,
    );
  }
}

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return GetMaterialApp(
//       title: 'Flutter Demo',
//       theme: ThemeData(
//         useMaterial3: true,
//         fontFamily: 'Manrope',
//       ),
//       home: ProfileScreen(),
//       debugShowCheckedModeBanner: false,
//     );
//   }
// }




class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}
