import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:store/firebase_options.dart';
import 'package:store/routes.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:store/screens/home/home_screen.dart';
import 'package:store/screens/welcome/welcome_screen.dart';

import 'components/loading.dart';
import 'k.dart';

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
      initialRoute: '/',
      onGenerateRoute: AppRoutes.generateRoute,
      home: const AuthWrapper(),
    );
  }
}

class AuthWrapper extends StatelessWidget {
  const AuthWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(
              child: LoadingAnimation(),
            ),
          );
        } else if (snapshot.hasData) {
          // Check if the user still exists in Firebase Authentication
          FirebaseAuth.instance.currentUser?.reload().then((_) async {
            // Reload returns a Future<void>, so we need to await it
            final currentUser = FirebaseAuth.instance.currentUser;
            if (currentUser == null) {
              // If the user doesn't exist, sign them out
              await FirebaseAuth.instance.signOut();
            }
          });

          return const HomeScreen();
        } else {
          return const WelcomeScreen();
        }
      },
    );
  }
}
