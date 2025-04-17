import 'package:flutter/material.dart';
import 'package:genshin/presentation/screens/mapas/mondstadt.dart';
import 'package:genshin/presentation/screens/mapas/liyue.dart';
import 'package:genshin/presentation/screens/mapas/inazuma.dart';
import 'package:genshin/presentation/screens/mapas/sumeru.dart';
import 'package:genshin/presentation/screens/mapas/fontaine.dart';
import 'package:genshin/presentation/screens/mapas/natlan.dart';

class MapaInteractivoView extends StatefulWidget {
  const MapaInteractivoView({super.key});

  @override
  State<MapaInteractivoView> createState() => _MapaInteractivoViewState();
}

class _MapaInteractivoViewState extends State<MapaInteractivoView> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mapa Interactivo'),
        backgroundColor: const Color(0xFFEDD9B7),   
      ),
      body: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 1, // Una columna
          childAspectRatio: 16 / 9, // Relación de aspecto para rectángulos
        ),
        itemCount: 6,
        itemBuilder: (context, index) {
          final List<Map<String, dynamic>> mapas = [
            {'image': 'assets/images/mapas/mondstadt.jpeg', 'screen': Mondstadt(), 'name': 'Mondstadt'},
            {'image': 'assets/images/mapas/liyue.jpg', 'screen': Liyue(), 'name': 'Liyue'},
            {'image': 'assets/images/mapas/inazuma.jpg', 'screen': Inazuma(), 'name': 'Inazuma'},
            {'image': 'assets/images/mapas/sumeru.jpeg', 'screen': Sumeru(), 'name': 'Sumeru'},
            {'image': 'assets/images/mapas/fontaine.jpg', 'screen': Fontaine(), 'name': 'Fontaine'},
            {'image': 'assets/images/mapas/natlan.png', 'screen': Natlan(), 'name': 'Natlan'},
          ];

          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => mapas[index]['screen']),
              );
            },
            child: Stack(
              children: [
                Image.asset(
                  mapas[index]['image'],
                  fit: BoxFit.cover,
                  width: double.infinity,
                  height: double.infinity,
                ),
                Positioned(
                  bottom: 10,
                  left: 10,
                  child: Container(
                    color: Colors.black54,
                    padding: EdgeInsets.all(5),
                    child: Text(
                      mapas[index]['name'],
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}