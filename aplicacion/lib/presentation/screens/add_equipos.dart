import 'package:flutter/material.dart';
import 'package:genshin/models/equipo.dart';
import 'package:genshin/models/personaje.dart';
import 'package:genshin/services/api_service.dart';
import 'package:genshin/login.dart';

class AddEquipo extends StatefulWidget {
  final Map<String, dynamic>? equipo;

  const AddEquipo({super.key, this.equipo});

  @override
  _AddEquipoState createState() => _AddEquipoState();
}

class _AddEquipoState extends State<AddEquipo> {
  final _formKey = GlobalKey<FormState>();
  final _nombreController = TextEditingController();
  final List<int?> _integrantes = List.filled(4, null); // Lista de 4 integrantes
  final ApiService apiService = ApiService();
  late Future<List<Personaje>> futurePersonajes;
  late String token;

  @override
  void initState() {
    super.initState();
    futurePersonajes = Future.value([]); // Inicializa con un valor predeterminado
    _authenticateAndFetchPersonajes();
    if (widget.equipo != null) {
      _nombreController.text = widget.equipo!['nombre_equipo'] ?? '';
      List<dynamic> integrantes = [
        widget.equipo!['ID_integrante_1'],
        widget.equipo!['ID_integrante_2'],
        widget.equipo!['ID_integrante_3'],
        widget.equipo!['ID_integrante_4']
      ];
      for (int i = 0; i < 4; i++) {
        if (i < integrantes.length) {
          _integrantes[i] = integrantes[i];
        }
      }
    }
  }

  Future<void> _authenticateAndFetchPersonajes() async {
    try {
      token = await login('test', 'test');
      setState(() {
        futurePersonajes = apiService.fetchPersonajes(token);
      });
    } catch (e) {
      setState(() {
        futurePersonajes = Future.error('Error: $e');
      });
    }
  }

  @override
  void dispose() {
    _nombreController.dispose();
    super.dispose();
  }

  Future<void> _saveEquipo() async {
    if (_formKey.currentState!.validate()) {
      // Verifica que todos los integrantes no sean nulos
      if (_integrantes.contains(null)) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Por favor selecciona todos los integrantes')),
        );
        return;
      }

      final equipo = Equipo(
        id: widget.equipo != null ? widget.equipo!['ID'] ?? 0 : 0, // El ID será asignado por la base de datos si es nuevo
        nombre: _nombreController.text,
        integrantes: _integrantes.cast<int>(),
        promedioAtaque: 0, // Este valor será calculado en el servidor
      );

      try {
        if (widget.equipo == null) {
          await apiService.addEquipo(token, equipo);
        } else {
          await apiService.updateEquipo(token, equipo);
        }
        if (mounted) {
          Navigator.pop(context, 'Equipo guardado exitosamente');
        }
      } catch (e) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Error al guardar equipo: $e')),
          );
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.equipo == null ? 'Agregar Equipo' : 'Editar Equipo'),
        backgroundColor: const Color(0xFFEDD9B7),
        titleTextStyle: const TextStyle(color: Colors.black, fontSize: 20),
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: FutureBuilder<List<Personaje>>(
            future: futurePersonajes,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return const Center(child: Text('No hay personajes disponibles'));
              } else {
                final personajes = snapshot.data!;
                return ListView(
                  children: [
                    TextFormField(
                      controller: _nombreController,
                      decoration: const InputDecoration(
                        labelText: 'Nombre del Equipo',
                        labelStyle: TextStyle(color: Colors.white),
                      ),
                      style: const TextStyle(color: Colors.white),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Por favor ingresa un nombre';
                        }
                        return null;
                      },
                    ),
                    for (int i = 0; i < 4; i++)
                      DropdownButtonFormField<int>(
                        value: _integrantes[i],
                        decoration: InputDecoration(
                          labelText: 'Integrante ${i + 1}',
                          labelStyle: const TextStyle(color: Colors.white),
                        ),
                        items: personajes
                            .where((p) => !_integrantes.contains(p.id) || p.id == _integrantes[i])
                            .map((personaje) {
                          return DropdownMenuItem<int>(
                            value: personaje.id,
                            child: Text(personaje.nombre, style: const TextStyle(color: Colors.white)),
                          );
                        }).toList(),
                        onChanged: (value) {
                          setState(() {
                            _integrantes[i] = value;
                          });
                        },
                        style: const TextStyle(color: Colors.white),
                        dropdownColor: Colors.black,
                        validator: (value) {
                          if (value == null) {
                            return 'Por favor selecciona un integrante';
                          }
                          return null;
                        },
                      ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: _saveEquipo,
                      child: const Text('Guardar'),
                    ),
                  ],
                );
              }
            },
          ),
        ),
      ),
    );
  }
}