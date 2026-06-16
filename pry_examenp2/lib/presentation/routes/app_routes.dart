import 'package:flutter/material.dart';
import '../views/home_page.dart';

class AppRoutes {
  static final Map<String, Widget Function(BuildContext)> routes = {
    "/": (context) => const HomePage(),
  };
}