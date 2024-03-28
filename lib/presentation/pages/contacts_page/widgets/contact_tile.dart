import 'package:flutter/material.dart';
import 'package:v_chat/presentation/pages/chat_page/page/chat_page.dart';

Widget contactTile(BuildContext context) {
  return InkWell(
    onTap: () {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => ChatPage()));
    },
    child: Container(
      margin: const EdgeInsets.all(10),
      child: const Row(
        children: [
          SizedBox(
            width: 80,
            height: 80,
            child: ClipOval(
              child: Image(image: AssetImage('assets/images/girl.png')),
            ),
          ),
          SizedBox(width: 20),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Nehal Gamal',
                style: TextStyle(fontSize: 20),
              ),
              Text('Hi', style: TextStyle(fontSize: 15))
            ],
          )
        ],
      ),
    ),
  );
}
