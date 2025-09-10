
import 'package:expense_tracker/screens/Landing%20Screen/landing_screen.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    final color=Theme.of(context).colorScheme;
    return Scaffold(
      backgroundColor:color.surface,
      body: Center(
        child: SafeArea(
          child: Text(
            " CashFlow ",
            style: TextStyle(
              fontSize: 40,
              fontWeight: FontWeight.bold,
              fontFamily: "Montserrat",
              color: color.primary
            ),
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    checkUserLogin();
    super.initState();
  }

  Future<void> checkUserLogin() async {
    goToLogin();
  }

  Future<void> goToLogin() async {
    final navigator =  Navigator.of(
      context,
    );
    await Future.delayed(Duration(seconds: 3));
   navigator.pushReplacement(MaterialPageRoute(builder: (ctx) => LandingScreen()));
  }
}
