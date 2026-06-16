import '../entities/poliza.dart';
import '../entities/agente.dart';

abstract class PolizaRepository {
  Future<List<Poliza>> getPolizas();
  Future<Poliza> getPoliza(int id);
  Future<Poliza> createPoliza(Poliza poliza);
  Future<Poliza> updatePoliza(int id, Poliza poliza);
  Future<void> deletePoliza(int id);
  Future<Agente> getAgente();
}

class CrudPolizasUsecase {
  final PolizaRepository repository;

  CrudPolizasUsecase({required this.repository});

  Future<List<Poliza>> getPolizas() {
    return repository.getPolizas();
  }

  Future<Poliza> getPoliza(int id) {
    return repository.getPoliza(id);
  }

  Future<Poliza> createPoliza(Poliza poliza) {
    return repository.createPoliza(poliza);
  }

  Future<Poliza> updatePoliza(int id, Poliza poliza) {
    return repository.updatePoliza(id, poliza);
  }

  Future<void> deletePoliza(int id) {
    return repository.deletePoliza(id);
  }

  Future<Agente> getAgente() {
    return repository.getAgente();
  }
}
