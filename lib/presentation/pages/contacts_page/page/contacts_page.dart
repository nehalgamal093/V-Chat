import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:v_chat/bloc/get_messages_bloc/get_messages_bloc.dart';
import 'package:v_chat/bloc/get_users_bloc/get_users_bloc.dart';
import 'package:v_chat/presentation/pages/chat_page/page/chat_page.dart';
import 'package:v_chat/presentation/pages/contacts_page/widgets/contact_tile.dart';
import 'package:v_chat/presentation/pages/custom_widgets/dialog_alert.dart';
import 'package:v_chat/presentation/pages/skeleton/contacts_skeleton/contacts_skeleton.dart';
import 'package:v_chat/utils/notification.dart';

class ContactsPage extends StatefulWidget {
  const ContactsPage({super.key});

  @override
  State<ContactsPage> createState() => _ContactsPageState();
}

class _ContactsPageState extends State<ContactsPage> {
  initialize() async {
    final fcmToken = await FirebaseMessaging.instance.getToken();
    print('fcm from token ${fcmToken}');
    FirebaseMessaging messaging = FirebaseMessaging.instance;
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    FirebaseMessaging.onMessage.listen((RemoteMessage event) {
      print("message recieved");
      if (event != null &&
          prefs.getString('sender_id') !=
              event.data['senderId'].replaceAll('"', ''))
        showNotification(
            event.data['title'], event.data['body'], event.data['senderId']);
    });
  }

  @override
  void initState() {
    super.initState();
    initialize();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Contacts'),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: const BoxDecoration(
                color: Colors.white,
              ),
              child: Image.asset('assets/images/live-chat.png'),
            ),
            ListTile(
              leading: const Icon(
                Icons.logout,
              ),
              title: const Text('Log out'),
              onTap: () async {
                dialogBox(context);
              },
            ),
          ],
        ),
      ),
      body: BlocBuilder<GetUsersBloc, GetUsersState>(
        builder: (context, state) {
          if (state.getUsersStatus == GetUsersStatus.loading) {
            return contactsSkeleton(context);
          } else if (state.getUsersStatus == GetUsersStatus.loaded) {
            return ListView.builder(
                shrinkWrap: true,
                itemCount: state.userModel.length,
                itemBuilder: (context, index) {
                  return contactTile(
                      context,
                      state.userModel[index]['fullName'],
                      state.userModel[index]['profilePic'],
                      state.userModel[index]['_id']);
                });
          } else if (state.getUsersStatus == GetUsersStatus.error) {
            return Text('Error');
          } else {
            return Container();
          }
        },
      ),
    );
  }
}
