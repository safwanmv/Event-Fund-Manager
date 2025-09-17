import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
class CTextFromField extends StatefulWidget {
  final TextEditingController controller;
  final String? title;
  final TextInputType? keyboardType;
  final bool obscureText;
  final Widget? suffixIcon;
  final String? Function(String?)? validator;

  const CTextFromField({
    super.key,
    required this.controller,
    required this.title,
    this.keyboardType,
    this.obscureText = false,
    this.suffixIcon,
    required this.validator,
  });

  @override
  State<CTextFromField> createState() => _CTextFromFieldState();
}

class _CTextFromFieldState extends State<CTextFromField> {
  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme;
    return TextFormField(
     controller:widget.controller,
      style: TextStyle(
        color: color.onSurface,
        fontSize: 23.sp,
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
        hintStyle: TextStyle(color: color.onSurface, fontSize: 18.sp),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(24.r),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(18.r),
          borderSide: BorderSide.none,
        ),
        contentPadding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
      ),
      validator:widget.validator,
    );
  }
}
