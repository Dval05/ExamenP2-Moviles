import 'package:flutter/material.dart';
import 'esquema_color.dart';
import 'tema_appbar.dart';
import 'tema_botones.dart';
import 'tipografia.dart';

class GeneralThemeApp {
  static ThemeData get theme {
    return ThemeData(
      colorScheme: ColorScheme.fromSeed(
        seedColor: ColorSchemeApp.darkPink,
        surface: ColorSchemeApp.creamBackground,
      ),
      scaffoldBackgroundColor: ColorSchemeApp.creamBackground,
      appBarTheme: AppBarThemeApp.appBarTheme,
      elevatedButtonTheme: ButtonThemeApp.elevatedButtonTheme,
      textTheme: TypographyApp.textTheme,
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: ColorSchemeApp.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: ColorSchemeApp.lightBlue),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: ColorSchemeApp.lightBlue),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: ColorSchemeApp.darkPink, width: 2),
        ),
        labelStyle: const TextStyle(color: ColorSchemeApp.softGray),
        prefixIconColor: ColorSchemeApp.darkPink,
      ),
      cardTheme: CardTheme(
        color: ColorSchemeApp.white,
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      ),
    );
  }
}