import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData lightTheme(BuildContext context) {
    return ThemeData(
      brightness: Brightness.light,
      primaryColor: Colors.white,
      appBarTheme: const AppBarTheme(
        backgroundColor: Color(0xffF2F2F6),
        surfaceTintColor: Color(0xffF2F2F6),
      ),
      scaffoldBackgroundColor: const Color(0xffF2F2F6),
      textTheme: TextTheme(
        headlineLarge: TextStyle(
          fontSize: MediaQuery.of(context).size.width * 0.07,
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
        headlineMedium: TextStyle(
          fontSize: MediaQuery.of(context).size.width * 0.05,
          color: Colors.grey[700],
        ),
        bodySmall: TextStyle(
          fontSize: MediaQuery.of(context).size.width * 0.04,
          color: Colors.black,
        ),
        bodyMedium: TextStyle(
          fontSize: MediaQuery.of(context).size.width * 0.05,
          color: Colors.black,
          fontWeight: FontWeight.bold,
        ),
      ),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: Colors.white,
        foregroundColor: Colors.grey[700],
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
        ),
      ),
    );
  }

  static ThemeData darkTheme(BuildContext context) {
    return ThemeData(
      brightness: Brightness.dark,
      primaryColor: const Color(0xFF1C1C1E),
      scaffoldBackgroundColor: const Color(0xFF000000),
      appBarTheme: const AppBarTheme(
        backgroundColor: Color(0xFF000000),
        surfaceTintColor: Color(0xFF000000),
      ),
      textTheme: TextTheme(
        headlineLarge: TextStyle(
          fontSize: MediaQuery.of(context).size.width * 0.07,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
        headlineMedium: TextStyle(
          fontSize: MediaQuery.of(context).size.width * 0.05,
          color: Colors.white70,
        ),
        bodySmall: TextStyle(
          fontSize: MediaQuery.of(context).size.width * 0.04,
          color: Colors.white,
        ),
        bodyMedium: TextStyle(
          fontSize: MediaQuery.of(context).size.width * 0.05,
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: const Color(0xFF1C1C1E),
        foregroundColor: Colors.grey[300],
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF1C1C1E),
          foregroundColor: Colors.white,
        ),
      ),
    );
  }
}
