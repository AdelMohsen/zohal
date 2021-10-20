import 'package:dio/dio.dart';
import 'package:zohal/constance/end_point.dart';

class DioHelper {
  static late Dio _dio;

  static init() {
    _dio = Dio(BaseOptions(
        baseUrl: BASE_URL,
        receiveDataWhenStatusError: true,
        followRedirects: false,
        connectTimeout: 60 * 1000,
        receiveTimeout: 60 * 1000,
        sendTimeout: 60 * 1000,
        validateStatus: (status) {
          return status! <= 500;
        }));
  }

  static Future<Response> getData(
      {required String url,
      Map<String, dynamic>? quires,
      required String? token,
      String? lang}) async {
    _dio.options.headers = {
      'authorization': 'Bearer $token',
      'language': lang ?? 'EN',
      'Content-Type': 'application/json'
    };
    _dio.options.connectTimeout = 60 * 1000;
    _dio.options.receiveTimeout = 60 * 1000;
    _dio.options.sendTimeout = 60 * 1000;
    return await _dio.get(url, queryParameters: quires);
  }

static Future<Response> postData({
    required String url,
    required Map<String, dynamic> data,
    required String token,
    String? lang,
  }) async {
    _dio.options.headers = {
      'authorization': 'Bearer $token',
      'language': lang ?? 'EN',
      'Content-Type': 'application/json'
    };
    _dio.options.connectTimeout = 60 * 1000;
    _dio.options.receiveTimeout = 60 * 1000;
    _dio.options.sendTimeout = 60 * 1000;
    return await _dio.post(url, data: data);
  }

  static Future<Response> postLogin({
    required String url,
    required Map<String, dynamic> data,
    String? language,
    int? connectTimeOut,
    int? receiveTimeOut,
  }) async {
    _dio.options.headers = {
      'language': language ?? '',
      'Content-Type': 'application/json'
    };
    _dio.options.connectTimeout = connectTimeOut!.toInt();
    _dio.options.receiveTimeout = receiveTimeOut!.toInt();
    return await _dio.post(
      url,
      data: data,
    );
  }

  static Future<Response> putData(
      {required String url,
      Map<String, dynamic>? quires,
      required Map<String, dynamic> data,
      String? token,
      String? lang}) async {
    _dio.options.headers = {
      'Authorization': token ?? '',
      'lang': lang,
      'Content-Type': 'application/json'
    };
    return await _dio.put(url, queryParameters: quires, data: data);
  }
}
