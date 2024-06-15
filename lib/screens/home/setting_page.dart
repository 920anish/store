import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../routes.dart';
import '../../theme_provider.dart';

class SettingPage extends StatelessWidget {
  const SettingPage({super.key});

  Future<void> _signOut(BuildContext context) async {
    await FirebaseAuth.instance.signOut();
    if (context.mounted) {
      Navigator.pushReplacementNamed(context, AppRoutes.welcome);
    }
  }

  @override
  Widget build(BuildContext context) {
    final User? user = FirebaseAuth.instance.currentUser;
    final themeProvider = Provider.of<ThemeProvider>(context);
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 0,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: 50,
                  backgroundImage: NetworkImage(
                    user?.photoURL ?? 'https://avatar.iran.liara.run/public',
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  user?.displayName ?? 'user',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView(

              children: [
                _buildOptionTile(
                  context: context,
                  icon: Icons.account_circle,
                  title: 'Account',
                  onTap: () {
                    // Navigate to account settings page
                  },
                ),
                _buildOptionTile(
                  context: context,
                  icon: Icons.brightness_6,
                  title: 'Dark Mode',
                  trailing: DropdownButton<ThemeMode>(
                    value: themeProvider.themeMode,
                    onChanged: (ThemeMode? newTheme) {
                      if (newTheme != null) {
                        themeProvider.setTheme(newTheme);
                      }
                    },
                    items: const [
                      DropdownMenuItem(
                        value: ThemeMode.light,
                        child: Text('Light'),
                      ),
                      DropdownMenuItem(
                        value: ThemeMode.dark,
                        child: Text('Dark'),
                      ),
                      DropdownMenuItem(
                        value: ThemeMode.system,
                        child: Text('System Default'),
                      ),
                    ],
                  ),
                ),
                _buildOptionTile(
                  context: context,
                  icon: Icons.notifications,
                  title: 'Notification',
                  onTap: () {
                    // Navigate to notification settings page
                  },
                ),
                _buildOptionTile(
                  context: context,
                  icon: Icons.logout,
                  title: 'Logout',
                  onTap: () => _signOut(context),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOptionTile({
    required BuildContext context,
    required IconData icon,
    required String title,
    VoidCallback? onTap,
    Widget? trailing,
  }) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
      decoration: BoxDecoration(
        color: isDarkMode ? Colors.white10 : Colors.white,
        borderRadius: BorderRadius.circular(20.0),
        boxShadow: [
          BoxShadow(
            color: isDarkMode ? Colors.black.withOpacity(0.3) : Colors.grey.withOpacity(0.5),
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(3, 3),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(20.0),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 25.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(icon, color: isDarkMode ? Colors.white : Theme.of(context).iconTheme.color),
                    const SizedBox(width: 20),
                    Text(
                      title,
                      style: isDarkMode
                          ? Theme.of(context).textTheme.bodyLarge?.copyWith(color: Colors.white)
                          : Theme.of(context).textTheme.bodyLarge,
                    ),
                  ],
                ),
                if (trailing != null) trailing,
              ],
            ),
          ),
        ),
      ),
    );
  }
}