import 'package:buzz_hub/core/values/constant.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
//import 'package:cross_file/src/types/interface.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class CreatePostService {
  static const endpoint = 'Posts';

  Future<void> createTextPost({required String postContent}) async {
    try {
      var url = '${Constants.BASE_URL}/$endpoint?textContent=$postContent';
      await _sendPostRequest(url, null);
    } catch (e) {
      rethrow;
    }
  }

  Future<void> createMediaPost(String postContent, List<XFile> xfiles) async {
    try {
      var url = '${Constants.BASE_URL}/$endpoint?textContent=$postContent';

      var formData = FormData();
      for (XFile xfile in xfiles) {
        File file = File(xfile.path);
        String fileName = file.path.split('/').last;
        formData.files.addAll([
          MapEntry("imageContents",
              await MultipartFile.fromFile(file.path, filename: fileName))
        ]);
      }
      await _sendPostRequest(url, formData);
    } catch (e) {
      rethrow;
    }
  }

  Future<void> _sendPostRequest(String url, FormData? formData) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? accessToken = prefs.getString(Constants.ACCESS_TOKEN);

    await Dio().post(
      url,
      data: formData,
      options: Options(headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $accessToken",
      }),
    );
  }
}
