// 应用主题配置

import 'package:flutter/material.dart';

class AppTheme {
  // 亮色主题
  static final ThemeData lightTheme = ThemeData(
    primarySwatch: Colors.blue,
    brightness: Brightness.light,
    scaffoldBackgroundColor: Colors.white,
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.blue,
      foregroundColor: Colors.white,
      elevation: 4,
    ),
    cardTheme: CardTheme(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
    ),
    buttonTheme: const ButtonThemeData(
      buttonColor: Colors.blue,
      textTheme: ButtonTextTheme.primary,
    ),
    inputDecorationTheme: InputDecorationTheme(
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
      filled: true,
      fillColor: Colors.grey[100],
    ),
    textTheme: const TextTheme(
      headline6: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      bodyText1: TextStyle(fontSize: 16),
      bodyText2: TextStyle(fontSize: 14, color: Colors.grey),
    ),
  );

  // 暗色主题
  static final ThemeData darkTheme = ThemeData(
    primarySwatch: Colors.blue,
    brightness: Brightness.dark,
    scaffoldBackgroundColor: Colors.grey[900],
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.grey[800],
      foregroundColor: Colors.white,
      elevation: 4,
    ),
    cardTheme: CardTheme(
      elevation: 2,
      color: Colors.grey[800],
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
    ),
    buttonTheme: const ButtonThemeData(
      buttonColor: Colors.blue,
      textTheme: ButtonTextTheme.primary,
    ),
    inputDecorationTheme: InputDecorationTheme(
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
      filled: true,
      fillColor: Colors.grey[700],
    ),
    textTheme: const TextTheme(
      headline6: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      bodyText1: TextStyle(fontSize: 16),
      bodyText2: TextStyle(fontSize: 14, color: Colors.grey),
    ),
  );
}