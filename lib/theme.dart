import 'package:flutter/material.dart';

class AppTheme {
  static const Color primaryColor = Colors.blue;

  static final ThemeData lightTheme = ThemeData(
    primaryColor: primaryColor,
    brightness: Brightness.light,
  );

  static final ThemeData darkTheme = ThemeData(
    primaryColor: Colors.black,
    brightness: Brightness.dark,
  );
}