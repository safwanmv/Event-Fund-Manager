import 'package:expense_tracker/screens/Main%20Screen/Balance/transaction_list.dart';
import 'package:flutter/material.dart';

class BalanceScreen extends StatelessWidget {
  const BalanceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: SafeArea(
        child: Column(
          children: [
            SizedBox(height: 230),
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [Text("Transaction") , Text("Analytics")]),
            SizedBox(height: 20,),
            Expanded(child: TransactionList()),
          ],
        ),
      ),
    );
  }
}
