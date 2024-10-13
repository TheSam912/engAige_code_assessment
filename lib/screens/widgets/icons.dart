import 'package:flutter/material.dart';

import '../../constant/colors.dart';

Widget iconDB(context, callback,icon) {
  return IconButton(
      onPressed: callback,
      icon: Icon(
        icon,
        color: primaryRed,
      ));
}
