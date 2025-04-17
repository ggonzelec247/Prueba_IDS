import 'package:flutter/material.dart';

class Liyue extends StatefulWidget {
  const Liyue({super.key});

  @override
  State<Liyue> createState() => _LiyueState();
}

class _LiyueState extends State<Liyue> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Liyue'),
        backgroundColor: const Color(0xFFEDD9B7),
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/mapas/fondo_liyue.jpg'), // Ruta de la imagen de fondo
            fit: BoxFit.cover,
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  'Contrato de Exploración en Liyue\n\n'
                  'Partes Contratantes:\n'
                  'El Viajero y la Nación de Liyue.\n\n'
                  'Objeto del Contrato:\n'
                  'Este acuerdo permite la exploración de Liyue, donde cada rincón refleja su rica historia y el valor de los contratos.\n\n'
                  'Considerando:\n'
                  'Orígenes Humildes: Liyue comenzó como un monte vacío. A través del esfuerzo conjunto, se transformó en una nación próspera y vibrante.\n\n'
                  'La Nación de los Contratos: En este lugar, el comercio trasciende el simple intercambio de bienes; cada acuerdo es un pilar fundamental de confianza y compromiso.\n\n'
                  'El Puerto Principal: Este puerto, centro neurálgico de comercio, simboliza la conexión entre personas y culturas, sustentado en la fuerza de los contratos.\n\n'
                  'Cláusulas:\n'
                  'Derecho a Explorar: El Viajero se compromete a descubrir y valorar la historia de Liyue.\n'
                  'Respeto y Aprendizaje: Cada interacción con la cultura local será un acto de respeto y reconocimiento de su sabiduría.\n'
                  'Honor y Compromiso: La exploración reafirma el valor de las promesas, esenciales para el crecimiento y la prosperidad.\n\n'
                  'Conclucion:\n'
                  'Al firmar este contrato, el Viajero acepta sumergirse en la rica tapestria de Liyue, un lugar donde la historia y el compromiso guían el camino hacia un futuro brillante.\n'
                  '\n\n\n\n',
                  style: const TextStyle(fontSize: 16),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}