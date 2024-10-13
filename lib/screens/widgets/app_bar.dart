import 'package:flutter/material.dart';
import '../../constant/colors.dart';

Widget myAppBar(title, callback) {
  return AppBar(
    backgroundColor: bgColor,
    foregroundColor: Colors.black,
    centerTitle: false,
    elevation: 0,
    title: Text(
      title,
      style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
    ),
    actions: [
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: IconButton(
            onPressed: callback,
            icon: Icon(
              Icons.info,
              color: primaryRed,
            )),
      )
    ],
  );
}
