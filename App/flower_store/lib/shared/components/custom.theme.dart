import 'package:flutter/material.dart';

final ThemeData customDarkTheme = ThemeData.dark().copyWith(
  brightness: Brightness.dark,
  cardColor: const Color(0xff000000),
  scaffoldBackgroundColor: const Color(0xff2D2C2C),
  appBarTheme: const AppBarTheme(color: Color(0xffE5386D)),
);

final ThemeData customLightTheme = ThemeData.light().copyWith(
  brightness: Brightness.light,
  cardColor: const Color(0xffFFFFFF),
  scaffoldBackgroundColor: const Color(0xffF0F0F0),
  appBarTheme: const AppBarTheme(color: Color(0xffFF85A1)),
);
