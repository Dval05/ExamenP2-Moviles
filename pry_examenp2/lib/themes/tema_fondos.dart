import 'package:flutter/material.dart';
import 'esquema_color.dart';

class BackgroundThemeApp {
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
}