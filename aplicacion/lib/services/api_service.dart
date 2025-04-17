import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/personaje.dart';
import '../models/equipo.dart';

class ApiService {
  final String baseUrl = 'https://kryss.pythonanywhere.com/api';

  // Funciones para personajes
  Future<List<Personaje>> fetchPersonajes(String token) async {
    final response = await http.get(
      Uri.parse('$baseUrl/personajes'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      List<dynamic> body = jsonDecode(response.body);
      List<Personaje> personajes = body.map((dynamic item) => Personaje.fromJson(item)).toList();
      return personajes;
    } else {
      throw Exception('Failed to load personajes');
    }
  }

  Future<void> addPersonaje(String token, Personaje personaje) async {
    final response = await http.post(
      Uri.parse('$baseUrl/personajes'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode(personaje.toMap()),
    );

    if (response.statusCode != 201) {
      throw Exception('Failed to add personaje');
    }
  }

  Future<void> updatePersonaje(String token, Personaje personaje) async {
    final response = await http.put(
      Uri.parse('$baseUrl/personajes/${personaje.id}'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode(personaje.toMap()),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to update personaje');
    }
  }

  Future<void> deletePersonaje(String token, int id) async {
    final response = await http.delete(
      Uri.parse('$baseUrl/personajes/$id'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to delete personaje');
    }
  }

  // Funciones para equipos
  Future<List<Equipo>> fetchEquipos(String token) async {
    final response = await http.get(
      Uri.parse('$baseUrl/equipos'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      List<dynamic> body = jsonDecode(response.body);
      List<Equipo> equipos = body.map((dynamic item) => Equipo.fromJson(item)).toList();
      return equipos;
    } else {
      throw Exception('Failed to load equipos');
    }
  }

  Future<void> addEquipo(String token, Equipo equipo) async {
    final response = await http.post(
      Uri.parse('$baseUrl/equipos'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode(equipo.toMap()),
    );

    if (response.statusCode != 201) {
      throw Exception('Failed to add equipo');
    }
  }

  Future<void> updateEquipo(String token, Equipo equipo) async {
    final response = await http.put(
      Uri.parse('$baseUrl/equipos/${equipo.id}'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode(equipo.toMap()),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to update equipo');
    }
  }

  Future<void> deleteEquipo(String token, int id) async {
    final response = await http.delete(
      Uri.parse('$baseUrl/equipos/$id'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to delete equipo');
    }
  }
}