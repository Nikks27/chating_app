import 'package:flutter/material.dart';


PopupMenuItem<String> buildPopupMenuItem(String title,) {
  return PopupMenuItem(
    value: title,
    child: Row(
      children: [
        // Icon(icon, color: Colors.black),
        SizedBox(width: 10),
        Text(title),
      ],
    ),
  );
}