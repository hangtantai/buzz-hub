import 'package:buzz_hub/services/dto/requests/edit_user_request.dart'; 
import 'package:buzz_hub/services/user_service.dart';
import 'package:buzz_hub/services/edit_profile_service.dart';
import 'package:buzz_hub/services/dto/responses/current_user_response.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EditEmailController extends GetxController {
  final TextEditingController emailController = TextEditingController();
  RxBool isLoading = false.obs;
  RxString errorMessage = "".obs;

  final RegExp emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');

  Future<bool> updateEmail(String newEmail) async {
    isLoading.value = true;
    errorMessage.value = ""; 


    EditProfileService editProfileService = EditProfileService();

    try {
      Rx<CurrentUserResponse?> currentUser = Rx<CurrentUserResponse?>(null);
      UserService userService = UserService();
      final r = await userService.getCurrentUser();
      currentUser.value = r; 


      if (!emailRegex.hasMatch(newEmail)) {
        errorMessage.value = "Vui lòng nhập địa chỉ email hợp lệ";
        isLoading.value = false;
        return false;
      }

      if (newEmail.trim() == currentUser.value!.email!.trim()) {
        errorMessage.value = "Địa chỉ email không thay đổi";
        isLoading.value = false;
        return false;         
      }

      final res = await editProfileService.updateUser(
        EditUserRequest(
          fullName: currentUser.value!.fullName,
          dob: currentUser.value!.dob?.toIso8601String(),
          email: emailController.text,
        )
      );
      if (res == null) {
        errorMessage.value = "Cập nhật không thành công";
        return false;
      }
      return true;

    } catch (e) {
      errorMessage.value = "Đã có lỗi xảy ra: $e";
      return false;
    } finally {
      isLoading.value = false;
    }
  }

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }
}
