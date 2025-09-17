// import 'package:expense_tracker/models/categroy/category_model.dart';
// import 'package:expense_tracker/screens/chart/pie_chart_screen.dart';
// import 'package:expense_tracker/screens/Main%20Screen/Balance/transaction_list.dart';
// import 'package:flutter/material.dart';

// class AnalyticsScreen extends StatefulWidget {
//   const AnalyticsScreen({super.key});

//   @override
//   State<AnalyticsScreen> createState() => _AnalyticsScreenState();
// }

// class _AnalyticsScreenState extends State<AnalyticsScreen> {
//   CategoryType selectedType = CategoryType.expense;
//   final ScrollController _scrollController = ScrollController();

//   // Scroll to first list item dynamically (no hardcoded 300)
//   void scrollToList() {
//     if (_scrollController.hasClients) {
//       _scrollController.animateTo(
//         _scrollController.position.maxScrollExtent * 0.1,
//         duration: const Duration(milliseconds: 500),
//         curve: Curves.easeInOut,
//       );
//     } else {
//       debugPrint("ScrollController not attached yet");
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     final color = Theme.of(context).colorScheme;

//     return Scaffold(
//       body: CustomScrollView(
//         controller: _scrollController,
//         slivers: [
//           SliverAppBar(
//             backgroundColor: color.surface,
//             pinned: true,
//             floating: false,
//             expandedHeight: 300,
//             flexibleSpace: LayoutBuilder(
//               builder: (context, constraints) {
//                 final percent =
//                     (constraints.maxHeight - kToolbarHeight) / 300.0;

//                 return FlexibleSpaceBar(
//                   titlePadding: const EdgeInsets.only(left: 16, bottom: 8),
//                   title: percent > 0.3
//                       ? null
//                       : Text(
//                           selectedType == CategoryType.expense
//                               ? "Expense"
//                               : "Income",
//                         ),
//                   background: SingleChildScrollView(
//                     physics: const NeverScrollableScrollPhysics(),
//                     child: Padding(
//                       padding: const EdgeInsets.all(8),
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Text(
//                             "Monthly ${selectedType == CategoryType.expense ? 'Expenses' : 'Income'}",
//                             style: const TextStyle(
//                               fontSize: 20,
//                               fontWeight: FontWeight.w500,
//                             ),
//                           ),
//                           Text(
//                             "Total ${selectedType == CategoryType.expense ? 'Expenses' : 'Income'} of this Month",
//                             style: TextStyle(color: color.primary),
//                           ),
//                           Row(
//                             mainAxisAlignment: MainAxisAlignment.center,
//                             children: [
//                               ChoiceChip(
//                                 label: const Text("Expense"),
//                                 selected: selectedType == CategoryType.expense,
//                                 onSelected: (val) {
//                                   setState(() {
//                                     selectedType = CategoryType.expense;
//                                   });
//                                 },
//                               ),
//                               const SizedBox(width: 8),
//                               ChoiceChip(
//                                 label: const Text("Income"),
//                                 selected: selectedType == CategoryType.income,
//                                 onSelected: (value) {
//                                   setState(() {
//                                     selectedType = CategoryType.income;
//                                   });
//                                 },
//                               ),
//                             ],
//                           ),
//                           AnimatedContainer(
//                             duration: const Duration(milliseconds: 300),
//                             height: (150 * percent.clamp(0.4, 1)),
//                             child: PieChartScreen(selectedType: selectedType),
//                           ),
//                           Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             children: [
//                               Text(
//                                 "Recent Transactions",
//                                 style: TextStyle(
//                                   fontSize: 25,
//                                   fontWeight: FontWeight.w500,
//                                   color: color.primary,
//                                 ),
//                               ),
//                               GestureDetector(
//                                 onTap: scrollToList,
//                                 child: Text(
//                                   "See All",
//                                   style: TextStyle(
//                                     color: color.primary,
//                                     fontWeight: FontWeight.bold,
//                                     decoration: TextDecoration.underline,
//                                   ),
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                 );
//               },
//             ),
//           ),
//           // Transaction List as Sliver
//           SliverToBoxAdapter(
//             child: TransactionList(type: selectedType),
//           ),
//         ],
//       ),
//     );
//   }
// }

import 'package:expense_tracker/models/categroy/category_model.dart';
import 'package:expense_tracker/screens/chart/pie_chart_screen.dart';
import 'package:expense_tracker/screens/Main%20Screen/Balance/transaction_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class AnalyticsScreen extends StatefulWidget {
  const AnalyticsScreen({super.key});

  @override
  State<AnalyticsScreen> createState() => _AnalyticsScreenState();
}

class _AnalyticsScreenState extends State<AnalyticsScreen> {
  CategoryType selectedType = CategoryType.expense;

  final ScrollController _scrollController = ScrollController();

  void scrollToList() {
    if (_scrollController.hasClients) {
      _scrollController.animateTo(
        _scrollController.position.minScrollExtent + 300,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    } else {
      debugPrint("ScrollController not attached yet");
    }
  }

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme;
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Montly ${selectedType == CategoryType.expense ? 'Expenses' : 'Income'}",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
          ),
          Text(
            "Total  ${selectedType == CategoryType.expense ? 'Expenses' : 'Income'} of this Month",
            style: TextStyle(color: color.primary),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ChoiceChip(
                label: const Text("Expense"),
                selected: selectedType == CategoryType.expense,
                onSelected: (val) {
                  setState(() {
                    selectedType = CategoryType.expense;
                  });
                },
              ),
              const SizedBox(width: 8),
              ChoiceChip(
                label: const Text("Income"),
                selected: selectedType == CategoryType.income,
                onSelected: (value) {
                  setState(() {
                    selectedType = CategoryType.income;
                  });
                },
              ),
            ],
          ),
          SizedBox(height: 40,),
          SizedBox( child: PieChartScreen(selectedType: selectedType)),
          SizedBox(height:40 ,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Recent Transaction",
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.w500,
                  color: color.primary,
                ),
              ),
              GestureDetector(onTap: scrollToList, child: Text("See All")),
            ],
          ),
          Expanded(child: SizedBox( child: TransactionList(type: selectedType))),
        ],
      ),
    );
  }
}
