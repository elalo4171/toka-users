import 'package:flutter/material.dart';

class TokaTheme {
  static const primary = Color(0xFF3DC135);
  static const secondary = Color(0xFF2EAFAD);
  static const textColor = Colors.white;
}

ThemeData get principalTheme {
  return ThemeData(
    primaryColor: TokaTheme.primary,
    accentColor: TokaTheme.secondary,
    backgroundColor: TokaTheme.primary,
    scaffoldBackgroundColor: TokaTheme.primary,
    appBarTheme: AppBarTheme(color: TokaTheme.primary),
    textTheme: TextTheme(
      bodyText1: TextStyle(),
      bodyText2: TextStyle(),
      headline2: TextStyle(color: TokaTheme.textColor),
    ).apply(
      bodyColor: TokaTheme.textColor,
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      isDense: true,
      fillColor: Colors.transparent,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(
          color: TokaTheme.textColor,
          width: 1,
        ),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(
          color: TokaTheme.textColor,
          width: 1,
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(
          color: TokaTheme.textColor,
          width: 2,
        ),
      ),
      disabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(
          color: TokaTheme.textColor,
          width: 1,
        ),
      ),
      helperStyle: TextStyle(color: TokaTheme.secondary),
      labelStyle: TextStyle(color: TokaTheme.secondary),
      errorStyle: TextStyle(height: 0.9),
      hintStyle: TextStyle(
        color: TokaTheme.textColor,
        fontWeight: FontWeight.bold,
      ),
    ),
  );
}
