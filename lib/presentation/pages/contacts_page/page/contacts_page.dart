import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:v_chat/bloc/get_users_bloc/get_users_bloc.dart';
import 'package:v_chat/presentation/pages/contacts_page/widgets/contact_tile.dart';

class ContactsPage extends StatelessWidget {
  const ContactsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('Contacts'),
      ),
      body: BlocBuilder<GetUsersBloc, GetUsersState>(
        builder: (context, state) {
          if (state.getUsersStatus == GetUsersStatus.loading) {
            return CircularProgressIndicator();
          } else if (state.getUsersStatus == GetUsersStatus.loaded) {
            return ListView.builder(
                shrinkWrap: true,
                itemCount: 4,
                itemBuilder: (context, index) {
                  return contactTile(context);
                });
          } else {
            return Container();
          }
        },
      ),
    );
  }
}
