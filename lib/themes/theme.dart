import 'package:flutter/material.dart';

final ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    primaryColor: Colors.blue.shade800,
    primaryColorDark: Colors.blue.shade500,
    primaryColorLight: Colors.blue.shade100,
    cardColor: Colors.white);

final ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    primaryColor: Colors.black,
    primaryColorDark: Colors.black,
    primaryColorLight: Colors.blue.shade100,
    cardColor: Colors.black);
