class Poliza {
  final int? id;
  final String? codigo;
  final String cliente;
  final String tipoSeguro;
  final DateTime fechaInicio;
  final DateTime fechaVencimiento;
  final double valorAsegurado;

  Poliza({
    this.id,
    this.codigo,
    required this.cliente,
    required this.tipoSeguro,
    required this.fechaInicio,
    required this.fechaVencimiento,
    required this.valorAsegurado,
  });

  factory Poliza.fromJson(Map<String, dynamic> json) {
    return Poliza(
      id: json['id'],
      codigo: json['codigo'],
      cliente: json['cliente'],
      tipoSeguro: json['tipo_seguro'],
      fechaInicio: DateTime.parse(json['fecha_inicio']),
      fechaVencimiento: DateTime.parse(json['fecha_vencimiento']),
      // Asegurarse de parsear bien num a double
      valorAsegurado: (json['valor_asegurado'] as num).toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {
      'cliente': cliente,
      'tipo_seguro': tipoSeguro,
      'fecha_inicio': fechaInicio.toIso8601String().split('T')[0],
      'fecha_vencimiento': fechaVencimiento.toIso8601String().split('T')[0],
      'valor_asegurado': valorAsegurado,
    };
    if (codigo != null) {
      data['codigo'] = codigo;
    }
    // Opcionalmente podemos enviar un código genérico si es necesario, 
    // pero el backend exige un 'codigo', así que lo generaremos si es null.
    if (codigo == null) {
      data['codigo'] = 'POL-GEN-${DateTime.now().millisecondsSinceEpoch.toString().substring(8)}';
    }
    return data;
  }
}
