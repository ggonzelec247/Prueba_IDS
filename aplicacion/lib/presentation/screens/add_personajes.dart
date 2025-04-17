import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:genshin/models/personaje.dart';
import 'package:genshin/services/api_service.dart';
import 'package:genshin/login.dart';

class AddPersonajes extends StatefulWidget {
  final Map<String, String>? personaje;

  const AddPersonajes({super.key, this.personaje});

  @override
  _AddPersonajesState createState() => _AddPersonajesState();
}

class _AddPersonajesState extends State<AddPersonajes> {
  final _formKey = GlobalKey<FormState>();
  final _nombreController = TextEditingController();
  final _edadController = TextEditingController();
  final _ataqueController = TextEditingController();
  final ApiService apiService = ApiService();

  String? _selectedRegion;
  String? _selectedElement;

  final List<String> _regions = ['Mondstadt', 'Liyue', 'Inazuma', 'Sumeru', 'Fontaine', 'Natlan'];
  final List<String> _elements = ['Anemo', 'Pyro', 'Hydro', 'Dendro', 'Electro', 'Cryo'];

  @override
  void initState() {
    super.initState();
    if (widget.personaje != null) {
      _nombreController.text = widget.personaje!['nombre']!;
      _edadController.text = widget.personaje!['edad']!;
      _selectedRegion = widget.personaje!['region'];
      _selectedElement = widget.personaje!['elemento'];
      _ataqueController.text = widget.personaje!['ataque']!;
    }
  }

  @override
  void dispose() {
    _nombreController.dispose();
    _edadController.dispose();
    _ataqueController.dispose();
    super.dispose();
  }

  Future<void> _savePersonaje() async {
    if (_formKey.currentState!.validate()) {
      final personaje = Personaje(
        id: 0, // El ID será asignado por la base de datos
        nombre: _nombreController.text,
        edad: int.parse(_edadController.text),
        region: _selectedRegion!,
        elemento: _selectedElement!,
        ataque: int.parse(_ataqueController.text),
      );
      try {
        final token = await login('test', 'test'); // Asegúrate de obtener el token de autenticación
        await apiService.addPersonaje(token, personaje);
        Navigator.pop(context, 'Personaje agregado exitosamente');
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error al agregar personaje: $e')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.personaje == null ? 'Agregar Personaje' : 'Editar Personaje'),
        backgroundColor: const Color(0xFFEDD9B7),
        titleTextStyle: const TextStyle(color: Colors.black, fontSize: 20),
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              // Nombre
              TextFormField(
                controller: _nombreController,
                decoration: const InputDecoration(
                  labelText: 'Nombre',
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
              // Edad
              TextFormField(
                controller: _edadController,
                decoration: const InputDecoration(
                  labelText: 'Edad',
                  labelStyle: TextStyle(color: Colors.white),
                ),
                keyboardType: TextInputType.number,
                style: const TextStyle(color: Colors.white),
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.digitsOnly
                ],
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingresa una edad';
                  }
                  return null;
                },
              ),
              // Región
              DropdownButtonFormField<String>(
                value: _selectedRegion,
                decoration: const InputDecoration(
                  labelText: 'Región',
                  labelStyle: TextStyle(color: Colors.white),
                ),
                items: _regions.map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value, style: const TextStyle(color: Colors.white)),
                  );
                }).toList(),
                onChanged: (newValue) {
                  setState(() {
                    _selectedRegion = newValue;
                  });
                },
                style: const TextStyle(color: Colors.white),
                dropdownColor: Colors.black,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor selecciona una región';
                  }
                  return null;
                },
              ),
              // Elemento
              DropdownButtonFormField<String>(
                value: _selectedElement,
                decoration: const InputDecoration(
                  labelText: 'Elemento',
                  labelStyle: TextStyle(color: Colors.white),
                ),
                items: _elements.map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value, style: const TextStyle(color: Colors.white)),
                  );
                }).toList(),
                onChanged: (newValue) {
                  setState(() {
                    _selectedElement = newValue;
                  });
                },
                style: const TextStyle(color: Colors.white),
                dropdownColor: Colors.black,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor selecciona un elemento';
                  }
                  return null;
                },
              ),
              // Ataque
              TextFormField(
                controller: _ataqueController,
                decoration: const InputDecoration(
                  labelText: 'Ataque',
                  labelStyle: TextStyle(color: Colors.white),
                ),
                keyboardType: TextInputType.number,
                style: const TextStyle(color: Colors.white),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingresa un valor de ataque';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _savePersonaje,
                child: const Text('Guardar'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}