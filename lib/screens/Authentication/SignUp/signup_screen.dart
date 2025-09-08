import 'package:expense_tracker/Custom%20Widgets/CTextFormField.dart';
import 'package:expense_tracker/screens/Home/home_screen.dart';
import 'package:expense_tracker/screens/Authentication/Login/login_screen.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class SignupScreen extends StatefulWidget {
  SignupScreen({super.key});

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Form(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,

                children: [
                  CTextFromField(
                    controller: _nameController,
                    title: "Name",
                    keyboardType: TextInputType.name,
                  ),
                  SizedBox(height: 10),
                  CTextFromField(
                    controller: _emailController,
                    title: "email",
                    keyboardType: TextInputType.emailAddress,
                  ),
                  SizedBox(height: 10),
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
                        _isVisible ? Icons.visibility_off : Icons.visibility,
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
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
                        _isVisibleConfirm
                            ? Icons.visibility_off
                            : Icons.visibility,
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: WidgetStatePropertyAll(
                        Theme.of(context).primaryColor,
                      ),
                      foregroundColor: WidgetStatePropertyAll(Colors.black),
                      elevation: WidgetStatePropertyAll(3),
                      shape: WidgetStatePropertyAll(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadiusGeometry.circular(5),
                        ),
                      ),
                      padding: WidgetStatePropertyAll(
                        EdgeInsets.symmetric(vertical: 16.0, horizontal: 54.0),
                      ),
                    ),
                    onPressed: () {
                      Navigator.of(
                        context,
                      ).push(MaterialPageRoute(builder: (ctx) => HomeScreen()));
                    },
                    child: Text("SignUp"),
                  ),
                  SizedBox(height: 10),
                  RichText(
                    text: TextSpan(
                      text: ("Already have an Account ?"),
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w300,
                      ),
                      children: [
                        TextSpan(
                          text: " Login",
                          style: TextStyle(
                            color: Theme.of(context).primaryColor,
                            fontWeight: FontWeight.bold,
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
    );
  }
}
