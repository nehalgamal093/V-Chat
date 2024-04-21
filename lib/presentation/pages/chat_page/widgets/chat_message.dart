import 'package:flutter/material.dart';
import 'package:v_chat/presentation/pages/chat_page/widgets/message_tail.dart';
import 'package:v_chat/utils/capitalize.dart';

Widget chatMessage(bool isSender, String message, String time) {
  return Stack(
    children: [
      Align(
        alignment: isSender ? Alignment.centerRight : Alignment.centerLeft,
        child: Container(
          margin: const EdgeInsets.only(left: 20, top: 10, right: 20),
          constraints: const BoxConstraints(
            minWidth: 50.0,
            minHeight: 35.0,
            maxWidth: 300,
          ),
          decoration: BoxDecoration(
            color: isSender
                ? const Color(0xfffe5151)
                : const Color.fromARGB(255, 218, 236, 249),
            borderRadius: const BorderRadius.all(
              Radius.circular(10),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.2),
                spreadRadius: 1,
                blurRadius: 7,
                offset: const Offset(0, 0), // changes position of shadow
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment:
                  isSender ? CrossAxisAlignment.start : CrossAxisAlignment.end,
              children: [
                Text(
                  capitalizeName(message),
                  style: TextStyle(
                      color: isSender ? Colors.white : Colors.black,
                      fontFamily: 'Montserrat',
                      fontSize: 15),
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  time,
                  style: TextStyle(
                      fontSize: 8,
                      color: isSender ? Colors.white : Colors.black),
                )
              ],
            ),
          ),
        ),
      ),
      isSender
          ? Positioned(
              width: 20,
              height: 20,
              top: 15,
              right: 5,
              child: CustomPaint(
                painter: TrianglePainter(isSender: isSender),
              ),
            )
          : Positioned(
              width: 20,
              height: 20,
              bottom: 1,
              left: 10,
              child: CustomPaint(
                painter: TrianglePainter(isSender: isSender),
              ),
            )
    ],
  );
}
