import 'package:flutter/material.dart';

Row textWithIcon<T extends Widget>({
  required String label,
  T? prefixIcon,
  T? suffixIcon,
  TextStyle? textStyle,
  
}) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: <Widget>[
      Row(
        children: [
          prefixIcon ?? const SizedBox.shrink(),
          Text(label, 
            style: textStyle ?? const TextStyle(fontWeight: FontWeight.bold, fontSize: 17)
          )
        ],
      ),
      suffixIcon ?? const SizedBox.shrink(),
    ],
  );
}