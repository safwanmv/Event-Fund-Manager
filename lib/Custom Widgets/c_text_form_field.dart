import 'package:flutter/material.dart';

class CTextFromField extends StatefulWidget {
  final TextEditingController? controller;
  final String? title;
  final TextInputType? keyboardType;
  final bool obscureText;
  final Widget? suffixIcon;

  const CTextFromField({
    super.key,
    required this.controller,
    required this.title,
    this.keyboardType,
    this.obscureText = false,
    this.suffixIcon,
  });

  @override
  State<CTextFromField> createState() => _CTextFromFieldState();
}

class _CTextFromFieldState extends State<CTextFromField> {
  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme;
    return TextFormField(
      
      style: TextStyle(
        color: color.onSurface,
        fontSize: 23,
        fontWeight: FontWeight.w400,
      ),
      keyboardType: widget.keyboardType ?? TextInputType.text,
      obscureText: widget.obscureText,
      decoration: InputDecoration(
        border: OutlineInputBorder(borderSide: BorderSide.none),
        filled: true,
        fillColor: color.onSurfaceVariant,
        suffixIcon: widget.suffixIcon,
        hintText: widget.title,
        hintStyle: TextStyle(color: color.onSurface, fontSize: 18),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(24),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(18),
          borderSide: BorderSide.none,
        ),
        contentPadding: EdgeInsets.symmetric(horizontal: 6, vertical: 10),
      ),
    );
  }
}
