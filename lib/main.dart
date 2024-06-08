import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:store/k.dart';
import 'firebase_options.dart';
import 'routes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Store',
      theme: ThemeData(
        fontFamily: 'Poppins',
        colorScheme: ColorScheme.fromSeed(seedColor: kPrimaryLightColor),
        useMaterial3: true,
        brightness: Brightness.light,
      ),
      darkTheme: ThemeData(
        fontFamily: 'Poppins',
        useMaterial3: true,
        brightness: Brightness.dark,
        colorSchemeSeed: Colors.grey,
      ),
      themeMode: ThemeMode.system,
      initialRoute: AppRoutes.welcome,
      onGenerateRoute: AppRoutes.generateRoute,
    );
  }
}
