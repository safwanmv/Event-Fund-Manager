import 'package:expense_tracker/screens/Landing%20Screen/landing_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  static const splashDuration = Duration(seconds: 3);
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      checkUserLogin();
    });
  }

  Future<void> checkUserLogin() async {
    await goToLogin();
  }

  Future<void> goToLogin() async {
    await Future.delayed(splashDuration);
    if (!mounted) return;

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (ctx) => const LandingScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme;
    return Scaffold(
      backgroundColor: color.surface,
      body: Center(
        child: SafeArea(
          child: Text(
            " CashFlow ",
            style: TextStyle(
              fontSize: 40.sp.clamp(28, 50),
              fontWeight: FontWeight.bold,
              fontFamily: "Montserrat",
              color: color.primary,
            ),
          ),
        ),
      ),
    );
  }
}
