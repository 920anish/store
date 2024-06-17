import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../theme_provider.dart';

class SettingPage extends StatelessWidget {
  const SettingPage({super.key});

  Future<void> _signOut(BuildContext context) async {
    await FirebaseAuth.instance.signOut();
    if (context.mounted) {
      Navigator.pushNamedAndRemoveUntil(
        context,
        '/',
            (Route<dynamic> route) => false,
      );
    }
  }

  void _showThemeBottomSheet(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context, listen: false);

    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          padding: const EdgeInsets.all(20.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ListTile(
                  title: const Text('Light'),
                  onTap: () {
                    themeProvider.setTheme(ThemeMode.light);
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  title: const Text('Dark'),
                  onTap: () {
                    themeProvider.setTheme(ThemeMode.dark);
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  title: const Text('System Default'),
                  onTap: () {
                    themeProvider.setTheme(ThemeMode.system);
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final User? user = FirebaseAuth.instance.currentUser;
    Provider.of<ThemeProvider>(context);
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 40, // Adjusted size
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
            _buildOptionTile(
              context: context,
              icon: const IconData(0xeb7d, fontFamily: 'Icons'),
              title: 'Account',
              onTap: () {
                // Navigate to account settings page
              },
            ),
            _buildOptionTile(
              context: context,
              icon: const IconData(0xe945, fontFamily: 'Icons'),
              title: 'Dark Mode',
              onTap: () => _showThemeBottomSheet(context),
            ),
            _buildOptionTile(
              context: context,
              icon: const IconData(0xeb55, fontFamily: 'Icons'),
              title: 'Notification',
              onTap: () {
                // Navigate to notification settings page
              },
            ),
            _buildOptionTile(
              context: context,
              icon: const IconData(0xeae8, fontFamily: 'Icons'),
              title: 'Logout',
              onTap: () => _signOut(context),
            ),
          ],
        ),
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
            child: ConstrainedBox(
              constraints: const BoxConstraints(
                maxWidth: double.infinity,
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    child: Row(
                      children: [
                        Icon(icon, color: isDarkMode ? Colors.white : Theme.of(context).iconTheme.color),
                        const SizedBox(width: 20),
                        Flexible(
                          child: Text(
                            title,
                            style: isDarkMode
                                ? Theme.of(context).textTheme.bodyLarge?.copyWith(color: Colors.white)
                                : Theme.of(context).textTheme.bodyLarge,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                          ),
                        ),
                      ],
                    ),
                  ),
                  if (trailing != null) trailing,
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
