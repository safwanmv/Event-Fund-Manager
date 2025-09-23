import 'package:expense_tracker/db/Users_db/users_db.dart';
import 'package:expense_tracker/main.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: UserDb.instance.activeUserNotifier,
      builder: (context,activeUser, _) {
        if (activeUser==null) {
          return const Center(child: CircularProgressIndicator());
        }
        return Center(
          child: SafeArea(
            child: Column(
              children: [
                ValueListenableBuilder(
                  valueListenable: isDark,
                  builder: (context, value, child) {
                    return Column(
                      children: [
                        IconButton.filledTonal(
                          icon: Icon(
                            isDark.value ? Icons.dark_mode : Icons.light_mode,
                          ),
                          onPressed: () => isDark.value = !isDark.value,
                        ),
                        Text(activeUser.name),
                        Text(activeUser.email),
                        Text(activeUser.id),
                        Text(activeUser.password),
                      ],
                    );
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
