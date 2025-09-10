import 'package:expense_tracker/screens/Authentication/Login/login_screen.dart';
import 'package:flutter/material.dart';

class LandingScreen extends StatelessWidget {
  const LandingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: color.surface,
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.symmetric(vertical: 60),
            child: Image.asset("assets/images/image.png", fit: BoxFit.contain),
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.all(20),
              width: double.infinity,
              decoration: BoxDecoration(
                color: color.primary,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30), // 👈 curve top-left
                  topRight: Radius.circular(30), // 👈 curve top-right
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    children: [
                      Text(
                        "All-in-One\nExpense Tracker",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                          color: color.onPrimary
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        "Track cash, online payments,\nand bank transfers in one place.",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: color.onPrimary
                        ),
                      ),
                    ],
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => LoginScreen()),
                      );
                    },
                    child: Container(
                      width: 180,
                      height: 40,
                      decoration: BoxDecoration(
                        color: color.surface,
                        borderRadius: BorderRadius.circular(25),
                      ),
                      child: Center(child: Text("Get Started",style: TextStyle(fontWeight: FontWeight.bold),)),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
