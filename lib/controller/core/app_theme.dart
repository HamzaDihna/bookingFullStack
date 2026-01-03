import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    scaffoldBackgroundColor: Colors.grey.shade100,

    colorScheme: const ColorScheme.light(
      primary: Color(0xFF0091C7),
      secondary: Color(0xFF1689C5),
      background: Color(0xFFF5F5F5),
      surface: Colors.white,
      onPrimary: Colors.white,
      onBackground: Colors.black,
      onSurface: Colors.black,
    ),

    appBarTheme: const AppBarTheme(
      backgroundColor: Color(0xFF0091C7),
      foregroundColor: Colors.white,
      elevation: 0,
    ),

    cardColor: Colors.white,

    textTheme: const TextTheme(
      bodyMedium: TextStyle(color: Colors.black87),
      titleLarge: TextStyle(color: Colors.black),
    ),
  );

  static ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    scaffoldBackgroundColor: const Color(0xFF121212),

    colorScheme: const ColorScheme.dark(
      primary: Color(0xFF1689C5),
      secondary: Color(0xFF0091C7),
      background: Color(0xFF121212),
      surface: Color(0xFF1E1E1E),
      onPrimary: Colors.white,
      onBackground: Colors.white,
      onSurface: Colors.white,
    ),

    appBarTheme: const AppBarTheme(
      backgroundColor: Color(0xFF1E1E1E),
      foregroundColor: Colors.white,
      elevation: 0,
    ),

    cardColor: Color(0xFF1E1E1E),

    textTheme: const TextTheme(
      bodyMedium: TextStyle(color: Colors.white70),
      titleLarge: TextStyle(color: Colors.white),
    ),
  );
}
