import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:store/screens/login/login_form.dart';
import 'package:store/routes.dart';
import '../../components/custom_button.dart';
import 'package:store/auth/auth.dart';
import '../../components/overlay.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _isLoading = false;

  void _navigateToScreen(String routeName) {
    if (mounted) {
      Navigator.pushReplacementNamed(context, routeName);
    }
  }

  void _showSnackBar(String message) {
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(message)),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return LoadingOverlay(
      isLoading: _isLoading,
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  const SizedBox(height: 40),
                  const Text(
                    'Welcome Back',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'Login to get inside',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 40),
                  LoginForm(
                    onLoadingStateChanged: (isLoading) {
                      setState(() {
                        _isLoading = isLoading;
                      });
                    },
                  ),
                  const SizedBox(height: 20),
                  const Row(
                    children: <Widget>[
                      Expanded(child: Divider()),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        child: Text('or continue with'),
                      ),
                      Expanded(child: Divider()),
                    ],
                  ),
                  const SizedBox(height: 20),
                  CustomButton(
                    text: 'Google',
                    icon: SvgPicture.asset(
                      'assets/google.svg',
                      width: 24,
                      height: 24,
                    ),
                    color: Colors.black45,
                    onPressed: _isLoading
                        ? null
                        : () async {
                      setState(() {
                        _isLoading = true;
                      });
                      User? user = await AuthService().signUpWithGoogle();
                      if (user != null) {
                        _navigateToScreen(AppRoutes.home);
                      } else {
                        _showSnackBar('Failed to sign in with Google. Please try again later.');
                        setState(() {
                          _isLoading = false;
                        });
                      }
                    },
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      const Text('Don\'t have an account?'),
                      TextButton(
                        onPressed: () {
                          _navigateToScreen(AppRoutes.register);
                        },
                        child: const Text('Register'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
