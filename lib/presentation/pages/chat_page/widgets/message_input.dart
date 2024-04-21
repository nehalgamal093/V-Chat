import 'package:flutter/material.dart';

Widget messageInput(BuildContext context, TextEditingController controller,
    VoidCallback onPressed, ScrollController scrollController) {
  double width = MediaQuery.of(context).size.width;
  return Focus(
    onFocusChange: (hasFocus) {},
    child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: width * .80,
            height: 50,
            child: TextField(
              onChanged: (val) {
                scrollController.jumpTo(
                  scrollController.position.maxScrollExtent,
                );
              },
              controller: controller,
              style: Theme.of(context).textTheme.bodyMedium,
              decoration: InputDecoration(
                  hintText: 'Send message..',
                  focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                          width: 1, color: Color.fromARGB(255, 194, 194, 194)),
                      borderRadius: BorderRadius.circular(20)),
                  enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                          width: 1, color: Color.fromARGB(255, 194, 194, 194)),
                      borderRadius: BorderRadius.circular(20)),
                  border: OutlineInputBorder(
                      borderSide: const BorderSide(
                          width: 1, color: Color.fromARGB(255, 194, 194, 194)),
                      borderRadius: BorderRadius.circular(20))),
            ),
          ),
          const SizedBox(width: 10),
          CircleAvatar(
              backgroundColor: const Color(0xfffe5151),
              child: IconButton(
                onPressed: onPressed,
                icon: const Icon(Icons.send_rounded),
                color: Colors.white,
              )),
        ],
      ),
    ),
  );
}
