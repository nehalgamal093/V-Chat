import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:v_chat/bloc/get_users_bloc/get_users_bloc.dart';
import 'package:v_chat/bloc/login_bloc/login_bloc.dart';
import 'package:v_chat/presentation/pages/contacts_page/page/contacts_page.dart';
import 'package:v_chat/presentation/pages/login_page/page/login_page.dart';
import 'package:v_chat/services/auth/auth.dart';
import 'package:v_chat/services/dio/dio_helper.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DioHelpers.init();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  var userId = prefs.getString('user_id');
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => LoginBloc(auth: Auth()),
        ),
        BlocProvider(
          create: (context) => GetUsersBloc()..add(GetUsers()),
        ),
      ],
      child: MaterialApp(
          title: 'V Chat',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            useMaterial3: true,
          ),
          home: LoginPage()),
    ),
  );
}
