import 'package:flutter/material.dart';

Widget ListTileIncomplete(BuildContext context, title) {
  return Card(
    margin: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
    color: Colors.white,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
      child: ListTile(
        title: Text(title),
        trailing: IconButton(
            onPressed: () {
            },
            icon: const Icon(
              Icons.add_box,
              color: Colors.red,
            )),
      ),
    ),
  );
}
