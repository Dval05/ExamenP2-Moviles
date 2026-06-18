import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../domain/entities/poliza.dart';
import '../../domain/entities/agente.dart';

class PolizaApiDatasource {
  // Ajusta la URL según el dispositivo donde pruebas:
  // - Emulador Android: 'http://10.0.2.2:8000'
  // - Flutter Web o Simulador iOS: 'http://localhost:8000' o 'http://127.0.0.1:8000'
  final String baseUrl = 'http://10.40.56.236:8000';

  Future<List<Poliza>> getPolizas({String? query}) async {
    final url = query != null && query.isNotEmpty
        ? '$baseUrl/polizas?cliente=$query'
        : '$baseUrl/polizas';
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final List data = json.decode(utf8.decode(response.bodyBytes));
      return data.map((e) => Poliza.fromJson(e)).toList();
    } else {
      throw Exception('Error al cargar pólizas: ${response.statusCode}');
    }
  }

  Future<Poliza> getPoliza(int id) async {
    final response = await http.get(Uri.parse('$baseUrl/polizas/$id'));
    if (response.statusCode == 200) {
      return Poliza.fromJson(json.decode(utf8.decode(response.bodyBytes)));
    } else {
      throw Exception('Error al cargar póliza');
    }
  }

  Future<Poliza> createPoliza(Poliza poliza) async {
    final response = await http.post(
      Uri.parse('$baseUrl/polizas'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(poliza.toJson()),
    );
    if (response.statusCode == 201 || response.statusCode == 200) {
      return Poliza.fromJson(json.decode(utf8.decode(response.bodyBytes)));
    } else {
      throw Exception('Error al crear póliza: ${response.body}');
    }
  }

  Future<Poliza> updatePoliza(int id, Poliza poliza) async {
    final response = await http.put(
      Uri.parse('$baseUrl/polizas/$id'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(poliza.toJson()),
    );
    if (response.statusCode == 200) {
      return Poliza.fromJson(json.decode(utf8.decode(response.bodyBytes)));
    } else {
      throw Exception('Error al actualizar póliza');
    }
  }

  Future<void> deletePoliza(int id) async {
    final response = await http.delete(Uri.parse('$baseUrl/polizas/$id'));
    if (response.statusCode != 200) {
      throw Exception('Error al eliminar póliza');
    }
  }

  Future<Agente> getAgente() async {
    final response = await http.get(Uri.parse('$baseUrl/agente'));
    if (response.statusCode == 200) {
      return Agente.fromJson(json.decode(utf8.decode(response.bodyBytes)));
    } else {
      throw Exception('Error al cargar perfil del agente');
    }
  }
}
