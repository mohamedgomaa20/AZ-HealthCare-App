import 'package:dio/dio.dart';

class DioHelper {
  static late Dio dio;

  static init() {
    dio = Dio(
      BaseOptions(
        baseUrl: 'http://healthmonitoring.runasp.net',
        receiveDataWhenStatusError: true,
        validateStatus: (status) {
          return status != null;
        },
        headers: {'Content-Type': 'application/json', 'Accept': 'text/plain'},
      ),
    );
  }

  static Future<Response<dynamic>> getData({
    required String url,
    Map<String, dynamic>? query,
  }) async {
    return await dio.get(
      url,
      queryParameters: query,
      options: Options(
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      ),
    );
  }

  static Future<Response<dynamic>> putData({
    required String url,
    Map<String, dynamic>? query,
    Map<String, dynamic>? data,
  }) async {
    return await dio.put(
      url,
      queryParameters: query,
      data: data,
      options: Options(
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      ),
    );
  }

  static Future<Response> postData({
    required String url,
    Map<String, dynamic>? query,

    dynamic data,
  }) async {
    if (data is FormData) {
      dio.options.headers['Content-Type'] = 'multipart/form-data';
    } else {
      dio.options.headers['Content-Type'] = 'application/json';
    }

    return await dio.post(url, queryParameters: query, data: data);
  }

  static Future<Response> deleteData({
    required String url,
    Map<String, dynamic>? query,
    Map<String, dynamic>? headers,
  }) async {
    dio.options.headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    };
    return await dio.delete(url, queryParameters: query);
  }
}
