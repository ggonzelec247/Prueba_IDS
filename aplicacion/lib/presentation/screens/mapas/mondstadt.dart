import 'package:flutter/material.dart';

class Mondstadt extends StatefulWidget {
  const Mondstadt({super.key});

  @override
  State<Mondstadt> createState() => _MondstadtState();
}

class _MondstadtState extends State<Mondstadt> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mondstadt'),
        backgroundColor: const Color(0xFFEDD9B7),
      ),
      body: Center(
        child: Column(
          children: [
            Text(
              'En Monstadt, donde el viento danza,'
              'las risas flotan, la vida avanza.'
              'Cielos de azul profundo, un pueblo feliz,'
              'cada latido es un suave matiz.\n\n'

              'En el campo, dientes de león brillan,'
              'como estrellas doradas que sueños destilan.'
              'Símbolos ardientes de fuerza y fe,'
              'un canto a la vida, su esencia es ley.\n\n'
              
              'Viñedos dorados abrazan el sol,'
              'frutos que desafían al frío y al rol.'
              'El vino rebosante, risas en festín,'
              'celebra el esfuerzo que nunca tuvo fin.\n\n'

              'Oh, Monstadt, susurro de libertad,'
              'mi corazón vuela, sintiendo la verdad.'
              'Tu historia se alza, un viento en mi piel,'
              'y en cada rincón, tu eco es mi laurel.',
              style: TextStyle(fontSize: 16, color: Colors.white)
              ),
          ],
          
        ),
      ),
      

    );
  }
}