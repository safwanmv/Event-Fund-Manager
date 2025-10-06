import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomTableCell extends StatelessWidget {
  final String text;
  final bool isHeader;
  final TextAlign textAlign;

  const CustomTableCell({
    super.key,
    required this.text,
    this.isHeader = false,
    this.textAlign = TextAlign.left,
  });

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme;

    return Padding(
      padding: const EdgeInsets.all(8),
      child: Text(
        text,
        textAlign: textAlign,
        style: TextStyle(
          fontWeight: isHeader ? FontWeight.bold : FontWeight.normal,
          fontSize: isHeader ? 16.sp : 14.sp,
          color: color.primary,
        ),
        overflow: TextOverflow.ellipsis,
      ),
    );
  }
}
