import 'package:flutter/material.dart';

class TypographyApp {
  static TextTheme get textTheme {
    return const TextTheme(
      titleLarge: TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.bold,
        color: Color(0xFF4A4A4A),
      ),
      titleMedium: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w600,
        color: Color(0xFF4A4A4A),
      ),
      bodyMedium: TextStyle(
        fontSize: 16,
        color: Color(0xFF4A4A4A),
      ),
      bodySmall: TextStyle(
        fontSize: 14,
        color: Color(0xFF757575),
      ),
    );
  }
}