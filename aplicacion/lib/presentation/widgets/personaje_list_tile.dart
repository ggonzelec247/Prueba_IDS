import 'package:flutter/material.dart';
import 'package:genshin/models/personaje.dart';

class PersonajeListTile extends StatelessWidget {
  final Personaje personaje;
  final VoidCallback onLongPress;

  const PersonajeListTile({
    Key? key,
    required this.personaje,
    required this.onLongPress,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        personaje.nombre,
        style: const TextStyle(color: Colors.white),
      ),
      subtitle: Text(
        'Edad: ${personaje.edad}, Región: ${personaje.region}, Elemento: ${personaje.elemento}, Ataque: ${personaje.ataque}',
        style: const TextStyle(color: Colors.white),
      ),
      onLongPress: onLongPress,
    );
  }
}