import 'package:flutter/material.dart';
import 'package:genshin/presentation/view/home_view.dart';
import 'package:genshin/presentation/view/mapa_view.dart';
import 'package:genshin/presentation/view/personajes_view.dart';
import 'package:genshin/presentation/view/equipos_view.dart';
import 'package:genshin/presentation/view/nosotros_view.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    final screens = [
      const HomeView(),
      const PersonajesView(),
      const EquiposView(),
      const MapaInteractivoView(),
      const NosotrosView()
    ];

    final bottomNavItems = [
      _buildBottomNavItem('home.png', colors),
      _buildBottomNavItem('personajes.png', colors),
      _buildBottomNavItem('equipos.png', colors),
      _buildBottomNavItem('mapa.png', colors),
      _buildBottomNavItem('nosotros.png', colors),
    ];

    return Scaffold(
      body: IndexedStack(
        index: selectedIndex,
        children: screens,
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.shifting,
        currentIndex: selectedIndex,
        onTap: (value) {
          setState(() {
            selectedIndex = value;
          });
        },
        elevation: 2,
        items: bottomNavItems,
      ),
    );
  }

  BottomNavigationBarItem _buildBottomNavItem(String assetName, ColorScheme colors) {
    return BottomNavigationBarItem(
      icon: ImageIcon(
        AssetImage('assets/images/mapas/$assetName'),
      ),
      activeIcon: ImageIcon(
        AssetImage('assets/images/mapas/$assetName'),
      ),
      label: '',
      backgroundColor: colors.secondary,
    );
  }
}