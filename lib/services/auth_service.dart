import 'package:buzz_hub/core/values/constant.dart';
import 'package:buzz_hub/services/base_response.dart';
import 'package:buzz_hub/services/dto/login_request.dart';
import 'package:buzz_hub/services/dto/login_response.dart';
import 'package:buzz_hub/services/dto/register_request.dart';
import 'package:dio/dio.dart';

class AuthService {
  static const endpoint = 'Auth';
  Future<LoginResponse?> login(LoginRequest request) async {
    try {
      const url = '${Constants.BASE_URL}/$endpoint/login';
      print(url);
      final res = await Dio().post(url, data: request.toJson()).then((value) =>
          LoginResponse.fromJson(BaseResponse.fromJson(value.data).data));
      return res;
    } catch (e) {
      return null;
    }
  }

  Future<bool?> register(RegisterRequest request) async {
    try {
      const url = '${Constants.BASE_URL}/$endpoint/register';
      final res = await Dio()
          .post(url, data: request.toJson())
          .then((value) => BaseResponse.fromJson(value.data).success);
      return res;
    } catch (e) {
      return null;
    }
  }
}
