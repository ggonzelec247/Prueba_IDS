import 'package:flutter/material.dart';


class Natlan extends StatefulWidget {
  const Natlan({super.key});

  @override
  State<Natlan> createState() => _NatlanState();
}
class _NatlanState extends State<Natlan> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Natlan'),
        backgroundColor: const Color(0xFFEDD9B7),
      ),
      body: Stack(
        children: [
          // Imagen de fondo
          Positioned.fill(
            child: Image.asset(
              'assets/images/mapas/fondo_natlan.jpg', // Ruta de la imagen de fondo
              fit: BoxFit.cover, // Ajuste de la imagen
            ),
          ),
          // Cuadro con el texto
          Center(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Container(
                decoration: BoxDecoration(
                  color: const Color(0xFFEDD9B7), // Color de fondo del contenedor
                  borderRadius: BorderRadius.circular(10), // Bordes redondeados
                  border: Border.all(
                    color: Colors.black, // Color del borde
                    width: 2, // Grosor del borde
                  ),
                ),
                padding: const EdgeInsets.all(20.0), // Espacio interno del contenedor
                child: const Text(
                  '¡Próximamente!\n\n'
                  'Estamos trabajando en este contenido.',
                  style: TextStyle(
                    fontSize: 18,
                    fontFamily: 'Cursive', // Tipografía cursiva
                    color: Colors.black, // Color de la letra
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
