import 'package:flutter/material.dart';
import 'esquema_color.dart';

// Tema del AppBar - rosado pastel con texto oscuro
class AppBarThemeApp {
  static AppBarTheme get appBarTheme {
    return const AppBarTheme(
      backgroundColor: ColorSchemeApp.primaryPink,
      foregroundColor: ColorSchemeApp.softGray,
      centerTitle: true,
      elevation: 0,
      titleTextStyle: TextStyle(
        color: ColorSchemeApp.softGray,
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}
