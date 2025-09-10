import 'package:expense_tracker/main.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SafeArea(
        child: ValueListenableBuilder(
          valueListenable: isDark,
          builder: (context, value, child) {
            return Switch(
              value: isDark.value,
              onChanged: (newvalue) {
                isDark.value = newvalue;
              },
            );
          },
        ),
      ),
    );
  }
}
