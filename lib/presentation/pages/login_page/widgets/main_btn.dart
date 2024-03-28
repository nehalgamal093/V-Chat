import 'package:flutter/material.dart';

Widget mainBtn(BuildContext context, String title) {
  double width = MediaQuery.of(context).size.width;
  return Container(
    height: 40,
    width: width * .8,
    decoration: const BoxDecoration(
        color: Colors.amber,
        borderRadius: BorderRadius.all(Radius.circular(10))),
    child: Center(
        child: Text(
      title,
      style: const TextStyle(
          color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
    )),
  );
}
