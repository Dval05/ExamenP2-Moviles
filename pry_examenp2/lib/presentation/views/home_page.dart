import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodel/poliza_viewmodel.dart';
import 'perfil_page.dart';
import 'registro_page.dart';
import 'lista_page.dart';
import '../../themes/esquema_color.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<Widget> _pages = [
    const PerfilPage(),
    const RegistroPage(),
    const ListaPage(),
  ];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        final vm = Provider.of<PolizaViewModel>(context, listen: false);
        vm.loadPolizas();
        vm.loadAgente();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final vm = Provider.of<PolizaViewModel>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Gestión de Seguros"),
      ),
      body: _pages[vm.currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: vm.currentIndex,
        onTap: vm.changeTab,
        selectedItemColor: ColorSchemeApp.darkPink,
        unselectedItemColor: ColorSchemeApp.softGray,
        backgroundColor: ColorSchemeApp.white,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Perfil"),
          BottomNavigationBarItem(icon: Icon(Icons.add_box), label: "Registrar"),
          BottomNavigationBarItem(icon: Icon(Icons.list_alt), label: "Ver Registros"),
        ],
      ),
    );
  }
}