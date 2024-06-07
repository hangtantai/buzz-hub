import 'package:buzz_hub/core/values/app_colors.dart';
import 'package:buzz_hub/modules/auth/controller/login_controller.dart';
import 'package:buzz_hub/modules/conversation/view/conversation_page.dart';
import 'package:buzz_hub/modules/root_view/view/root_view_screen.dart';
import 'package:buzz_hub/services/dto/responses/current_user_response.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class LoaderDialog {
  static Future<void> showLoadingDialog(
      BuildContext context, GlobalKey key) async {
    var wid = MediaQuery.of(context).size.width / 4;
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Dialog(
            key: key,
            backgroundColor: Colors.white,
            child: Container(
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.white,
              ),
              width: wid,
              height: wid,
              child: Image.asset(
                'assets/images/loader.gif',
              ),
            ));
      },
    );
  }
}

class LoginPage extends StatelessWidget {
  LoginPage({super.key});
  LoginController controller = Get.put(LoginController());
  static CurrentUserResponse? currentUser;
  final GlobalKey<State> _LoaderDialog = new GlobalKey<State>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {},
        ),
      ),
      body: Container(
        padding: const EdgeInsets.all(30),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Vui lòng đăng nhập',
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.w900),
              ),
              const SizedBox(
                height: 8,
              ),
              const Text(
                'Chúng tôi nhớ bạn',
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: AppColors.Grey2),
              ),
              const SizedBox(height: 40),
              TextField(
                controller: controller.usernameCtrl,
                decoration: const InputDecoration(
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: AppColors.Grey,
                      ),
                    ),
                    hintText: 'Nhập tên đăng nhập',
                    hintStyle: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: AppColors.Grey2)),
              ),
              const SizedBox(height: 30),
              TextField(
                controller: controller.passwordCtrl,
                obscureText: true,
                decoration: const InputDecoration(
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: AppColors.Grey,
                      ),
                    ),
                    hintText: 'Nhập mật khẩu',
                    hintStyle: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: AppColors.Grey2)),
              ),
              const SizedBox(
                height: 60,
              ),
              InkWell(
                onTap: () async {
                  LoaderDialog.showLoadingDialog(context, _LoaderDialog);
                  bool isSuccess = await controller.onLogin();
                  if (isSuccess) {
                    Navigator.of(_LoaderDialog.currentContext!,
                            rootNavigator: true)
                        .pop();
                    LoginPage.currentUser = await controller.getCurrentUser();

                    Get.to(RootViewScreen());
                  } else {
                    Navigator.of(_LoaderDialog.currentContext!,
                            rootNavigator: true)
                        .pop();
                    showDialog<void>(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: const Text('Thông báo'),
                          content: const Text(
                            'Đăng nhập thất bại',
                          ),
                          actions: <Widget>[
                            TextButton(
                              style: TextButton.styleFrom(
                                textStyle:
                                    Theme.of(context).textTheme.labelLarge,
                              ),
                              child: const Text('OK'),
                              onPressed: () {
                                Get.back();
                              },
                            ),
                          ],
                        );
                      },
                    );
                  }
                },
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: AppColors.Purple),
                  child: const Text(
                    'Đăng nhập',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: 16),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
