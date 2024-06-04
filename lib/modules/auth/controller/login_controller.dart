import 'package:buzz_hub/core/values/constant.dart';
import 'package:buzz_hub/services/auth_service.dart';
import 'package:buzz_hub/services/dto/requests/login_request.dart';
import 'package:buzz_hub/services/dto/responses/current_user_response.dart';
import 'package:buzz_hub/services/user_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginController extends GetxController {
  TextEditingController usernameCtrl = TextEditingController();
  TextEditingController passwordCtrl = TextEditingController();

  Future<bool> onLogin() async {
    AuthService authService = AuthService();
    final res = await authService.login(
        LoginRequest(userName: usernameCtrl.text, password: passwordCtrl.text));
    if (res == null) {
      return false;
    }
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(Constants.ACCESS_TOKEN, res.accessToken);
    await prefs.setString(Constants.REFRESH_TOKEN, res.refreshToken);
    return true;
  }

  Future<CurrentUserResponse?> getCurrentUser() async {
    UserService userService = UserService();
    final res = await userService.getCurrentUser();
    if (res == null) {
      return null;
    }
    return res;
  }
}
