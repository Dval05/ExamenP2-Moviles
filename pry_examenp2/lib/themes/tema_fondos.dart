import 'package:flutter/material.dart';
import 'esquema_color.dart';

// Fondos decorativos reutilizables para las pantallas
class BackgroundThemeApp {
  // Fondo degradado pastel (rosado a celeste)
  static BoxDecoration get pastelGradient {
    return const BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          ColorSchemeApp.primaryPink,
          ColorSchemeApp.lightBlue,
        ],
      ),
    );
  }

  // Fondo claro sencillo
  static BoxDecoration get lightBackground {
    return const BoxDecoration(
      color: ColorSchemeApp.creamBackground,
    );
  }
}
