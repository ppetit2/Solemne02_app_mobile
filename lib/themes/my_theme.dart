import 'package:flutter/material.dart';

class MyTheme {
  // Colores base
  static const Color primary = Color(0xFF2E7D32); // Verde elegante
  static const Color secondary = Color(0xFF66BB6A); // Verde suave
  static const Color background = Color(0xFFF1F8F4); // Verde muy claro

  static final ThemeData myTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,

    // Colores principales
    colorScheme: ColorScheme.fromSeed(
      seedColor: primary,
      primary: primary,
      secondary: secondary,
      background: background,
    ),

    scaffoldBackgroundColor: background,

    // Tipografía
    fontFamily: 'Raleway',

    // AppBar
    appBarTheme: const AppBarTheme(
      backgroundColor: primary,
      foregroundColor: Colors.white,
      elevation: 0,
      centerTitle: true,
    ),

    // Botones
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: primary,
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(14),
        ),
        padding: const EdgeInsets.symmetric(vertical: 14),
      ),
    ),

    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: primary,
      ),
    ),

    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: primary,
      foregroundColor: Colors.white,
    ),

    // Inputs (login, formularios)
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: Colors.white,
      labelStyle: const TextStyle(color: primary),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: BorderSide.none,
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: const BorderSide(color: primary, width: 1.5),
      ),
    ),
  );
}

