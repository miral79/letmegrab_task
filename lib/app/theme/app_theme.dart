import 'package:flutter/material.dart';

class AppThemeData {
  static final lightTheme = ThemeData(
    primarySwatch: Colors.blue,
    brightness: Brightness.light,
    scaffoldBackgroundColor: Colors.white,
    textTheme: TextTheme(
      bodyLarge: TextStyle(color: Colors.black87),
      bodyMedium: TextStyle(color: Colors.black87),
      titleLarge: TextStyle(color: Colors.black87, fontSize: 20),
    ),
  );

  static final darkTheme = ThemeData(
    primarySwatch: Colors.blue,
    brightness: Brightness.dark,
    scaffoldBackgroundColor: Colors.black,
    appBarTheme: AppBarTheme(backgroundColor: Colors.blueAccent, elevation: 0),
    textTheme: TextTheme(
      bodyLarge: TextStyle(color: Colors.white70),
      bodyMedium: TextStyle(color: Colors.white70),
      titleLarge: TextStyle(color: Colors.white70, fontSize: 20),
    ),
  );
}
