import 'package:flutter/widgets.dart';

class EmptyDataContainer extends StatelessWidget {
  const EmptyDataContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: const EdgeInsets.all(16),
        child: const Text(
          "No Events Found",
          style: TextStyle(fontSize: 16, color: Color(0xFF777777)),
        ),
      ),
    );
  }
}
