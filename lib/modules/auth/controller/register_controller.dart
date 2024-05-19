import 'package:buzz_hub/services/auth_service.dart';
import 'package:buzz_hub/services/dto/requests/register_request.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class RegisterController extends GetxController {
  TextEditingController emailCtrl = TextEditingController();
  TextEditingController fullNameCtrl = TextEditingController();
  TextEditingController usernameCtrl = TextEditingController();
  TextEditingController passwordCtrl = TextEditingController();
  TextEditingController confirmPasswordCtrl = TextEditingController();

  Future<bool> onRegister() async {
    AuthService authService = AuthService();
    final res = await authService.register(RegisterRequest(
        email: emailCtrl.text,
        fullName: fullNameCtrl.text,
        userName: usernameCtrl.text,
        password: passwordCtrl.text,
        confirmPassword: confirmPasswordCtrl.text
        ));
    if (res == null) {
      return false;
    }
    return true;
  }
}
