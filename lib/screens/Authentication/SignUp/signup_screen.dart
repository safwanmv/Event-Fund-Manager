import 'package:expense_tracker/CustomWidgets/c_text_form_field.dart';
import 'package:expense_tracker/db/Users_db/users_db.dart';
import 'package:expense_tracker/screens/Authentication/Login/login_screen.dart';
import 'package:expense_tracker/screens/Main%20Screen/main_screen.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _nameController = TextEditingController();

  final _emailController = TextEditingController();

  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  bool _isVisible = true;
  bool _isVisibleConfirm = true;
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme;
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: EdgeInsets.all(8.0.r),
            child: Form(
              key: formKey,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,

                  children: [
                    CTextFromField(
                      controller: _nameController,
                      title: "Name",
                      keyboardType: TextInputType.name,
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return "Enter your name";
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 15.h),
                    CTextFromField(
                      controller: _emailController,
                      title: "email",
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return "Enter your Email";
                        }

                        final emailRegex = RegExp(
                          r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
                        );
                        if (!emailRegex.hasMatch(value)) {
                          return "Enter a valid email";
                        }

                        final existingUser = UserDb.instance.getUserByEmail(
                          value.trim(),
                        );
                        if (existingUser != null) {
                          return "Email is already taken";
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 15.h),
                    CTextFromField(
                      controller: _passwordController,
                      title: "Password",
                      obscureText: _isVisible,
                      suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            _isVisible = !_isVisible;
                          });
                        },
                        icon: Icon(
                          color: Colors.white,
                          size: 20.r,
                          _isVisible ? Icons.visibility_off : Icons.visibility,
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return "Enter your Password";
                        }
                        if (value.trim().length < 8) {
                          return "Password must be at least 8 characters long";
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 15.h),
                    CTextFromField(
                      controller: _confirmPasswordController,
                      title: "Confirm Password",
                      obscureText: _isVisibleConfirm,
                      suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            _isVisibleConfirm = !_isVisibleConfirm;
                          });
                        },
                        icon: Icon(
                          color: Colors.white,
                          size: 20.r,
                          _isVisibleConfirm
                              ? Icons.visibility_off
                              : Icons.visibility,
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return "Enter your confirm Password";
                        }
                        if (value.trim().length < 8) {
                          return "Password must be at least 8 characters long";
                        }
                        if (value.trim() !=
                            _confirmPasswordController.text.trim()) {
                          return "Password and Confirm Password do not match";
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 20.h),
                    ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: WidgetStatePropertyAll(color.primary),
                        elevation: WidgetStatePropertyAll(3.h),
                        shape: WidgetStatePropertyAll(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadiusGeometry.circular(24.r),
                          ),
                        ),
                        padding: WidgetStatePropertyAll(
                          EdgeInsets.symmetric(
                            vertical: 16.0.h,
                            horizontal: 54.0.w,
                          ),
                        ),
                      ),
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          String name = _nameController.text.trim();
                          String email = _emailController.text.trim();
                          String password = _passwordController.text.trim();

                          UserDb.instance.addDataToDB(
                            name: name,
                            email: email,
                            password: password,
                          );
                          Navigator.of(context).push(
                            MaterialPageRoute(builder: (ctx) => MainScreen()),

                          );
                        }
                      },
                      child: Text(
                        "SignUp",
                        style: TextStyle(color: color.surface, fontSize: 16.sp),
                      ),
                    ),
                    SizedBox(height: 10.h),
                    RichText(
                      text: TextSpan(
                        text: ("Already have an Account ?"),
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w300,
                          color: color.onSurface,
                        ),
                        children: [
                          TextSpan(
                            text: " Login",
                            style: TextStyle(
                              color: color.primary,
                              fontWeight: FontWeight.bold,
                              fontSize: 16.sp,
                            ),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                Navigator.of(context).pushReplacement(
                                  MaterialPageRoute(
                                    builder: (ctx) => LoginScreen(),
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
        ),
      ),
    );
  }
}
