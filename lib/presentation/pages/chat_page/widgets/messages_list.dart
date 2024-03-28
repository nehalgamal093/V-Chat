import 'package:flutter/material.dart';
import 'package:v_chat/presentation/pages/chat_page/widgets/chat_message.dart';

Widget messagesList() {
  return Column(
    children: [
      chatMessage(true, 'Hi'),
      chatMessage(false, 'Hi, How are you?'),
      chatMessage(true, 'Good, And you?')
    ],
  );
}
