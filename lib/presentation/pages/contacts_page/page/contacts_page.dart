import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:v_chat/bloc/get_users_bloc/get_users_bloc.dart';
import 'package:v_chat/presentation/pages/contacts_page/widgets/contact_tile.dart';
import 'package:v_chat/presentation/pages/custom_widgets/dialog_alert.dart';
import 'package:v_chat/presentation/pages/login_page/page/login_page.dart';
import 'package:v_chat/presentation/pages/skeleton/contacts_skeleton/contacts_skeleton.dart';

class ContactsPage extends StatelessWidget {
  const ContactsPage({super.key});

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
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text('Drawer Header'),
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
          } else {
            return Container();
          }
        },
      ),
    );
  }
}
