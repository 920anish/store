import 'package:flutter/material.dart';
import 'package:store/screens/login/login.dart';
import 'package:store/screens/register/register.dart';
import 'package:store/screens/welcome/welcome_screen.dart';
import 'package:store/screens/home/home_screen.dart';
import 'package:store/transition.dart';

class AppRoutes {
  static const String welcome = '/';
  static const String home = '/home';
  static const String login = '/login';
  static const String register = '/register';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case welcome:
        return FadeRoute(page: const WelcomeScreen(), duration: const Duration(milliseconds: 200));
      case home:
        return FadeRoute(page: const HomeScreen(), duration: const Duration(milliseconds: 200));
      case login:
        return FadeRoute(page: const LoginScreen(), duration: const Duration(milliseconds: 200));
      case register:
        return FadeRoute(page: const RegisterScreen(), duration: const Duration(milliseconds: 200));
      default:
        return FadeRoute(page: const WelcomeScreen(), duration: const Duration(milliseconds: 200));
    }
  }
}
