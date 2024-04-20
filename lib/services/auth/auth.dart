import 'package:dio/dio.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
      prefs.setString('token', response.data['token']);
      final fcmToken = await FirebaseMessaging.instance.getToken();
      print('fcm from token ${fcmToken}');
      updateFcm(response.data['_id'], fcmToken!);
      return response;
    } catch (e) {
      // ignore: use_rethrow_when_possible
      throw (e);
    }
  }

  Future<Response?> register(String username, String password,
      String confirmPassword, String gender, String fullName) async {
    var dio = Dio();
    final fcmToken = await FirebaseMessaging.instance.getToken();
    print('FCM-TOKEN ${fcmToken}');
    try {
      final response = await dio.post(
        'https://chat-app-nehal-gamal.onrender.com/api/auth/signup',
        data: {
          "fullName": fullName,
          "username": username,
          "password": password,
          "confirmPassword": confirmPassword,
          "gender": gender,
          "fcmToken": fcmToken
        },
        options: Options(headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json'
        }),
      );
      print('Register Response is $response');
      return response;
    } catch (e) {
      // ignore: use_rethrow_when_possible
      throw (e);
    }
  }

  Future<Response?> updateFcm(String id, String fcmToken) async {
    var dio = Dio();

    try {
      final response = await dio.put(
        'https://chat-app-nehal-gamal.onrender.com/api/auth/update/$id',
        data: {"fcmToken": fcmToken},
        options: Options(headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json'
        }),
      );
      print('Update response ${response}');
      return response;
    } catch (e) {
      // ignore: use_rethrow_when_possible
      throw (e);
    }
  }
}
