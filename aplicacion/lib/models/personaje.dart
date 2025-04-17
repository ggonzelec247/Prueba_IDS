class Personaje {
  final int id;
  final String nombre;
  final int edad;
  final String region;
  final String elemento;
  final int ataque;

  Personaje({
    required this.id,
    required this.nombre,
    required this.edad,
    required this.region,
    required this.elemento,
    required this.ataque,
  });

  factory Personaje.fromJson(Map<String, dynamic> json) {
    return Personaje(
      id: json['ID'],
      nombre: json['nombre'],
      edad: json['edad'],
      region: json['region'],
      elemento: json['elemento'],
      ataque: json['ataque'],
    );
  }

  Map<String, String> toMap() {
    return {
      'ID': id.toString(),
      'nombre': nombre,
      'edad': edad.toString(),
      'region': region,
      'elemento': elemento,
      'ataque': ataque.toString(),
    };
  }
}