import 'package:expense_tracker/CustomWidgets/c_text_form_field.dart';
// import 'package:expense_tracker/screens/Main%20Screen/Home/home_screen.dart';
import 'package:expense_tracker/screens/Authentication/SignUp/signup_screen.dart';
import 'package:expense_tracker/screens/Main%20Screen/main_screen.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();

  final _passwordController = TextEditingController();

  bool _isVisible = true;

  @override
  Widget build(BuildContext context) {
      final color=Theme.of(context).colorScheme;

    return SafeArea(
      child: Scaffold(
        body: Form(
          child: Padding(
            padding:  EdgeInsets.all(8.r),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CTextFromField(
                  controller: _emailController,
                  title: "Enter your Email address",
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if(value==null || value.isEmpty){
                      return "Enter your Email Address";
                    }
                    return null;
                  } ,
                ),
                SizedBox(height: 15.h),
                CTextFromField(
                  controller: _passwordController,
                  title: "Enter your Password",
                  obscureText: _isVisible,
                  suffixIcon: IconButton(
                    onPressed: () {
                      setState(() {
                        _isVisible = !_isVisible;
                      });
                    },
                    icon: Icon(
                      _isVisible ? Icons.visibility_off : Icons.visibility,size: 20.r,
                    ),
                  ),
                  validator: (value) {
                    if(value==null || value.isEmpty){
                      return "Enter your Password";
                    }
                    return null;
                  } ,
                ),
                SizedBox(height: 15.h),
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(
                      context,
                    ).pushReplacement(MaterialPageRoute(builder: (ctx) => MainScreen()));
                  },
                  style: ButtonStyle(
                    backgroundColor: WidgetStatePropertyAll(
                      color.primary,
                    ),
                    foregroundColor: WidgetStatePropertyAll(Colors.black),
                    shape: WidgetStatePropertyAll(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadiusGeometry.circular(24.r),
                      ),
                    ),
                    padding: WidgetStatePropertyAll(
                      EdgeInsets.symmetric(vertical: 16.h, horizontal: 54.w),
                    ),
                  ),
                  child: Text("Login",style: TextStyle(color: color.surface,fontSize:16.sp ),),
                ),
                SizedBox(height: 18.h),
                RichText(
                  text: TextSpan(
                    text: "Don't have an Account ?",
                    style: TextStyle(fontWeight: FontWeight.w400, fontSize: 16.sp,color: color.onSurface),
                    children: [
                      TextSpan(
                        text: " SignUp",
                        style: TextStyle(
                          color:color.onSurface,
                          fontWeight: FontWeight.bold,
                          fontSize: 16.sp,
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                builder: (ctx) => SignupScreen(),
                              ),
                            );
                          },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
