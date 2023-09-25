import 'package:dio/dio.dart';

class DioHelper {
  static late Dio dio;
  static init() {
    dio = Dio(
      BaseOptions(
        baseUrl: 'http://api.quran-tafseer.com/tafseer/',
        
      ),
    );
  }

  static Future<Response> getData({
    required url,
    Map<String, dynamic>? query,

  }) async {
    dio.options.headers = {
  
      'Content-Type': 'application/json'
    };
    return await dio.get(url, queryParameters: query);
  }

  static Future<Response> postData({
    required url,
    Map<String, dynamic>? query,
    Map<String, dynamic>? data,

  }) async {
    dio.options.headers = {
  
      'Content-Type': 'application/json'
    };
    return await dio.post(url, data: data);
  }

  static Future<Response> putData({
    required url,
    Map<String, dynamic>? query,
    Map<String, dynamic>? data,
    
  }) async {
  
    return await dio.put(url, queryParameters: query, data: data);
  }

  static Future<Response> deleteData({
    required url,
    Map<String, dynamic>? query,
    Map<String, dynamic>? data,
   
  }) async {
    dio.options.headers = {
      
      'Content-Type': 'application/json'
    };
    return await dio.delete(
      url,
      queryParameters: query,
      data: data,
   
    );
  }
}
