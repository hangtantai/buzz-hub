//import 'package:buzz_hub/services/dto/requests/_request.dart';
import 'package:buzz_hub/services/user_service.dart';
import 'package:buzz_hub/services/create_post_service.dart';
import 'package:buzz_hub/services/dto/responses/current_user_response.dart';
import 'package:flutter/material.dart';
//import 'package:buzz_hub/modules/account/controller/home_controller.dart';
//import 'package:cross_file/src/types/interface.dart';
import 'package:image_picker/image_picker.dart';
import 'package:get/get.dart';

class CreatePostController extends GetxController {
  final TextEditingController textController = TextEditingController();
  RxBool isLoading = false.obs;
  RxString errorMessage = "".obs;

  Future<bool> createTextPost(String content) async {
    return await _createPost(content, null); // Không có XFile cho bài viết chỉ có văn bản
  }

  Future<bool> createMediaPost(String content, List<XFile> xfile) async {
    return await _createPost(content, xfile);
  }

  Future<bool> _createPost(String content, List<XFile>? xfile) async {
    isLoading.value = true;
    errorMessage.value = ""; 
    
    CreatePostService createPostService = CreatePostService();

    try {
      Rx<CurrentUserResponse?> currentUser = Rx<CurrentUserResponse?>(null);
      UserService userService = UserService();
      final r = await userService.getCurrentUser();
      currentUser.value = r; 
    
      if (xfile == null) {
        await createPostService.createTextPost(postContent: content);
      } else {
        await createPostService.createMediaPost(content, xfile);
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
    super.dispose();
  }
}
