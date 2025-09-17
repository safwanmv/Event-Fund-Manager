import 'package:expense_tracker/screens/Authentication/Login/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
            padding: EdgeInsets.symmetric(vertical: 0.22.sh),
            child: Image.asset(
              "assets/images/image.png",
              fit: BoxFit.contain,
              width: 0.5.sw,
            ),
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.all(30.r),
              width: double.infinity,
              decoration: BoxDecoration(
                color: color.primary,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30.r), 
                  topRight: Radius.circular(30.r), 
                ),
              ),
              child: SingleChildScrollView(
                
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Program Funds Tracker",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 26.sp,
                        fontWeight: FontWeight.w900,
                        color: color.onPrimary,
                      ),
                    ),
                    SizedBox(height: 20.h),
                    Text(
                      "View total funds collected, expenses,\nand remaining balance for each program.",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.bold,
                        color: color.onPrimary,
                      ),
                    ),
                    SizedBox(height:56.h ,),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) => LoginScreen()),
                        );
                      },
                      child: Container(
                        width:  0.5.sw,
                        height: 50.h,
                        decoration: BoxDecoration(
                          color: color.surface,
                          borderRadius: BorderRadius.circular(25.r),
                        ),
                        child: Center(
                          child: Text(
                            "Get Started",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 15.sp,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
