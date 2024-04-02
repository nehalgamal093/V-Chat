import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Chat {
  Future<Response?> sendMessage(String message, String id) async {
    var dio = Dio();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token');
    try {
      final response = await dio.post(
        'https://chat-app-nehal-gamal.onrender.com/api/messages/send/$id',
        data: {"message": message},
        options: Options(headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'token': token
        }),
      );

      return response;
    } catch (e) {
      // ignore: use_rethrow_when_possible
      throw (e);
    }
  }
}
