import 'package:dio/dio.dart';

class DioHelper {
  static late Dio dio;
  static init() {
    dio = Dio(
      BaseOptions(
        baseUrl: 'http://api.quran-tafseer.com/tafseer/',
        // baseUrl: 'http://192.168.72.68:3000',
        // baseUrl: '127.0.0.1/api',
        // receiveDataWhenStatusError: false,
      ),
    );
  }

  static Future<Response> getData({
    required url,
    Map<String, dynamic>? query,
    // String? token,
    // String lang = 'en'
  }) async {
    dio.options.headers = {
      // 'lang': lang,
      // 'Authorization': token,
      'Content-Type': 'application/json'
    };
    return await dio.get(url, queryParameters: query);
  }

  static Future<Response> postData({
    required url,
    Map<String, dynamic>? query,
    Map<String, dynamic>? data,
    // String Lang = 'en',
    // String? token
  }) async {
    dio.options.headers = {
      // 'lang': 'en',
      // 'Authorization': token,
      'Content-Type': 'application/json'
    };
    return await dio.post(url, data: data);
  }

  static Future<Response> putData({
    required url,
    Map<String, dynamic>? query,
    Map<String, dynamic>? data,
    // String Lang = 'en',
    // String? token
  }) async {
    // dio.options.headers = {
    //   'lang': 'en',
    //   'Authorization': token,
    //   'Content-Type': 'application/json'
    // };
    return await dio.put(url, queryParameters: query, data: data);
  }

  static Future<Response> deleteData({
    required url,
    Map<String, dynamic>? query,
    Map<String, dynamic>? data,
    // String Lang = 'en',
    // String? token
  }) async {
    dio.options.headers = {
      // 'lang': 'en',
      // 'Authorization': token,
      'Content-Type': 'application/json'
    };
    return await dio.delete(
      url,
      queryParameters: query,
      data: data,
      // options: Options(
      //   followRedirects: false,
      //   // will not throw errors
      //   validateStatus: (status) => true,
      // ),
    );
  }
}
