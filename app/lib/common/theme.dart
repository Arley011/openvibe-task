import 'package:flutter/material.dart';

ThemeData lightTheme = ThemeData(
  brightness: Brightness.light,
  useMaterial3: true,
  textTheme: const TextTheme(
    displayLarge: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
    titleSmall: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
    bodyLarge: TextStyle(fontSize: 18, color: Colors.black87),
    bodyMedium: TextStyle(
      fontSize: 16,
      color: Colors.black87,
    ),
    labelMedium: TextStyle(fontSize: 14, color: Colors.black54),
    labelSmall: TextStyle(fontSize: 12, color: Colors.black54),
  ),
  appBarTheme: const AppBarTheme(
    color: Colors.orangeAccent,
    iconTheme: IconThemeData(color: Colors.white),
    titleTextStyle: TextStyle(
      color: Colors.white,
      fontSize: 20,
      fontWeight: FontWeight.bold,
    ),
  ),
  dividerColor: Colors.black12,
  colorScheme: ColorScheme.fromSeed(seedColor: Colors.orangeAccent),
);
