import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:v_chat/bloc/get_messages_bloc/get_messages_bloc.dart';
import 'package:v_chat/presentation/pages/chat_page/page/chat_page.dart';
import 'package:v_chat/utils/capitalize.dart';

Widget contactTile(
    BuildContext context, String fullName, String imgUrl, String id) {
  return InkWell(
    onTap: () {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => ChatPage(
                    id: id,
                    name: capitalizeName(fullName),
                    img: imgUrl,
                  )));
      context.read<GetMessagesBloc>().add(MessagesEvent(id: id));
    },
    child: Container(
      margin: const EdgeInsets.all(10),
      child: Row(
        children: [
          SizedBox(
            width: 80,
            height: 80,
            child: ClipOval(
              child: Image(image: NetworkImage(imgUrl)),
            ),
          ),
          const SizedBox(width: 20),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                capitalizeName(fullName),
                style: const TextStyle(fontSize: 20),
              ),
              const Text('Hi', style: TextStyle(fontSize: 15))
            ],
          )
        ],
      ),
    ),
  );
}
