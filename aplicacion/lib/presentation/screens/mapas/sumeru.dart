import 'package:flutter/material.dart';

class Sumeru extends StatefulWidget {
  const Sumeru({super.key});

  @override
  State<Sumeru> createState() => _SumeruState();
}

class _SumeruState extends State<Sumeru> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sumeru'),
        backgroundColor: const Color(0xFFEDD9B7),
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/mapas/fondo_sumeru.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  'Cuento:\n\n'
                  'Desde tiempos antiguos, Sumeru ha sido un lugar mágico, lleno de sabiduría, donde el conocimiento crece entre hermosos bosques y altas montañas.\n\n'
                  'Al principio, Sumeru era un refugio de paz, donde sabios y estudiantes se reunían para compartir sus ideas y aprender juntos. Pero, con el tiempo, las ambiciones comenzaron a surgir. La Academia de Sumeru, un lugar especial para el conocimiento, se convirtió en un campo de discusiones, y algunos olvidaron que la verdadera sabiduría viene de ser amables y de conectar con los demás.\n\n'
                  'He visto a mi pueblo sufrir, atrapado entre querer avanzar y cuidar sus raíces...\n\n'
                  'He visto a mi pueblo sufrir, atrapado entre querer avanzar y cuidar sus raíces. Aprender no debe ser un viaje solitario; cada descubrimiento debe ayudar a todos. \n\n'
                  'En mi camino, he aprendido que la verdadera sabiduría no solo está en los libros, sino en el corazón de cada persona. Espero que, a pesar de los desafíos, Sumeru siga siendo un lugar donde la sabiduría florezca, un hogar para quienes buscan no solo conocer, sino también comprender y amar.\n\n',
                  style: const TextStyle(fontSize: 18, color: Colors.black),
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