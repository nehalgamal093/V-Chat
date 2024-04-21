import 'dart:async';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:v_chat/bloc/get_messages_bloc/get_messages_bloc.dart';
import 'package:v_chat/bloc/get_users_bloc/get_users_bloc.dart';
import 'package:v_chat/bloc/login_bloc/login_bloc.dart';
import 'package:v_chat/bloc/register_bloc/register_bloc.dart';
import 'package:v_chat/bloc/send_msg_bloc/send_msg_bloc.dart';
import 'package:v_chat/presentation/pages/contacts_page/page/contacts_page.dart';
import 'package:v_chat/presentation/pages/login_page/page/login_page.dart';
import 'package:v_chat/services/auth/auth.dart';
import 'package:v_chat/services/chat/chat.dart';
import 'package:v_chat/services/dio/dio_helper.dart';
import 'package:v_chat/utils/notification.dart';

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // ignore: unnecessary_null_comparison
  if (message != null) {
    await showNotification(message.data['title'], message.data['body'],
        message.data['senderId'], message.data['senderImage']);
    print('Sender Image ${message.data['senderImage']}');
  }
}

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: '.env');
  initializeNotificationPlugin();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  await Firebase.initializeApp(
    options: FirebaseOptions(
        apiKey: dotenv.env['API_KEY'].toString(),
        appId: dotenv.env['APP_ID'].toString(),
        messagingSenderId: dotenv.env['MESSAGING_SENDER_ID'].toString(),
        projectId: dotenv.env['PROJECT_ID'].toString(),
        storageBucket: dotenv.env['STORAGE_BUCKET'].toString()),
  );
  // FirebaseMessaging messaging = FirebaseMessaging.instance;
  // FirebaseMessaging.onMessageOpenedApp.listen((message) {
  //   navigatorKey.currentState!.push(
  //     MaterialPageRoute(builder: (context) {
  //       context
  //           .read<GetMessagesBloc>()
  //           .add(MessagesEvent(id: message.data['senderId']));
  //       return ChatPage(
  //         id: message.data['senderId'],
  //         name: message.notification!.title!,
  //         img: 'https://avatar.iran.liara.run/public/girl?username=nono',
  //       );
  //     }),
  //   );
  // });
  // FirebaseMessaging.instance.getInitialMessage().then((message) {
  //   if (message != null) {
  //     showNotification(message.data['title'], message.data['body'],
  //         message.data['senderId'],);
  //   }
  // });

  await DioHelpers.init();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  var token = prefs.getString('token');
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => LoginBloc(auth: Auth()),
        ),
        BlocProvider(
          create: (context) => RegisterBloc(auth: Auth()),
        ),
        BlocProvider(
          create: (context) => GetUsersBloc()..add(GetUsers()),
        ),
        BlocProvider(
          create: (context) => GetMessagesBloc(),
        ),
        BlocProvider(
          create: (context) => SendMsgBloc(chat: Chat()),
        ),
      ],
      child: MaterialApp(
          navigatorKey: navigatorKey,
          title: 'V Chat',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            useMaterial3: true,
          ),
          home: token == null ? LoginPage() : const ContactsPage()),
    ),
  );
}
