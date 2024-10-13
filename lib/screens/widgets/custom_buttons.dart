import 'package:flutter/material.dart';

import '../../constant/colors.dart';

buttonDesign(callback, text, cancel) {
  return GestureDetector(
    onTap: callback,
    child: Container(
      width: 200,
      padding: const EdgeInsets.symmetric(vertical: 12),
      margin: const EdgeInsets.symmetric(vertical: 8),
      alignment: Alignment.center,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: primaryRed, width: 2),
          color: cancel ? bgColor : primaryRed),
      child: Text(
        text,
        style: TextStyle(color: cancel ? primaryRed : Colors.white, fontWeight: FontWeight.bold),
      ),
    ),
  );
}
