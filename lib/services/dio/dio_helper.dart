import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DioHelpers {
  static late Dio dio;
  static init() {
    dio = Dio(BaseOptions(
        validateStatus: (_) => true,
        baseUrl: 'https://chat-app-nehal-gamal.onrender.com/api/',
        headers: {'Content-Type': 'application/json'}));
  }

  static Future<Response> getData(
      {required String endPoints,
      Map<String, dynamic>? queryParameters}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token');
    try {
      dio.options.headers = {'token': token};

      final Response response =
          await dio.get(endPoints, queryParameters: queryParameters);
      return response;
    } catch (e) {
      rethrow;
    }
  }
}
