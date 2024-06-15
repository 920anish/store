import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:store/routes.dart';

class SettingPage extends StatelessWidget {
  const SettingPage({super.key});

  Future<void> _signOut(BuildContext context) async {
    await FirebaseAuth.instance.signOut();
    if (context.mounted) {
      Navigator.pushReplacementNamed(context, AppRoutes.welcome); // Navigate to the login screen
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: ListView(
        children: [
          ListTile(
            title: const Text('Sign Out'),
            leading: const Icon(Icons.logout),
            onTap: () => _signOut(context),
          ),
        ],
      ),
    );
  }
}
