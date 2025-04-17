import 'package:flutter/material.dart';
import 'package:genshin/models/personaje.dart';
import 'package:genshin/presentation/screens/add_personajes.dart';
import 'package:genshin/services/api_service.dart';
import 'package:genshin/login.dart';
import 'package:genshin/presentation/widgets/personaje_list_tile.dart';

class PersonajesView extends StatefulWidget {
  const PersonajesView({super.key});

  @override
  State<PersonajesView> createState() => _PersonajesViewState();
}

class _PersonajesViewState extends State<PersonajesView> {
  late Future<List<Personaje>> futurePersonajes;
  final ApiService apiService = ApiService();
  late String token;

  @override
  void initState() {
    super.initState();
    futurePersonajes = Future.value([]); // Inicializa con un valor predeterminado
    _authenticateAndFetchData();
  }

  Future<void> _authenticateAndFetchData() async {
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

  Future<void> _refreshData() async {
    try {
      final newToken = await login('test', 'test');
      final newPersonajes = await apiService.fetchPersonajes(newToken);
      setState(() {
        token = newToken;
        futurePersonajes = Future.value(newPersonajes);
      });
    } catch (e) {
      setState(() {
        futurePersonajes = Future.error('Error: $e');
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Personajes'),
        backgroundColor: const Color(0xFFEDD9B7),
        actions: [
          IconButton(
            onPressed: _refreshData,
            icon: const Icon(Icons.refresh),
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: _refreshData,
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
              return ListView.builder(
                itemCount: personajes.length,
                itemBuilder: (context, index) {
                  final personaje = personajes[index];
                  return PersonajeListTile(
                    personaje: personaje,
                    onLongPress: () => _showOptions(context, index, personajes),
                  );
                },
              );
            }
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final result = await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const AddPersonajes()),
          );
          if (result != null && result is String) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(result)),
            );
            _refreshData();
          }
        },
        child: const Icon(Icons.add),
        backgroundColor: const Color(0xFFEDD9B7),
      ),
    );
  }

  void _showOptions(BuildContext context, int index, List<Personaje> personajes) {
    // Implementa las opciones que deseas mostrar al hacer una pulsación larga
  }
}