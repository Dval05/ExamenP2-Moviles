import 'package:flutter/material.dart';

class PolizaViewModel extends ChangeNotifier {
  final CrudPolizasUsecase usecase;

  PolizaViewModel(this.usecase);

  List<Poliza> polizas = [];
  bool loading = false;
  String? errorMessage;

  // Para BottomNavigationBar
  int currentIndex = 0;

  // Para manejar la edición
  Poliza? polizaEnEdicion;

  void changeTab(int index) {
    currentIndex = index;
    // Si salimos de la pestaña de registro, limpiamos el estado de edición
    if (index != 1) polizaEnEdicion = null;
    notifyListeners();
  }

  void prepararEdicion(Poliza poliza) {
    polizaEnEdicion = poliza;
    currentIndex = 1; // Mover a la pestaña de registro
    notifyListeners();
  }

  Future<void> loadPolizas() async {
    loading = true;
    notifyListeners();
    try {
      polizas = await usecase.getPolizas();
      errorMessage = null;
    } catch (e) {
      errorMessage = "Error al cargar pólizas";
    }
    loading = false;
    notifyListeners();
  }

  Future<void> createOrUpdatePoliza(Poliza poliza) async {
    loading = true;
    notifyListeners();
    try {
      if (polizaEnEdicion != null && polizaEnEdicion!.codigo != null) {
        await usecase.updatePoliza(polizaEnEdicion!.codigo!, poliza);
      } else {
        await usecase.createPoliza(poliza);
      }
      await loadPolizas();
      polizaEnEdicion = null;
      currentIndex = 2; // Ir a la lista después de guardar
    } catch (e) {
      errorMessage = "Error al guardar póliza";
    }
    loading = false;
    notifyListeners();
  }

  Future<void> deletePoliza(String codigo) async {
    loading = true;
    notifyListeners();
    try {
      await usecase.deletePoliza(codigo);
      await loadPolizas();
    } catch (e) {
      errorMessage = "Error al eliminar póliza";
    }
    loading = false;
    notifyListeners();
  }
}