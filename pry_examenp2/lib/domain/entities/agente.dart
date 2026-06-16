class Agente {
  final int id;
  final String nombre;
  final String email;
  final String cargo;
  final String sucursal;
  final int totalPolizasVendidas;

  Agente({
    required this.id,
    required this.nombre,
    required this.email,
    required this.cargo,
    required this.sucursal,
    required this.totalPolizasVendidas,
  });

  factory Agente.fromJson(Map<String, dynamic> json) {
    return Agente(
      id: json['id'],
      nombre: json['nombre'],
      email: json['email'],
      cargo: json['cargo'],
      sucursal: json['sucursal'],
      totalPolizasVendidas: json['total_polizas_vendidas'] ?? 0,
    );
  }
}
