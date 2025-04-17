import 'package:flutter/material.dart';
import 'package:genshin/models/equipo.dart';
import 'package:genshin/presentation/screens/add_equipos.dart';
import 'package:genshin/services/api_service.dart';
import 'package:genshin/login.dart';
import 'package:genshin/presentation/widgets/equipo_list_tile.dart'; // Importa el nuevo widget

class EquiposView extends StatefulWidget {
  const EquiposView({super.key});

  @override
  State<EquiposView> createState() => _EquiposViewState();
}

class _EquiposViewState extends State<EquiposView> {
  late Future<List<Equipo>> futureEquipos;
  final ApiService apiService = ApiService();
  late String token;

  @override
  void initState() {
    super.initState();
    futureEquipos = Future.value([]); // Inicializa con un valor predeterminado
    _authenticateAndFetchData();
  }

  Future<void> _authenticateAndFetchData() async {
    try {
      token = await login('test', 'test');
      setState(() {
        futureEquipos = apiService.fetchEquipos(token);
      });
    } catch (e) {
      setState(() {
        futureEquipos = Future.error('Error: $e');
      });
    }
  }

  void _showOptions(BuildContext context, int index, List<Equipo> equipos) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Wrap(
          children: [
            ListTile(
              leading: const Icon(Icons.edit),
              title: const Text('Modificar'),
              onTap: () async {
                final result = await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AddEquipo(
                      equipo: equipos[index].toMap(),
                    ),
                  ),
                );
                if (result != null && result is String) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(result)),
                  );
                  setState(() {
                    futureEquipos = apiService.fetchEquipos(token);
                  });
                }
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.delete),
              title: const Text('Eliminar'),
              onTap: () async {
                try {
                  await apiService.deleteEquipo(token, equipos[index].id);
                  setState(() {
                    equipos.removeAt(index);
                  });
                  Navigator.pop(context);
                } catch (e) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Error al eliminar equipo: $e')),
                  );
                }
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Equipos'),
        backgroundColor: const Color(0xFFEDD9B7),
      ),
      body: FutureBuilder<List<Equipo>>(
        future: futureEquipos,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No hay equipos disponibles'));
          } else {
            final equipos = snapshot.data!;
            return ListView.builder(
              itemCount: equipos.length,
              itemBuilder: (context, index) {
                final equipo = equipos[index];
                return EquipoListTile(
                  equipo: equipo,
                  onLongPress: () => _showOptions(context, index, equipos),
                );
              },
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final result = await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const AddEquipo()),
          );
          if (result != null && result is String) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(result)),
            );
            setState(() {
              futureEquipos = apiService.fetchEquipos(token);
            });
          }
        },
        child: const Icon(Icons.add),
        backgroundColor: const Color(0xFFEDD9B7),
      ),
    );
  }
}