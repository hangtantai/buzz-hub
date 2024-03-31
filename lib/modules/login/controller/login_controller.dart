import 'package:buzz_hub/services/auth_service.dart';
import 'package:buzz_hub/services/dto/login_request.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  TextEditingController usernameCtrl = TextEditingController();
  TextEditingController passwordCtrl = TextEditingController();

  Future<bool> onLogin() async {
    AuthService authService = AuthService();
    final res = await authService
        .login(LoginRequest(userName: usernameCtrl.text, password: passwordCtrl.text));
    if (res == null) {
      return false;
    }
    return true;
  }
}
