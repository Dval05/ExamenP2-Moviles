import 'package:flutter/material.dart';
import 'esquema_color.dart';
import 'tema_appbar.dart';
import 'tema_botones.dart';
import 'tipografia.dart';

// Tema general que une todos los sub-temas
// Se llama desde main.dart para aplicar el tema completo
class GeneralThemeApp {
  static ThemeData get theme {
    return ThemeData(
      // Esquema de colores principal
      colorScheme: ColorScheme.fromSeed(
        seedColor: ColorSchemeApp.darkPink,
        surface: ColorSchemeApp.creamBackground,
      ),
      // Fondo general de la app
      scaffoldBackgroundColor: ColorSchemeApp.creamBackground,
      // Aplicar tema del AppBar
      appBarTheme: AppBarThemeApp.appBarTheme,
      // Aplicar tema de botones
      elevatedButtonTheme: ButtonThemeApp.elevatedButtonTheme,
      // Aplicar tipografia
      textTheme: TypographyApp.textTheme,
      // Tema de campos de texto con bordes
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: ColorSchemeApp.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: ColorSchemeApp.lightBlue),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: ColorSchemeApp.lightBlue),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: ColorSchemeApp.darkPink, width: 2),
        ),
        labelStyle: TextStyle(color: ColorSchemeApp.softGray),
        prefixIconColor: ColorSchemeApp.lightBlue,
      ),
    );
  }
}
