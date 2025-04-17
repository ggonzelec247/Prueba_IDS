class Equipo {
  final int id;
  final String nombre;
  final List<int> integrantes;
  final int promedioAtaque;

  Equipo({
    required this.id,
    required this.nombre,
    required this.integrantes,
    required this.promedioAtaque,
  });

  factory Equipo.fromJson(Map<String, dynamic> json) {
    return Equipo(
      id: json['ID'] ?? 0,
      nombre: json['nombre_equipo'] ?? 'Nombre no disponible',
      integrantes: [
        json['ID_integrante_1'] ?? 0,
        json['ID_integrante_2'] ?? 0,
        json['ID_integrante_3'] ?? 0,
        json['ID_integrante_4'] ?? 0,
      ],
      promedioAtaque: json['promedio_ataque'] ?? 0,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'ID': id,
      'nombre_equipo': nombre,
      'ID_integrante_1': integrantes[0],
      'ID_integrante_2': integrantes[1],
      'ID_integrante_3': integrantes[2],
      'ID_integrante_4': integrantes[3],
      'promedio_ataque': promedioAtaque,
    };
  }
}