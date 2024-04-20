import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:v_chat/bloc/get_messages_bloc/get_messages_bloc.dart';
import 'package:v_chat/bloc/get_users_bloc/get_users_bloc.dart';
import 'package:v_chat/presentation/pages/login_page/page/login_page.dart';

dialogBox(BuildContext context) {
  return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          surfaceTintColor: Colors.white,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(32.0))),
          content: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Are you sure?',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.normal),
                ),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            border: Border.all(color: Colors.black)),
                        child: Text(
                          "No",
                          style: TextStyle(color: Colors.black),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                    SizedBox(width: 10),
                    InkWell(
                      onTap: () async {
                        SharedPreferences preferences =
                            await SharedPreferences.getInstance();
                        await preferences.clear();
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => LoginPage()));
                        BlocProvider.of<GetUsersBloc>(context).add(Logout());
                        await FirebaseMessaging.instance.deleteToken();
                      },
                      child: Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                        decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                        child: Text(
                          "Yes",
                          style: TextStyle(color: Colors.white),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        );
      });
}
