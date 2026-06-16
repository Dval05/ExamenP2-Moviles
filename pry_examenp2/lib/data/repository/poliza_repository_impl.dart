import '../../domain/entities/poliza.dart';
import '../../domain/entities/agente.dart';
import '../../domain/usescase/crud_polizas_usecase.dart';
import '../datasources/poliza_api_datasource.dart';

class PolizaRepositoryImpl implements PolizaRepository {
  final PolizaApiDatasource apiDatasource;

  PolizaRepositoryImpl({required this.apiDatasource});

  @override
  Future<List<Poliza>> getPolizas() {
    return apiDatasource.getPolizas();
  }

  @override
  Future<Poliza> getPoliza(int id) {
    return apiDatasource.getPoliza(id);
  }

  @override
  Future<Poliza> createPoliza(Poliza poliza) {
    return apiDatasource.createPoliza(poliza);
  }

  @override
  Future<Poliza> updatePoliza(int id, Poliza poliza) {
    return apiDatasource.updatePoliza(id, poliza);
  }

  @override
  Future<void> deletePoliza(int id) {
    return apiDatasource.deletePoliza(id);
  }

  @override
  Future<Agente> getAgente() {
    return apiDatasource.getAgente();
  }
}
