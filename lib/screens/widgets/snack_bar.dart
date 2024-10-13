import 'package:flutter/material.dart';

import '../../constant/colors.dart';

SnackBar customSnackBar(text) {
  return SnackBar(
      backgroundColor: primaryRed,
      content: Text(
        text,
        style: TextStyle(color: bgColor, fontWeight: FontWeight.bold, fontSize: 14),
      ));
}
