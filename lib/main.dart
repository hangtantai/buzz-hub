import 'dart:io';
import 'package:buzz_hub/services/auth_service.dart';
import 'package:buzz_hub/services/dto/login_request.dart';
import 'package:flutter/material.dart';


void main(List<String> arguments) async {
  HttpOverrides.global = MyHttpOverrides();
  AuthService authService = AuthService();
  authService
      .login(LoginRequest(userName: 'nhulb0701', password: 'LeBaoNhu71!'))
      .then((value) {
    
    return value;
  });

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        useMaterial3: true,
        fontFamily: 'Manrope',
      ),
      home: const Scaffold(),
    );
  }
}
 class MyHttpOverrides extends HttpOverrides{
  @override
  HttpClient createHttpClient(SecurityContext? context){
    return super.createHttpClient(context)
      ..badCertificateCallback = (X509Certificate cert, String host, int port)=> true;
  }
}
