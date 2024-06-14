import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:store/routes.dart';
import 'package:store/components/navigation_bar.dart';
import 'package:store/screens/home/favourite_page.dart';
import 'package:store/screens/home/setting_page.dart';
import 'package:store/screens/home/wishlist_page.dart';
import 'package:store/screens/home/home_page.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    const HomePage(),
    const FavouritePage(),
    const WishlistPage(),
    const SettingPage(),
  ];

  @override
  Widget build(BuildContext context) {
    final User? user = FirebaseAuth.instance.currentUser;

    if (user == null) {
      // If there's no user, navigate back to the login screen
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Navigator.pushReplacementNamed(context, AppRoutes.login);
      });
      return Container();
    }

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 0,
      ),
      body: _pages[_currentIndex],
      bottomNavigationBar: CurvedNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }
}