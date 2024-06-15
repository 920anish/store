import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:store/firebase_options.dart';
import 'package:store/routes.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:store/screens/home/home_screen.dart';
import 'package:store/screens/welcome/welcome_screen.dart';
import 'package:provider/provider.dart';
import 'components/loading.dart';
import 'k.dart';
import 'theme_provider.dart';

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
    return ChangeNotifierProvider(
      create: (_) => ThemeProvider(),
      child: Consumer<ThemeProvider>(
        builder: (context, themeProvider, child) {
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
              colorSchemeSeed: Colors.blue,
            ),
            themeMode: themeProvider.themeMode,
            initialRoute: '/',
            onGenerateRoute: AppRoutes.generateRoute,
            home: const AuthWrapper(),
          );
        },
      ),
    );
  }
}

class AuthWrapper extends StatefulWidget {
  const AuthWrapper({super.key});

  @override
  State<AuthWrapper> createState() => _AuthWrapperState();
}

class _AuthWrapperState extends State<AuthWrapper> {
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
          final user = snapshot.data!;
          FirebaseAuth.instance.currentUser?.reload().then((_) async {
            final currentUser = FirebaseAuth.instance.currentUser;
            if (currentUser == null) {
              await FirebaseAuth.instance.signOut();
              return const WelcomeScreen();
            }
          });

          if (!user.emailVerified) {
            return const WelcomeScreen();
          }
          return const HomeScreen();
        } else {
          return const WelcomeScreen();
        }
      },
    );
  }
}
