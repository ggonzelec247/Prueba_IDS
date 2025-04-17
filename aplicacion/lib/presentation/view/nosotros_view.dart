import 'package:flutter/material.dart';

class NosotrosView extends StatefulWidget {
  const NosotrosView({super.key});

  @override
  State<NosotrosView> createState() => _NosotrosViewState();
}

class _NosotrosViewState extends State<NosotrosView> {
  final List<Map<String, String>> integrantes = [
    {"apellido": "Gonzales", "nombre": "Gabriel Leonel", "padron": "112607"},
    {"apellido": "Noriega Nuti", "nombre": "Sofia Belen", "padron": "110502"},
    {"apellido": "Rojas Calizaya", "nombre": "Kevin Edgardo", "padron": "109948"},
    {"apellido": "Julian Gilio", "nombre": "Agustin Nahuel", "padron": "111876"},
    {"apellido": "Siciliano", "nombre": "Franco", "padron": "108157"},
    {"apellido": "Lopez", "nombre": "Lazaro", "padron": "111312"},
    {"apellido": "Moyano", "nombre": "Benjamin", "padron": "111613"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Nosotros'),
        backgroundColor: const Color(0xFFEDD9B7),
      ),
      body: Center(
        child: ListView.builder(
          itemCount: integrantes.length,
          itemBuilder: (context, index) {
            final integrante = integrantes[index];
            return ListTile(
              title: Text('${integrante["nombre"]} ${integrante["apellido"]}', style: TextStyle(fontSize: 16, color: Colors.white),textAlign: TextAlign.center), 
              subtitle: Text('Padrón: ${integrante["padron"]}',style: TextStyle(fontSize: 16, color: Colors.white),textAlign: TextAlign.center),
            );
          },
        ),
      ),
    );
  }
}