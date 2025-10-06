import 'package:expense_tracker/constants/text_messages.dart';
import 'package:expense_tracker/db/Particpents_db/participents_db.dart';
import 'package:expense_tracker/db/transaction_db/transaction_db.dart';
import 'package:expense_tracker/models/categroy/category_model.dart';
import 'package:expense_tracker/models/transaction/transaction%20_model.dart';
import 'package:expense_tracker/widgets/Empty_data/text_message_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';

class TransactionList extends StatelessWidget {
  final CategoryType? type;
  final String? eventId;
  const TransactionList({super.key, this.type, this.eventId});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<List<TransactionsModel>>(
      valueListenable: TransactionDb.instance.transactionListNotifer,
      builder: (BuildContext ctx, List<TransactionsModel> newList, Widget? _) {
        var filteredAdminTransactions = newList;

        if (type != null) {
          filteredAdminTransactions = filteredAdminTransactions
              .where((i) => i.type == type)
              .toList();
        }

        if (eventId != null) {
          filteredAdminTransactions = filteredAdminTransactions
              .where((i) => i.eventId.trim() == eventId!.trim())
              .toList();
        }

        if (filteredAdminTransactions.isEmpty) {
          return EmptyDataContainer(text: TextMessages.noTransaction);
        }

        return ListView.separated(
          itemCount: filteredAdminTransactions.length,
          separatorBuilder: (context, index) => SizedBox(height: 6.h),
          itemBuilder: (context, index) {
            final value = filteredAdminTransactions[index];
            return TransactionTile(value: value);
          },
        );
      },
    );
  }
}

/// Separate widget for each transaction item
class TransactionTile extends StatelessWidget {
  final TransactionsModel value;
  const TransactionTile({super.key, required this.value});

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme;
    String participantName = ParticipantDb.instance.getParticipantName(
      value.participantId,
    );

    return Slidable(
      startActionPane: ActionPane(
        motion: const BehindMotion(),
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
          borderRadius: BorderRadius.circular(26.r),
        ),
        child: ListTile(
          title: Text(participantName, style: TextStyle(fontSize: 16.sp)),
          leading: CircleAvatar(child: Text(participantName[0].toUpperCase())),
          subtitle: Text(
            DateFormat('dd MMM yyyy').format(value.date),
            style: TextStyle(color: color.primary, fontSize: 16.sp),
          ),
          trailing: Text(
            "${value.type == CategoryType.expense ? '-' : '+'} ₹${value.amount}",
            style: TextStyle(
              color: value.type == CategoryType.expense
                  ? Colors.red
                  : Colors.green,
              fontSize: 15.sp,
            ),
          ),
        ),
      ),
    );
  }
}
