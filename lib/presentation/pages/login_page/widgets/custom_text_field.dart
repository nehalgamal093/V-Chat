import 'package:flutter/material.dart';
import 'package:v_chat/presentation/resources/color_manager.dart';

Widget customTextField(BuildContext context, String hintText) {
  double width = MediaQuery.of(context).size.width;

  return Container(
    width: width * .8,
    height: 40,
    margin: const EdgeInsets.all(10),
    decoration: const BoxDecoration(),
    child: TextField(
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: const TextStyle(color: ColorManager.lightGrey),
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        border: const OutlineInputBorder(
          borderSide: BorderSide(
            color: ColorManager.lightGrey,
          ),
        ),
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            color: ColorManager.lightGrey,
          ),
        ),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            color: ColorManager.lightGrey,
          ),
        ),
      ),
    ),
  );
}
