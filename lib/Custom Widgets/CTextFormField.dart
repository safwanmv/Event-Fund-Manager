import 'package:flutter/material.dart';

class CTextFromField extends StatefulWidget {
  final TextEditingController? controller;
  final String? title;
  final TextInputType? keyboardType;
  final bool obscureText;
  final Widget? suffixIcon;

  CTextFromField({
    super.key,
    required this.controller,
    required this.title,
    this.keyboardType,
    this.obscureText = false, this.suffixIcon,
  });

  @override
  State<CTextFromField> createState() => _CTextFromFieldState();
}

class _CTextFromFieldState extends State<CTextFromField> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: TextStyle(
        color: Colors.white,
        fontSize: 23,
        fontWeight: FontWeight.w400,
      ),
      keyboardType: widget.keyboardType ?? TextInputType.text,
      obscureText: widget.obscureText,
      decoration: InputDecoration(
        suffixIcon: widget.suffixIcon,
        labelText: widget.title,
        labelStyle: const TextStyle(color: Colors.white, fontSize: 18),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(6),
          borderSide: BorderSide(color: Theme.of(context).primaryColor),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(6),
          borderSide: BorderSide(color: Theme.of(context).primaryColor),
        ),
        contentPadding: EdgeInsets.symmetric(horizontal: 6, vertical: 6),
      ),
    );
  }
}
