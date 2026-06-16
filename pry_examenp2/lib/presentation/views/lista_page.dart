import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodel/poliza_viewmodel.dart';
import '../../themes/esquema_color.dart';

class ListaPage extends StatelessWidget {
  const ListaPage({super.key});

  @override
  Widget build(BuildContext context) {
    final vm = Provider.of<PolizaViewModel>(context);

    if (vm.loading) {
      return const Center(child: CircularProgressIndicator(color: ColorSchemeApp.darkPink));
    }

    if (vm.polizas.isEmpty) {
      return const Center(child: Text("No hay pólizas registradas."));
    }

    return ListView.builder(
      padding: const EdgeInsets.all(12),
      itemCount: vm.polizas.length,
      itemBuilder: (context, index) {
        final p = vm.polizas[index];
        return Card(
          margin: const EdgeInsets.only(bottom: 12),
          child: ListTile(
            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            leading: const CircleAvatar(
              backgroundColor: ColorSchemeApp.lightBlue,
              child: Icon(Icons.article, color: ColorSchemeApp.softGray),
            ),
            title: Text(p.cliente, style: const TextStyle(fontWeight: FontWeight.bold)),
            subtitle: Text("${p.tipoSeguro}\nValor: \$${p.valorAsegurado}"),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: const Icon(Icons.edit, color: Colors.blue),
                  onPressed: () => vm.prepararEdicion(p),
                ),
                IconButton(
                  icon: const Icon(Icons.delete, color: Colors.red),
                  onPressed: () => _mostrarDialogoEliminar(context, vm, p.codigo!),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _mostrarDialogoEliminar(BuildContext context, PolizaViewModel vm, String codigo) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Eliminar Póliza"),
        content: const Text("¿Estás seguro de que deseas eliminar este registro?"),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text("Cancelar")),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            onPressed: () {
              vm.deletePoliza(codigo);
              Navigator.pop(context);
            },
            child: const Text("Eliminar"),
          ),
        ],
      ),
    );
  }
}