// import 'package:expense_tracker/db/transaction_db/transaction_db.dart';
// import 'package:expense_tracker/models/categroy/category_model.dart';
// import 'package:expense_tracker/models/transaction/transaction%20_model.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_slidable/flutter_slidable.dart';
// import 'package:intl/intl.dart';

// class TransactionList extends StatelessWidget {
//   final CategoryType? type;
//   const TransactionList({super.key, this.type});

//   @override
//   Widget build(BuildContext context) {
//     final color = Theme.of(context).colorScheme;

//     return ValueListenableBuilder(
//       valueListenable: TransactionDb.instance.transactionListNotifer,
//       builder: (BuildContext ctx, List<TransactionsModel> newList, Widget? _) {
//         final filteredList = type == null
//             ? newList
//             : newList.where((i) => i.type == type).toList();

//         return ListView.separated(
//           shrinkWrap: true,          physics:
//               const NeverScrollableScrollPhysics(), 
//           itemBuilder: (context, index) {
//             final value = filteredList[index];
//             return Slidable(
//               startActionPane: ActionPane(
//                 motion: BehindMotion(),
//                 children: [
//                   SlidableAction(
//                     backgroundColor: color.surface,
//                     onPressed: (ctx) {
//                       TransactionDb.instance.deleteTransaction(value.id);
//                     },
//                     icon: Icons.delete,
//                     label: "Delete",
//                   ),
//                 ],
//               ),
//               child: Card(
//                 elevation: 2,
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(26),
//                 ),
//                 child: ListTile(
//                   title: Text(value.name),
//                   leading: CircleAvatar(),
//                   subtitle: Text(
//                     '${formattedDate(value.date)}',
//                     style: TextStyle(color: color.primary),
//                   ),
//                   trailing: Text(
//                     "${value.type == CategoryType.expense ? '-' : '+'} ₹${value.amount}",
//                     style: TextStyle(
//                       color: value.type == CategoryType.expense
//                           ? Colors.red
//                           : Colors.green,
//                       fontSize: 15,
//                     ),
//                   ),
//                 ),
//               ),
//             );
//           },
//           separatorBuilder: (context, index) {
//             return SizedBox(height: 6);
//           },
//           itemCount: filteredList.length,
//         );
//       },
//     );
//   }

//   String formattedDate(DateTime date) {
//     return DateFormat('dd MMM yyyy').format(date);
//   }
// }


import 'package:expense_tracker/db/transaction_db/transaction_db.dart';
import 'package:expense_tracker/models/categroy/category_model.dart';
import 'package:expense_tracker/models/transaction/transaction%20_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';

class TransactionList extends StatelessWidget {
  final CategoryType? type;
  const TransactionList({super.key, this.type});

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme;

    return ValueListenableBuilder(
      valueListenable: TransactionDb.instance.transactionListNotifer,
      builder: (BuildContext ctx, List<TransactionsModel> newList, Widget? _) {
        final filteredList = type == null
            ? newList
            : newList.where((i) => i.type == type).toList();

        return ListView.separated(
          // shrinkWrap: true,
          itemBuilder: (context, index) {
            final value=filteredList[index];
            return Slidable(
              startActionPane: ActionPane(
                motion: BehindMotion(),
                children: [
                  SlidableAction(
                    backgroundColor: color.surface,
                    onPressed: (ctx) {
                      TransactionDb.instance.deleteTransaction(value.id);
                    },
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
                  title: Text(value.name),
                  leading: CircleAvatar(),
                  subtitle: Text(
                    '${formattedDate(value.date)}',
                    style: TextStyle(color: color.primary),
                  ),
                  trailing: Text(
                    "${value.type == CategoryType.expense ? '-' : '+'} ₹${value.amount}",
                    style: TextStyle(
                      color: value.type == CategoryType.expense
                          ? Colors.red
                          : Colors.green,
                      fontSize: 15,
                    ),
                  ),
                ),
              ),
            );
          },
          separatorBuilder: (context, index) {
            return SizedBox(height: 6);
          },
          itemCount: filteredList.length,
        );
      },
    );
  }

  String formattedDate(DateTime date) {
    return DateFormat('dd MMM yyyy').format(date);
  }
}