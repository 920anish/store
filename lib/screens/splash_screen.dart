import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
    @override
    _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
    @override
    void initState() {
        super.initState();

        Future.delayed(Duration(seconds: 2), () {
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => NextScreen()),
            );
        });
    }

    @override
    Widget build(BuildContext context) {
        return Scaffold(
            body: Center(
                child: Text(
                    'Test Splash Screen ',
                    style: TextStyle(fontSize: 24),
                ),
            ),
        );
    }
}

class NextScreen extends StatelessWidget {
    @override
    Widget build(BuildContext context) {
        return Scaffold(
            body: Center(
                child: Text(
                    'Home Page',
                    style: TextStyle(fontSize: 24),
                ),
            ),
        );
    }
}