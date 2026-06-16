import 'package:flutter/material.dart';
import '../../themes/esquema_color.dart';

class PerfilPage extends StatelessWidget {
  const PerfilPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const CircleAvatar(
            radius: 60,
            backgroundColor: ColorSchemeApp.lavender,
            child: Icon(Icons.person, size: 60, color: ColorSchemeApp.softGray),
          ),
          const SizedBox(height: 20),
          Text("Administrador", style: Theme.of(context).textTheme.titleLarge),
          const SizedBox(height: 10),
          Text("Gestión de Pólizas", style: Theme.of(context).textTheme.bodyMedium),
        ],
      ),
    );
  }
}