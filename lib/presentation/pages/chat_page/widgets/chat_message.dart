import 'package:flutter/material.dart';
import 'package:v_chat/presentation/pages/chat_page/widgets/message_tail.dart';

Widget chatMessage(bool isSender, String message) {
  return Stack(
    children: [
      Align(
        alignment: isSender ? Alignment.centerRight : Alignment.centerLeft,
        child: Container(
          margin: const EdgeInsets.only(left: 20, top: 10, right: 20),
          constraints: const BoxConstraints(minWidth: 30.0, minHeight: 35.0),
          decoration: BoxDecoration(
            color: isSender ? Colors.blue : Colors.grey,
            borderRadius: const BorderRadius.all(
              Radius.circular(10),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment:
                  isSender ? CrossAxisAlignment.start : CrossAxisAlignment.end,
              children: [
                Text(
                  message,
                  style: const TextStyle(color: Colors.white),
                ),
                const SizedBox(
                  height: 5,
                ),
                SizedBox(
                  width: 40,
                  child: Align(
                    alignment:
                        isSender ? Alignment.topRight : Alignment.centerLeft,
                    child: const Text(
                      '12:00 PM',
                      style: TextStyle(fontSize: 8, color: Colors.white),
                    ),
                  ),
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
