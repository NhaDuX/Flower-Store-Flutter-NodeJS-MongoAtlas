import 'package:flutter/material.dart';

MenuStyle commonMenuStyle() {
  return MenuStyle(
    padding: WidgetStateProperty.resolveWith<EdgeInsetsGeometry>(
      (Set<WidgetState> states) {return const EdgeInsets.all(0);},
    ),
    backgroundColor: WidgetStateProperty.resolveWith<Color?>(
      (Set<WidgetState> states) {return Colors.white;},
    ),
    elevation: WidgetStateProperty.resolveWith<double?>(
      (Set<WidgetState> states) {return 0;},
    ),
  );
}