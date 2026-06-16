import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodel/poliza_viewmodel.dart';
import '../../themes/esquema_color.dart';

class PerfilPage extends StatelessWidget {
  const PerfilPage({super.key});

  @override
  Widget build(BuildContext context) {
    final vm = Provider.of<PolizaViewModel>(context);
    final agente = vm.agente;

    return Center(
      child: vm.loading && agente == null
          ? const CircularProgressIndicator(color: ColorSchemeApp.darkPink)
          : agente == null
              ? const Text("Cargando perfil...")
              : Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const CircleAvatar(
                      radius: 60,
                      backgroundColor: ColorSchemeApp.lavender,
                      child: Icon(Icons.person, size: 60, color: ColorSchemeApp.softGray),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      agente.nombre, 
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 10),
                    Text(agente.cargo, style: Theme.of(context).textTheme.bodyMedium),
                    const SizedBox(height: 5),
                    Text("Sucursal: ${agente.sucursal}", style: Theme.of(context).textTheme.bodySmall),
                    const SizedBox(height: 20),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      decoration: BoxDecoration(
                        color: ColorSchemeApp.lightBlue,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        "Pólizas Vendidas: ${agente.totalPolizasVendidas}",
                        style: const TextStyle(fontWeight: FontWeight.bold, color: ColorSchemeApp.darkPink),
                      ),
                    ),
                  ],
                ),
    );
  }
}