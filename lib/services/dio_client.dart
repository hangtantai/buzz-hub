import 'package:dio/dio.dart';

class DioClient {
  static DioClient? _instance;
  Dio? _dio;

  DioClient._();

  static DioClient get instance {
    _instance ??= DioClient._();
    return _instance!;
  }

  Dio? get dio {
    if (_dio != null) {
      return _dio;
    }
    _dio = Dio();
    return _dio;
  }
}
