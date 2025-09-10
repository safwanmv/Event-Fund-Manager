import 'package:expense_tracker/screens/Main%20Screen/Balance/transaction_list.dart';
import 'package:flutter/material.dart';

class AnalyticsScreen extends StatelessWidget {
  const AnalyticsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final color=Theme.of(context).colorScheme;
    return Padding(
      padding: const EdgeInsets.only(top: 20.0,left: 20,right: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Montly Expenses',style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500),),
          Text("Total Expense of this Month",style: TextStyle(color: color.primary),),
          SizedBox(height: 430,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Recent Sales",style: TextStyle(fontSize: 25,fontWeight: FontWeight.w500,color:color.primary ),),
              Text("See All")
            ],
          ),
          Expanded(child: TransactionList())
        ],
      ),
    );
  }
}
