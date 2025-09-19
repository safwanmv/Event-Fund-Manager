import 'package:expense_tracker/CustomWidgets/c_text_form_field.dart';
import 'package:expense_tracker/db/Users_db/users_db.dart';
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
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    UserDb.instance.userListNotifier;
  }

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme;

    return SafeArea(
      child: Scaffold(
        body: Form(
          key: formKey,
          child: Padding(
            padding: EdgeInsets.all(8.r),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CTextFromField(
                  controller: _emailController,
                  title: "Enter your Email address",
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Enter your Email Address";
                    }
                    return null;
                  },
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
                      _isVisible ? Icons.visibility_off : Icons.visibility,
                      size: 20.r,
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Enter your Password";
                    }

                    return null;
                  },
                ),
                SizedBox(height: 15.h),
                ElevatedButton(
                  onPressed: () {
                    login();
                  },
                  style: ButtonStyle(
                    backgroundColor: WidgetStatePropertyAll(color.primary),
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
                  child: Text(
                    "Login",
                    style: TextStyle(color: color.surface, fontSize: 16.sp),
                  ),
                ),
                SizedBox(height: 18.h),
                RichText(
                  text: TextSpan(
                    text: "Don't have an Account ?",
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 16.sp,
                      color: color.onSurface,
                    ),
                    children: [
                      TextSpan(
                        text: " SignUp",
                        style: TextStyle(
                          color: color.onSurface,
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

  Future<void> login() async {
    if (formKey.currentState!.validate()) {
      String email = _emailController.text.trim();
      String password = _passwordController.text.trim();
      final user = UserDb.instance.getUserByEmail(email);
      if (!mounted) return;
      if (user == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("No account found with this Email")),
        );
        return;
      }
      if (user.password != password) {
        await UserDb.instance.refreshUI();
        if (!mounted) return;
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text("Incorrect Password")));
        return;
      }

      Navigator.of(
        context,
      ).pushReplacement(MaterialPageRoute(builder: (ctx) => MainScreen()));
    }
  }
}
