import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:v_chat/bloc/get_messages_bloc/get_messages_bloc.dart';
import 'package:v_chat/main.dart';
import 'package:v_chat/presentation/pages/chat_page/page/chat_page.dart';

@pragma('vm:entry-point')
onOpenFromBackground(String id, String name, String img) async {
  navigatorKey.currentContext!
      .read<GetMessagesBloc>()
      .add(MessagesEvent(id: id.replaceAll('"', '')));
  Navigator.of(navigatorKey.currentContext!).push(
    MaterialPageRoute(builder: (context) {
      return ChatPage(
        id: id.replaceAll('"', ''),
        name: name.replaceAll('"', ''),
        img: img.replaceAll('"', ''),
      );
    }),
  );
}

@pragma('vm:entry-point')
openBackground(r) {
//  onOpenFromBackground(r.id.toString(), r.payload.)
  final List<String> data = r.payload!.split(','); // Assuming comma separation
  final String id = data[1];
  final String name = data[0];
  final String img = data[2];
  onOpenFromBackground(id, name, img);
}

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();
Future<void> initializeNotificationPlugin() async {
  const AndroidInitializationSettings initializationSettingsAndroid =
      AndroidInitializationSettings('@mipmap/ic_launcher');
  const InitializationSettings initializationSettings =
      InitializationSettings(android: initializationSettingsAndroid);
  await flutterLocalNotificationsPlugin.initialize(initializationSettings,
      onDidReceiveNotificationResponse: (r) {
//  onOpenFromBackground(r.id.toString(), r.payload.)
    final List<String> data =
        r.payload!.split(','); // Assuming comma separation
    final String id = data[1];
    final String name = data[0];
    final String img = data[2];
    onOpenFromBackground(id, name, img);
  }, onDidReceiveBackgroundNotificationResponse: openBackground);
}

Future<void> showNotification(
    String name, String body, String id, String img) async {
  const NotificationDetails notificationDetails = NotificationDetails(
    android: AndroidNotificationDetails(
      'v_chat_gi7070',
      channelDescription: "channel",
      importance: Importance.max,
      priority: Priority.max,
      "name",
      largeIcon: DrawableResourceAndroidBitmap(
        '@mipmap/ic_launcher',
      ),
    ),
  );

  await flutterLocalNotificationsPlugin.show(0, name, body, notificationDetails,
      payload: '${name},${id},${img}');
}
