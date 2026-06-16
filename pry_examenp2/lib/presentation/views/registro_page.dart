import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../domain/entities/poliza.dart';
import '../viewmodel/poliza_viewmodel.dart';
import '../../themes/esquema_color.dart';

class RegistroPage extends StatefulWidget {
  const RegistroPage({super.key});

  @override
  State<RegistroPage> createState() => _RegistroPageState();
}

class _RegistroPageState extends State<RegistroPage> {
  final _formKey = GlobalKey<FormState>();
  final _clienteController = TextEditingController();
  final _valorController = TextEditingController();
  String _tipoSeguro = 'Seguro de Vida';
  DateTime _fechaInicio = DateTime.now();
  DateTime _fechaVencimiento = DateTime.now().add(const Duration(days: 365));

  final List<String> _tipos = [
    'Seguro de Vida', 'Seguro de Salud', 'Seguro de Hogar',
    'Seguro de Automóvil', 'Seguro de Crédito'
  ];

  @override
  void initState() {
    super.initState();
    // Pre-llenar datos si estamos en modo edición
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final vm = Provider.of<PolizaViewModel>(context, listen: false);
      if (vm.polizaEnEdicion != null) {
        final p = vm.polizaEnEdicion!;
        _clienteController.text = p.cliente;
        _valorController.text = p.valorAsegurado.toString();
        setState(() {
          _tipoSeguro = p.tipoSeguro;
          _fechaInicio = p.fechaInicio;
          _fechaVencimiento = p.fechaVencimiento;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final vm = Provider.of<PolizaViewModel>(context);
    final esEdicion = vm.polizaEnEdicion != null;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(20.0),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              esEdicion ? "Actualizar Póliza" : "Registrar Nueva Póliza",
              style: Theme.of(context).textTheme.titleLarge,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            TextFormField(
              controller: _clienteController,
              decoration: const InputDecoration(labelText: "Nombre del Cliente", prefixIcon: Icon(Icons.person)),
              validator: (v) => v!.isEmpty ? 'Requerido' : null,
            ),
            const SizedBox(height: 15),
            DropdownButtonFormField<String>(
              value: _tipoSeguro,
              decoration: const InputDecoration(labelText: "Tipo de Seguro", prefixIcon: Icon(Icons.security)),
              items: _tipos.map((t) => DropdownMenuItem(value: t, child: Text(t))).toList(),
              onChanged: (val) => setState(() => _tipoSeguro = val!),
            ),
            const SizedBox(height: 15),
            TextFormField(
              controller: _valorController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: "Valor Asegurado", prefixIcon: Icon(Icons.monetization_on)),
              validator: (v) => v!.isEmpty ? 'Requerido' : null,
            ),
            const SizedBox(height: 25),
            ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  final poliza = Poliza(
                    codigo: vm.polizaEnEdicion?.codigo, // Mantiene el código si es edición
                    cliente: _clienteController.text,
                    tipoSeguro: _tipoSeguro,
                    fechaInicio: _fechaInicio,
                    fechaVencimiento: _fechaVencimiento,
                    valorAsegurado: double.parse(_valorController.text),
                  );
                  vm.createOrUpdatePoliza(poliza);
                }
              },
              child: Text(esEdicion ? "ACTUALIZAR" : "GUARDAR"),
            ),
          ],
        ),
      ),
    );
  }
}