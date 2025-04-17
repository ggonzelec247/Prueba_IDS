import 'package:flutter/material.dart';
import 'package:genshin/models/equipo.dart';

class EquipoListTile extends StatelessWidget {
  final Equipo equipo;
  final VoidCallback onLongPress;

  const EquipoListTile({
    Key? key,
    required this.equipo,
    required this.onLongPress,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        equipo.nombre,
        style: const TextStyle(color: Colors.white),
      ),
      subtitle: Text(
        'Integrantes: ${equipo.integrantes.join(', ')}',
        style: const TextStyle(color: Colors.white),
      ),
      onLongPress: onLongPress,
    );
  }
}