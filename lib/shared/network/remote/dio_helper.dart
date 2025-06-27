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
    return await dio.get(url, queryParameters: query);
  }

  static Future<Response> postData({
    required String url,
    Map<String, dynamic>? query,
      Map<String, dynamic>? data,
  }) async {
    return await dio.post(url, queryParameters: query, data: data);
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

  // static Future<Response> postData({
  //   required String url,
  //   String language = 'en',
  //   String? token,
  //   // required Map<String, dynamic> query,
  //   required Map<String, dynamic> data,
  // }) async {
  //   dio.options.headers = {
  //     'lang': language,
  //     'Content-Type': 'application/json',
  //     'Authorization': token ?? '',
  //   };
  //   return await dio.post(
  //     url,
  //     // queryParameters: query,
  //     data: data,
  //   );
  // }

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
