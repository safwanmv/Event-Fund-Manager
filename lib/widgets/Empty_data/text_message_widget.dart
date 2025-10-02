import 'package:flutter/widgets.dart';

class EmptyDataContainer extends StatelessWidget {
  final String text;
  const EmptyDataContainer({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: const EdgeInsets.all(16),
        child: Text(
          text,
          style: TextStyle(fontSize: 16, color: Color(0xFF777777)),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
