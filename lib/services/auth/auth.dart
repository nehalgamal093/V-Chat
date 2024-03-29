import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:cookie_jar/cookie_jar.dart';

class Auth {
  Future<Response?> login(String username, String password) async {
    var dio = Dio();

    try {
      final response = await dio.post(
        'https://chat-app-nehal-gamal.onrender.com/api/auth/login',
        data: {"username": username, "password": password},
        options: Options(headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json'
        }),
      );

      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('user_id', response.data['_id']);
      print('ID ${response.data['_id']}');
      return response;
    } catch (e) {
      // ignore: use_rethrow_when_possible
      throw (e);
    }
  }
}
