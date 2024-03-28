import 'package:flutter/material.dart';
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
      body: ListView.builder(
          itemCount: 4,
          itemBuilder: (context, index) {
            return contactTile(context);
          }),
    );
  }
}
