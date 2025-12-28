import 'package:flutter/material.dart';

class InputDecorations {
  static InputDecoration authInputDecoration({
    required String hinText,
    required String labelText,
    IconData? prefixIcon,
  }) {
    return InputDecoration(
      enabledBorder: UnderlineInputBorder(
        borderSide: BorderSide(color: Colors.blueGrey),
      ),
      focusedBorder: UnderlineInputBorder(
        borderSide: BorderSide(color: Colors.blueGrey, width: 3),
      ),
      hintText: hinText,
      labelText: labelText,
      prefixIcon: prefixIcon != null
          ? Icon(prefixIcon, color: Colors.blueGrey)
          : null,
    );
  }
}