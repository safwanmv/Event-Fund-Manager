import 'package:expense_tracker/db/Users_db/users_db.dart';
import 'package:expense_tracker/main.dart';
import 'package:expense_tracker/models/Users/user_model.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: UserDb.instance.userListNotifier,
      builder: (context, List<UserModel> userList, _) {
        if (userList.isEmpty) {
          return const Center(child: CircularProgressIndicator());
        }

        final userData = userList.first;

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
                        Text(userData.name),
                        Text(userData.email),
                        Text(userData.id),
                        Text(userData.password),
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
