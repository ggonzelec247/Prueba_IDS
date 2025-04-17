
import 'package:genshin/presentation/screens/main_screen.dart';
import 'package:go_router/go_router.dart';

final appRouter = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      name: 'MainScreen',
      builder: (context, state) => const MainScreen(),
    ),
  ],
);