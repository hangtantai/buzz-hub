import 'dart:ffi';
import 'package:buzz_hub/services/dto/responses/post_response.dart';
import 'package:buzz_hub/services/dto/responses/current_user_response.dart';
import 'package:buzz_hub/core/values/app_colors.dart';
import 'package:buzz_hub/services/dto/responses/post_response.dart';
import 'package:buzz_hub/services/post_service.dart';
import 'package:buzz_hub/services/user_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  Future<List<PostResponse>?> onLoadPost() async {
    PostService postService = PostService();
    final res = await postService.getAllPost();
    return res;
  }

  Future<PostResponse> getPostById(int Id) async {
    PostService postService = PostService();
    final res = await postService.getPostById(Id);
    return res;
  }

  Future<CurrentUserResponse?> getUser(String userName) async {
    UserService userService = UserService();
    final res = await userService.getAuthor(userName);
    return res;
  }

  Future<int> getCountLike(int Id) async {
    PostService postService = PostService();
    final res = await postService.getCountLike(Id);
    return res;
  }

  Future<bool> likePost() async {
    PostService postService = PostService();
    final res = await postService.likePost();
    return res;
  }

  Future<bool> dislikePost() async {
    PostService postService = PostService();
    final res = await postService.dislikePost();
    return res;
  }

  RxList<PostResponse> listPost = RxList<PostResponse> ([]); 

  @override
  void onInit() async {
    super.onInit();
    listPost.value = await onLoadPost() ?? [];
  }


}