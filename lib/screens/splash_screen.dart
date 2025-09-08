import 'package:expense_tracker/screens/Authentication/Login/login_screen.dart';
import 'package:expense_tracker/screens/Authentication/SignUp/signup_screen.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: SafeArea(
          child: Text(
            " CashFlow ",
            style: TextStyle(
              fontSize: 40,
              fontWeight: FontWeight.bold,
              fontFamily: "Montserrat",
              color: Theme.of(context).primaryColor,
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
    await Future.delayed(Duration(seconds: 3));
    Navigator.of(
      context,
    ).pushReplacement(MaterialPageRoute(builder: (ctx) => SignupScreen()));
  }
}
