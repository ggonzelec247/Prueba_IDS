import 'package:flutter/material.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 150,
              width: double.infinity,
              child: Image.asset(
                'assets/images/mapas/genshin.png',
                fit: BoxFit.cover,
              )
            ),
            const SizedBox(height: 16), // Espaciado entre el Placeholder y el texto
            const Text(
              'Genshin Impact (chino: 原神, Yuán Shén; japonés: 原神, Genshin), es un juego de rol de acción gratuito desarrollado por miHoYo Co., Ltd. Fuera de China, el editor es la filial de miHoYo, Cognosphere Pte., Ltd. d/b/a HoYoverse.\n\n'
              'El juego presenta un entorno de mundo abierto de fantasía y un sistema de combate basado en acción que utiliza magia elemental, cambio de personaje y sistema de monetización de gacha para que los jugadores obtengan nuevos personajes, armas y otros recursos. El juego solo se puede jugar con una conexión a Internet y cuenta con un modo multijugador limitado que permite hasta cuatro jugadores en un mundo.\n\n'
              'El juego se lanzó en todo el mundo el 28 de septiembre de 2020 para PC, iOS / Android y PlayStation 4. El 11 de noviembre de 2020 se lanzó una versión de PlayStation 5, que cuenta con soporte de guardado cruzado con PlayStation 4. Se lanzó una segunda versión para PC en Epic Games Store el 9 de junio de 2021. El juego también se lanzará en Nintendo Switch.',
              style: TextStyle(fontSize: 16, color: Colors.white),
              textAlign: TextAlign.justify,
            ),
          ],
        ),
      ),
    );
  }
}
