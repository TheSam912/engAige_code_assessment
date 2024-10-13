import 'package:flutter/material.dart';

import '../../constant/colors.dart';

Widget line(completed) {
  return Row(
    children: [
      Expanded(
        child: Container(
          height: 8,
          margin: const EdgeInsets.only(left: 14, right: 5, bottom: 8, top: 8),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              color: primaryRed,
              border: Border.all(color: primaryRed, width: 1.5)),
        ),
      ),
      Expanded(
        child: Container(
          height: 8,
          margin: const EdgeInsets.only(right: 14, left: 5, bottom: 8, top: 8),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              color: completed ? bgColor : primaryRed,
              border: Border.all(color: primaryRed, width: 1.5)),
        ),
      ),
    ],
  );
}
