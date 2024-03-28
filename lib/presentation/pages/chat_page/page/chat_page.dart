import 'package:flutter/material.dart';
import 'package:v_chat/presentation/pages/chat_page/widgets/message_input.dart';
import 'package:v_chat/presentation/pages/chat_page/widgets/messages_list.dart';

class ChatPage extends StatelessWidget {
  const ChatPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chat'),
      ),
      body: Container(
        decoration: const BoxDecoration(),
        height: MediaQuery.of(context).size.height,
        child: Column(
          children: [Expanded(child: messagesList()), messageInput(context)],
        ),
      ),
    );
  }
}
