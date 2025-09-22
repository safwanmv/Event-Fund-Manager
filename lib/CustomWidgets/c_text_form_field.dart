import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CTextFromField extends StatefulWidget {
  final TextEditingController controller;
  final String? title;
  final TextInputType? keyboardType;
  final bool obscureText;
  final Widget? suffixIcon;
  final String? Function(String?)? validator;
  final TextInputAction? textInputAction;
  final Function(String)? onFieldSubmitted;
  final void Function()? onTap;
  final Widget? prefixIcon;
  final int? maxLines;
  final int? minLines;
  const CTextFromField({
    super.key,
    required this.controller,
    required this.title,
    this.keyboardType,
    this.maxLines,
    this.minLines,
    this.obscureText = false,
    this.prefixIcon,
    this.suffixIcon,
    required this.validator,
    this.textInputAction = TextInputAction.none,
    this.onFieldSubmitted,
    this.onTap,
  });

  @override
  State<CTextFromField> createState() => _CTextFromFieldState();
}

class _CTextFromFieldState extends State<CTextFromField> {
  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme;
    return TextFormField(
      controller: widget.controller,
      style: TextStyle(
        color: color.onSurface,
        fontSize: 13.sp,
        fontWeight: FontWeight.w400,
      ),
      keyboardType: widget.keyboardType ?? TextInputType.text,
      maxLines: widget.maxLines,
      minLines: widget.minLines,
      obscureText: widget.obscureText,
      decoration: InputDecoration(
        border: OutlineInputBorder(borderSide: BorderSide.none),
        filled: true,
        fillColor: color.onSurfaceVariant,
        prefixIcon: widget.prefixIcon,
        prefixIconColor: color.onSurface,
        prefixStyle: TextStyle(fontSize: 16.sp),
        suffixIcon: widget.suffixIcon,
        suffixIconColor: color.onSurface,
        suffixStyle: TextStyle(fontSize: 16.sp),
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
        contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
      ),
      validator: widget.validator,
      textInputAction: widget.textInputAction,
      onFieldSubmitted: widget.onFieldSubmitted,
      onTap: widget.onTap,
    );
  }
}
