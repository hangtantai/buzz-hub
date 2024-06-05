import 'package:buzz_hub/services/dto/requests/edit_user_request.dart';
import 'package:buzz_hub/services/user_service.dart';
import 'package:buzz_hub/services/edit_profile_service.dart';
import 'package:buzz_hub/services/dto/responses/current_user_response.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EditFullNameController extends GetxController {
  final TextEditingController fullNameController = TextEditingController();
  RxBool isLoading = false.obs;
  RxString errorMessage = "".obs;

  Future<bool> updateFullName(String newFullName) async {
    isLoading.value = true;
    errorMessage.value = ""; 
    EditProfileService editProfileService = EditProfileService();

    try {
      Rx<CurrentUserResponse?> currentUser = Rx<CurrentUserResponse?>(null);
      UserService userService = UserService();
      final r = await userService.getCurrentUser();
      currentUser.value = r; 
      
      if (newFullName.trim() == currentUser.value!.fullName!.trim()) {
        errorMessage.value = "Họ Tên không thay đổi";
        isLoading.value = false;
        return false; 
      }

      final res = await editProfileService.updateUser(
        EditUserRequest(
          fullName: fullNameController.text,
          dob: currentUser.value!.dob?.toIso8601String(),
          email: currentUser.value!.email,      
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
    fullNameController.dispose();
    super.dispose();
  }
}
