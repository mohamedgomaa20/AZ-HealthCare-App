import 'package:dio/dio.dart';

class DioHelper {
  static late Dio dio;

  static init() {
    dio = Dio(
      BaseOptions(
        baseUrl: 'http://healthmonitoring.runasp.net',
        receiveDataWhenStatusError: true,
      ),
    );
  }

  static Future<Response<dynamic>> getData({
    required String url,
    Map<String, dynamic>? query,
  }) async {
    return await dio.get(url, queryParameters: query);
  }

  // static Future<Response<dynamic>> getData({
  //   required String path,
  //   String language = 'en',
  //   String? token,
  //   Map<String, dynamic>? query,
  // }) async {
  //   dio.options.headers = {
  //     'lang': language,
  //     'Content-Type': 'application/json',
  //     'Authorization': token ?? '',
  //   };
  //   return await dio.get(path, queryParameters: query);
  // }

  static Future<Response> postData({
    required String path,
    String language = 'en',
    String? token,
    // required Map<String, dynamic> query,
    required Map<String, dynamic> data,
  }) async {
    dio.options.headers = {
      'lang': language,
      'Content-Type': 'application/json',
      'Authorization': token ?? '',
    };
    return await dio.post(
      path,
      // queryParameters: query,
      data: data,
    );
  }

  static Future<Response> putData({
    required String path,
    String language = 'en',
    String? token,
    // required Map<String, dynamic> query,
    required Map<String, dynamic> data,
  }) async {
    dio.options.headers = {
      'lang': language,
      'Content-Type': 'application/json',
      'Authorization': token ?? '',
    };
    return await dio.put(
      path,
      // queryParameters: query,
      data: data,
    );
  }
}
