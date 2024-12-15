import 'package:app_qldt_hust/core/theme/colors.dart';
import 'package:flutter/material.dart';

TextFormField TextFormFieldAuth(String title) {
  return TextFormField(
    style: TextStyle(color: Colors.white),
    decoration: InputDecoration(
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
    ),
    textInputAction: TextInputAction.done,
    maxLines: 1,
  );
}

InputDecoration InputDecorationAuth(String title) {
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

Widget buttonColors(
    BuildContext context, String text, double fontsize, Function() onTap) {
  return GestureDetector(
    onTap: onTap,
    child: Container(
      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 20),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(30)),
        color: AppColors.white,
      ),
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: TextStyle(
            color: AppColors.red302A,
            fontSize: fontsize,
            fontWeight: FontWeight.w500),
      ),
    ),
  );
}
