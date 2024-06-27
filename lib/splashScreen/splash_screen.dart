import 'dart:async';
import 'package:flutter/material.dart';
import '../screens/loginscreen/login_screen.dart';
import '../utils/colors/colors.dart'; // Ensure this import path is correct

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigateToLoginScreen();
  }

  // Navigate to the login screen after a delay
  void _navigateToLoginScreen() {
    Timer(
      const Duration(seconds: 2),
          () {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => LoginScreen(),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [AppColors.paletteYellow2, AppColors.paletteCyan2],
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Text(
              'Sourcefully',
              style: TextStyle(
                color: Colors.white,
                fontSize: 50,
                fontFamily: 'PlaywriteNO', // Ensure the custom font is used here
              ),
            ),
          ],
        ),
      ),
    );
  }
}
