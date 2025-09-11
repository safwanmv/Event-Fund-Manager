import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class TransactionList extends StatelessWidget {
  const TransactionList({super.key});

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme;

    return ListView.separated(
      // shrinkWrap: true,
      itemBuilder: (context, index) {
        return Slidable(
          startActionPane: ActionPane(
            motion: BehindMotion(),
            children: [
              SlidableAction(
                backgroundColor: color.surface,
                onPressed: (ctx) {},
                icon: Icons.delete,
                label: "Delete",
              ),
            ],
          ),
          child: Card(
            elevation: 2,
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
