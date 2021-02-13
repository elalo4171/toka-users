import 'package:flutter/material.dart';

class SuperSimpleTheme {
  static const primary = Color(0xFF3DC135);
  static const secondary = Color(0xFF2EAFAD);
}

ThemeData get principalTheme {
  return ThemeData(
      primaryColor: SuperSimpleTheme.primary,
      accentColor: SuperSimpleTheme.secondary,
      backgroundColor: SuperSimpleTheme.primary,
      scaffoldBackgroundColor: SuperSimpleTheme.primary,
      appBarTheme: AppBarTheme(color: SuperSimpleTheme.primary));
}
