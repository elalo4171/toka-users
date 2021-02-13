import 'package:flutter/material.dart';

class SuperSimpleTheme {
  static const primary = Color(0xFF3DC135);
  static const secondary = Color(0xFF2EAFAD);
  static const textColor = Colors.white;

}

ThemeData get principalTheme {
  return ThemeData(
    primaryColor: SuperSimpleTheme.primary,
    accentColor: SuperSimpleTheme.secondary,
    backgroundColor: SuperSimpleTheme.primary,
    scaffoldBackgroundColor: SuperSimpleTheme.primary,
    appBarTheme: AppBarTheme(color: SuperSimpleTheme.primary),
    textTheme: TextTheme(
      bodyText1: TextStyle(),
      bodyText2: TextStyle(),
    ).apply(
      bodyColor: SuperSimpleTheme.textColor,
      
    ),
  );
}
