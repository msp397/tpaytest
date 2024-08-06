import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData lightTheme = ThemeData(
    primaryColor: Colors.lightBlue,
    hintColor: Colors.grey.shade500,
    cardColor: Colors.white,
    textTheme: const TextTheme(
      labelSmall: TextStyle(
          fontSize: 12.0, fontWeight: FontWeight.normal, color: Colors.black),
      labelMedium: TextStyle(
          fontSize: 14.0, fontWeight: FontWeight.normal, color: Colors.black),
      labelLarge: TextStyle(
          fontSize: 16.0, fontWeight: FontWeight.normal, color: Colors.black),
      titleSmall: TextStyle(
          fontSize: 20.0, fontWeight: FontWeight.bold, color: Colors.black),
      titleMedium: TextStyle(
          fontSize: 24.0, fontWeight: FontWeight.bold, color: Colors.black),
      titleLarge: TextStyle(
          fontSize: 28.0, fontStyle: FontStyle.italic, color: Colors.black),
      displaySmall: TextStyle(
          fontSize: 10.0, fontWeight: FontWeight.normal, color: Colors.black),
      displayLarge: TextStyle(
          fontSize: 72.0, fontWeight: FontWeight.bold, color: Colors.black),
      bodyMedium:
          TextStyle(fontSize: 14.0, fontFamily: 'Arial', color: Colors.black),
    ),
    buttonTheme: const ButtonThemeData(
      buttonColor: Colors.lightBlue,
      textTheme: ButtonTextTheme.primary,
      disabledColor: Colors.grey,
    ),
    scaffoldBackgroundColor: Colors.white,
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.white,
      foregroundColor: Colors.black,
    ),
  );

  static ThemeData darkTheme = ThemeData(
    primaryColor: Colors.lightBlue,
    hintColor: Colors.grey.shade800,
    cardColor: Colors.black,
    textTheme: const TextTheme(
      labelSmall: TextStyle(
          fontSize: 12.0, fontWeight: FontWeight.normal, color: Colors.white),
      labelMedium: TextStyle(
          fontSize: 14.0, fontWeight: FontWeight.normal, color: Colors.white),
      labelLarge: TextStyle(
          fontSize: 16.0, fontWeight: FontWeight.normal, color: Colors.white),
      titleSmall: TextStyle(
          fontSize: 20.0, fontWeight: FontWeight.bold, color: Colors.white),
      titleMedium: TextStyle(
          fontSize: 24.0, fontWeight: FontWeight.bold, color: Colors.white),
      titleLarge: TextStyle(
          fontSize: 28.0, fontStyle: FontStyle.italic, color: Colors.white),
      displaySmall: TextStyle(
          fontSize: 10.0, fontWeight: FontWeight.normal, color: Colors.white),
      displayLarge: TextStyle(
          fontSize: 72.0, fontWeight: FontWeight.bold, color: Colors.white),
      bodyMedium:
          TextStyle(fontSize: 14.0, fontFamily: 'Arial', color: Colors.white),
    ),
    buttonTheme: const ButtonThemeData(
      buttonColor: Colors.lightBlue,
      textTheme: ButtonTextTheme.primary,
      disabledColor: Colors.grey,
    ),
    scaffoldBackgroundColor: Colors.black,
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.black,
      foregroundColor: Colors.white,
    ),
  );
}
