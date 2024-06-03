// lib/routes.dart
import 'package:flutter/material.dart';
import 'screens/welcome/welcome_screen.dart';
import 'screens/home/home_screen.dart';

class AppRoutes {
  static const String welcome = '/';
  static const String home = '/home';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case welcome:
        return MaterialPageRoute(builder: (_) => const WelcomeScreen());
      case home:
        return MaterialPageRoute(builder: (_) => const HomeScreen());
      default:
        return MaterialPageRoute(builder: (_) => const WelcomeScreen());
    }
  }
}
