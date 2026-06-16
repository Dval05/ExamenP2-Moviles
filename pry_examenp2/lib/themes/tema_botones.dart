import 'package:flutter/material.dart';
import 'esquema_color.dart';

// Tema de botones - redondeados con color rosado pastel
class ButtonThemeApp {
  static ElevatedButtonThemeData get elevatedButtonTheme {
    return ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: ColorSchemeApp.primaryPink,
        foregroundColor: ColorSchemeApp.softGray,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(25),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 14),
        elevation: 3,
        textStyle: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
