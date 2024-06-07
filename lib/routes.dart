import 'package:flutter/material.dart';
import 'package:store/screens/login/login.dart';
import 'package:store/screens/register/register.dart';
import 'package:store/screens/welcome/welcome_screen.dart';
import 'package:store/screens/home/home_screen.dart';

class AppRoutes {
  static const String welcome = '/';
  static const String home = '/home';
  static const String login = '/login';
  static const String register = '/register';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case welcome:
        return CustomPageRoute(builder: (_) => const WelcomeScreen());
      case home:
        return CustomPageRoute(builder: (_) => const HomeScreen());
      case login:
        return CustomPageRoute(builder: (_) => const LoginScreen());
      case register:
        return CustomPageRoute(builder: (_) => const RegisterScreen());
      default:
        return CustomPageRoute(builder: (_) => const WelcomeScreen());
    }
  }
}

class CustomPageRoute<T> extends MaterialPageRoute<T> {
  CustomPageRoute({required super.builder});

  @override
  Widget buildTransitions(
      BuildContext context,
      Animation<double> animation,
      Animation<double> secondaryAnimation,
      Widget child,
      ) {
    return child;
  }
}
