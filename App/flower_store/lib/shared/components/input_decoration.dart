 import 'package:control_style/control_style.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Container genericFieldContainer({required Widget field}) {
  return Container(
    padding: const EdgeInsets.only(top: 20),
    child: field,
  );
}

InputDecoration genericInputDecoration(
  {
    required String label,
    IconData? prefixIcon,
    IconData? suffixIcon,
    String? errorText
  }
  ) {
  return InputDecoration(
    labelText: label,
    enabledBorder: shadowBorder(Colors.white),
    focusedBorder: shadowBorder(Colors.grey.shade400),
    focusedErrorBorder: shadowBorder(Colors.red),
    errorBorder: shadowBorder(Colors.red),
    errorText: errorText,
    fillColor: Colors.white,
    filled: true,
    floatingLabelBehavior: FloatingLabelBehavior.never,
    prefixIcon: fieldIcon(prefixIcon),
    suffixIcon: fieldIcon(suffixIcon),
  );
}

DecoratedInputBorder shadowBorder(Color borderColor) {
  return DecoratedInputBorder(
    shadow: [
      BoxShadow(
        color: Colors.grey.shade500,
        blurRadius: 10,
        offset: const Offset(0, 3)
      )
    ],
    child: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide(color: borderColor)
    ),
  );
}

OutlineInputBorder errorBorder() {
  return const OutlineInputBorder(
    borderSide:  BorderSide(color: Colors.red)
  );
}

Widget? fieldIcon(IconData? icon) {
  return icon != null 
  ? Align(
    widthFactor: 1.0,
    heightFactor: 1.0,
    child: Icon(icon),
  ) 
  : null;
}