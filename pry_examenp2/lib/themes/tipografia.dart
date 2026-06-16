import 'package:flutter/material.dart';

// Tipografia general de la app
class TypographyApp {
  static TextTheme get textTheme {
    return const TextTheme(
      // Titulo grande
      titleLarge: TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.bold,
        color: Color(0xFF4A4A4A),
      ),
      // Titulo mediano
      titleMedium: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w600,
        color: Color(0xFF4A4A4A),
      ),
      // Texto normal
      bodyMedium: TextStyle(
        fontSize: 16,
        color: Color(0xFF4A4A4A),
      ),
      // Texto pequeno
      bodySmall: TextStyle(
        fontSize: 14,
        color: Color(0xFF757575),
      ),
    );
  }
}
