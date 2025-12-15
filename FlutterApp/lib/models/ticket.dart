class Ticket {
  final int? id;
  final String titulo;
  final String descripcion;
  final String estado;
  final String prioridad;
  final String clienteNombre;
  final DateTime? fechaCreacion;

  Ticket({
    this.id,
    required this.titulo,
    required this.descripcion,
    required this.estado,
    required this.prioridad,
    required this.clienteNombre,
    this.fechaCreacion,
  });

  factory Ticket.fromJson(Map<String, dynamic> json) {
    return Ticket(
      id: json['id'],
      titulo: json['titulo'],
      descripcion: json['descripcion'],
      estado: json['estado'],
      prioridad: json['prioridad'],
      clienteNombre: json['clienteNombre'],
      fechaCreacion: json['fechaCreacion'] != null 
          ? DateTime.parse(json['fechaCreacion']) 
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'titulo': titulo,
      'descripcion': descripcion,
      'estado': estado,
      'prioridad': prioridad,
      'clienteNombre': clienteNombre,
      'fechaCreacion': fechaCreacion?.toIso8601String(),
    };
  }
}
