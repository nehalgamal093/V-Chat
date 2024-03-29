import 'package:dio/dio.dart';

class DioHelpers {
  static late Dio dio;
  static init() {
    dio = Dio(BaseOptions(
        baseUrl: 'https://chat-app-nehal-gamal.onrender.com/api/',
        headers: {'Content-Type': 'application/json'}));
  }

  static Future<Response> getData(
      {required String endPoints,
      Map<String, dynamic>? queryParameters}) async {
    try {
      dio.options.headers = {
        'Cookie':
            'jwt=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJfaWQiOiI2NWQ0ZDc0OWFmOTI0ZDZmOTI4MmZmOTQiLCJpYXQiOjE3MTE3MTQzNTgsImV4cCI6MTczNzYzNDM1OH0.v9tLwKFBTHrGxRiohweRhG17Hwwe6mxEN0dnN1sVCf8'
      };
      final Response response =
          await dio.get(endPoints, queryParameters: queryParameters);
      return response;
    } catch (e) {
      rethrow;
    }
  }
}
