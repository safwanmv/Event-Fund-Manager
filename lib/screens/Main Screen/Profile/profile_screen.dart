import 'package:expense_tracker/db/Users_db/users_db.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: UserDb.instance.activeUserNotifier,
      builder: (context, activeUser, _) {
        if (activeUser == null) {
          return const Center(child: CircularProgressIndicator());
        }

        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                // Profile Avatar
                CircleAvatar(
                  radius: 50,
                  backgroundColor: Colors.blueAccent,
                  child: Text(
                    activeUser.name.isNotEmpty
                        ? activeUser.name[0].toUpperCase()
                        : '?',
                    style: const TextStyle(
                      fontSize: 40,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 20),

                // User Info Card
                Card(
                  elevation: 3,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 16, horizontal: 20),
                    child: Column(
                      children: [
                        _infoField("Name", activeUser.name),
                        const SizedBox(height: 12),
                        _infoField("Email", activeUser.email),
                        const SizedBox(height: 12),
                        // Example editable field
                        // TextFormField(
                          
                        //   initialValue: activeUser.name,
                        //   decoration: const InputDecoration(
                        //     labelText: "Edit Name",
                        //     border: OutlineInputBorder(),
                        //   ),
                        // ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  // Widget for displaying info with label
  Widget _infoField(String label, String value) {
    return Row(
      children: [
        Text(
          "$label: ",
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: const TextStyle(fontSize: 16),
          ),
        ),
      ],
    );
  }
}
