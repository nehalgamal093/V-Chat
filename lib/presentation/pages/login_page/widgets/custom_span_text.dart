import 'package:flutter/material.dart';

Widget customSpanText(String title, String span) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Text(
        title,
      ),
      const SizedBox(width: 3.0),
      Text(span),
    ],
  );
}
