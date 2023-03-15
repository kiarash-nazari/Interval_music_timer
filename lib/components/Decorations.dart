// ignore: file_names
import 'package:flutter/material.dart';

class MyDecoration {
  InputDecoration inputDecorations(
      {required Color focusedBorderColor,
      required Color enabledBorderColor,
      required IconData prefixIcon,
      required Color prefixIconColor,
      required String lableText,
      required Color lableTextColor,
      required String helperText,
      required Color helperTextColor,
      required String suffixText,
      required String hintText,
      required Color suffixTextColor,
      required double radius}) {
    return InputDecoration(
        floatingLabelBehavior: FloatingLabelBehavior.always,
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radius),
          borderSide: BorderSide(color: focusedBorderColor, width: 2.0),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radius),
          borderSide: BorderSide(color: enabledBorderColor, width: 2.0),
        ),
        prefixIcon: Icon(
          prefixIcon,
          color: prefixIconColor,
        ),
        hintText: hintText,
        hintStyle: const TextStyle(color: Color.fromARGB(190, 184, 184, 184)),
        labelText: lableText,
        labelStyle: TextStyle(color: lableTextColor),
        helperText: helperText,
        helperStyle: TextStyle(color: helperTextColor),
        suffixText: suffixText,
        suffixStyle: TextStyle(color: suffixTextColor)

        // errorText: 'Hello'
        );
  }
}

