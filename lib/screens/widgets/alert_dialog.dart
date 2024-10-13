import 'package:flutter/material.dart';
import 'package:meal_tracker/constant/colors.dart';

showAlertDialog(BuildContext context, title, content) {
  AlertDialog alertDialog = AlertDialog(
    title: Text(title),
    content: Text(content),
    backgroundColor: bgColor,
    actions: [
      TextButton(
        child: Text(
          "OK",
          style: TextStyle(color: primaryRed, fontWeight: FontWeight.bold),
        ),
        onPressed: () {
          Navigator.pop(context);
        },
      )
    ],
  );

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alertDialog;
    },
  );
}
