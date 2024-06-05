import 'package:buzz_hub/services/dto/requests/edit_user_request.dart';
import 'package:buzz_hub/services/user_service.dart';
import 'package:buzz_hub/services/edit_profile_service.dart';
import 'package:buzz_hub/services/dto/responses/current_user_response.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EditBirthdayController extends GetxController {
  final TextEditingController dobController = TextEditingController();
  RxBool isLoading = false.obs;
  RxString errorMessage = "".obs;

  Future<bool> updateBirthday(DateTime newBirhday) async {
    isLoading.value = true;
    errorMessage.value = ""; 
    
    EditProfileService editProfileService = EditProfileService();

    try {
      Rx<CurrentUserResponse?> currentUser = Rx<CurrentUserResponse?>(null);
      UserService userService = UserService();
      final r = await userService.getCurrentUser();
      currentUser.value = r; 
    
      final res = await editProfileService.updateUser(
        EditUserRequest(
          fullName: currentUser.value!.fullName,
          dob: newBirhday.toIso8601String(),
          email: currentUser.value!.email,
        )
      );

      if (newBirhday == currentUser.value!.dob) {
        errorMessage.value = "Ngày sinh không thay đổi";
        isLoading.value = false;
        return false;         
      }

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
    dobController.dispose();
    super.dispose();
  }
}
