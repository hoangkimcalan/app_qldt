import 'package:flutter/material.dart';

InputDecoration InputDecorationLecture(String title) {
  return InputDecoration(
    labelText: title,
    labelStyle: TextStyle(color: Colors.white, fontSize: 20.0),
    filled: true,
    fillColor: Colors.transparent,
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.white, width: 2),
      borderRadius: BorderRadius.all(Radius.circular(20)),
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.white, width: 2),
    ),
  );
}
