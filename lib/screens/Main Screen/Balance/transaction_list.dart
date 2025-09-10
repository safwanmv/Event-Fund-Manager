import 'package:flutter/material.dart';

class TransactionList extends StatelessWidget {
  const TransactionList({super.key});

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme;

    return ListView.separated(
      // shrinkWrap: true,
      itemBuilder: (context, index) {
        return Card(
          
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(26),
          ),
          child: ListTile(
            title: Text("Food"),
            leading: CircleAvatar(),
            subtitle: Text(
              '22-03-2025',
              style: TextStyle(color: color.primary),
            ),
            trailing: Text("₹4500", style: TextStyle(color: color.primary)),
          ),
        );
      },
      separatorBuilder: (context, index) {
        return SizedBox(height: 6);
      },
      itemCount: 10,
    );
  }
}
