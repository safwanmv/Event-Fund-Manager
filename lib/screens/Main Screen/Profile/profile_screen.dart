import 'package:expense_tracker/main.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SafeArea(
        child: Column(
          children: [
            ValueListenableBuilder(
              valueListenable: isDark,
              builder: (context, value, child) {
                return IconButton.filledTonal(
                  icon: Icon(isDark.value ? Icons.dark_mode : Icons.light_mode),
                  onPressed: () => isDark.value = !isDark.value,
                );
              },
            ),

          ],
        ),
      ),
    );
  }
}
