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

  ///v1
  // static Future<Response> postData({
  //   required String url,
  //   Map<String, dynamic>? query,
  //     Map<String, dynamic>? data,
  // }) async {
  //   return await dio.post(url, queryParameters: query, data: data);
  // }
  ///v2
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

  //
  // static Future<Response> putData({
  //   required String path,
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
  //   return await dio.put(
  //     path,
  //     // queryParameters: query,
  //     data: data,
  //   );
  // }
}
