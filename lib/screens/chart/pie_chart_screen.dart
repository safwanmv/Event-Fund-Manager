// import 'package:expense_tracker/db/transaction_db/transaction_db.dart';
// import 'package:expense_tracker/models/categroy/category_model.dart';
// import 'package:expense_tracker/models/transaction/transaction%20_model.dart';
// import 'package:fl_chart/fl_chart.dart';

// import 'package:flutter/material.dart';

// class PieChartScreen extends StatefulWidget {
//   final CategoryType? selectedType;
//   final double height;

//   const PieChartScreen({super.key, this.selectedType, this.height = 300});

//   @override
//   State<PieChartScreen> createState() => _PieChartScreenState();
// }

// class _PieChartScreenState extends State<PieChartScreen> {
//   late CategoryType selectedType;
//   int isSelectedIndex = -1;

//   @override
//   void initState() {
//     super.initState();
//     TransactionDb.instance.refreshUI();
//     selectedType = widget.selectedType ?? CategoryType.expense;
//   }

//   @override
//   Widget build(BuildContext context) {
//     final color = Theme.of(context).colorScheme;

//     return LayoutBuilder(
//       builder: (context, constraints) {
//         final double availableHeight = constraints.maxHeight;
//         return Column(
//           children: [
//             ValueListenableBuilder<List<TransactionsModel>>(
//               valueListenable: TransactionDb.instance.transactionListNotifer,
//               builder: (context, newList, child) {
//                 final categoryTotals = calculateCategoryTotals(newList);
//                 final titles = categoryTotals.keys.toList();
//                 final List<double> values = categoryTotals.values.toList();

//                 final double total = values.fold<double>(
//                   0.0,
//                   (previousValue, element) => previousValue + element,
//                 );
//                 if (titles.isEmpty) {
//                   return const Center(
//                     child: Text("No data available for this category."),
//                   );
//                 }

//                 return SizedBox(
//                   height: availableHeight,
//                   child: Stack(
//                     alignment: Alignment.center,
//                     children: [
//                       PieChart(
//                         PieChartData(
//                           centerSpaceRadius: availableHeight * 0.25,
//                           sectionsSpace: 1,
//                           startDegreeOffset: 90,

//                           pieTouchData: PieTouchData(
//                             enabled: true,
//                             touchCallback: (event, response) {
//                               if (!event.isInterestedForInteractions ||
//                                   response == null ||
//                                   response.touchedSection == null) {
//                                 setState(() {
//                                   isSelectedIndex = -1;
//                                 });
//                                 return;
//                               }
//                               setState(() {
//                                 isSelectedIndex = response
//                                     .touchedSection!
//                                     .touchedSectionIndex;
//                               });
//                             },
//                           ),
//                           titleSunbeamLayout: true,
//                           sections: List.generate(values.length, (index) {
//                             bool isSelected = index == isSelectedIndex;

//                             return PieChartSectionData(
//                               title: titles[index],
//                               titleStyle: TextStyle(
//                                 color: color.onSurface,
//                                 fontSize: 14,
//                                 fontWeight: FontWeight.bold,
//                               ),
//                               color: getColorForIndex(index),
//                               value: values[index],
//                               radius: isSelected
//                                   ? availableHeight * 0.18
//                                   : availableHeight * 0.14,
//                               // borderSide: BorderSide(color: Colors.black, width: 1),
//                             );
//                           }),
//                         ),
//                         swapAnimationDuration: const Duration(
//                           milliseconds: 900,
//                         ),
//                         swapAnimationCurve: Curves.decelerate,
//                       ),
//                       Column(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           Text(
//                             widget.selectedType == CategoryType.expense
//                                 ? "Total Expense"
//                                 : "Totoal Income",
//                             style: TextStyle(color: color.primary),
//                           ),
//                           Text(
//                             "₹$total",
//                             style: TextStyle(
//                               color: color.onSurface,
//                               fontWeight: FontWeight.bold,
//                               fontSize: availableHeight*0.1,
//                             ),
//                           ),
//                         ],
//                       ),
//                     ],
//                   ),
//                 );
//               },
//             ),
//           ],
//         );
//       },
//     );
//   }

//   Map<String, double> calculateCategoryTotals(
//     List<TransactionsModel> transactions,
//   ) {
//     final Map<String, double> totals = {};
//     for (var i in transactions) {
//       if (i.type == widget.selectedType) {
//         final categoryName = i.name;
//         totals[categoryName] = (totals[categoryName] ?? 0) + i.amount;
//       }
//     }
//     return totals;
//   }

//   Color getColorForIndex(int index) {
//     final colors = [
//       const Color(0xFFADEBB3),
//       const Color(0xFFFFD78E),
//       const Color(0xFF89CFF0),
//       const Color.fromARGB(255, 50, 50, 50),
//     ];
//     return colors[index % colors.length];
//   }
// }


import 'package:expense_tracker/db/transaction_db/transaction_db.dart';
import 'package:expense_tracker/models/categroy/category_model.dart';
import 'package:expense_tracker/models/transaction/transaction%20_model.dart';
import 'package:fl_chart/fl_chart.dart';

import 'package:flutter/material.dart';

class PieChartScreen extends StatefulWidget {
  final CategoryType? selectedType;

  const PieChartScreen({super.key, this.selectedType});

  @override
  State<PieChartScreen> createState() => _PieChartScreenState();
}

class _PieChartScreenState extends State<PieChartScreen> {
    late CategoryType selectedType;

  @override
  void initState() {
    super.initState();

  selectedType = widget.selectedType ?? CategoryType.expense;
    TransactionDb.instance.refreshUI();
  } 

  int isSelectedIndex = -1;
  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme;

    return Column(
      children: [
        ValueListenableBuilder<List<TransactionsModel>>(
          valueListenable: TransactionDb.instance.transactionListNotifer,
          builder: (context, newList, child) {
            final categoryTotals = calculateCategoryTotals(newList);
            final titles = categoryTotals.keys.toList();
            final List<double> values = categoryTotals.values.toList();

            final double total = values.fold<double>(
              0.0,
              (previousValue, element) => previousValue + element,
            );

            return SizedBox(
              height: 300,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  PieChart(
                    PieChartData(
                      centerSpaceRadius: 120,
                      sectionsSpace: 1,
                      startDegreeOffset: 90,

                      pieTouchData: PieTouchData(
                        enabled: true,
                        touchCallback: (event, response) {
                          if (!event.isInterestedForInteractions ||
                              response == null ||
                              response.touchedSection == null) {
                            setState(() {
                              isSelectedIndex = -1;
                            });
                            return;
                          }
                          setState(() {
                            isSelectedIndex =
                                response.touchedSection!.touchedSectionIndex;
                          });
                        },
                      ),
                      titleSunbeamLayout: true,
                      sections: List.generate(values.length, (index) {
                        bool isSelected = index == isSelectedIndex;

                        return PieChartSectionData(
                          title: titles[index],
                          titleStyle: TextStyle(
                            color: color.onSurface,
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                          color: getColorForIndex(index),
                          value: values[index],
                          radius: isSelected ? 80 : 65,
                          // borderSide: BorderSide(color: Colors.black, width: 1),
                        );
                      }),
                    ),
                    swapAnimationDuration: const Duration(milliseconds: 900),
                    swapAnimationCurve: Curves.decelerate,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        widget.selectedType == CategoryType.expense
                            ? "Total Expense"
                            : "Totoal Income",
                        style: TextStyle(color: color.primary),
                      ),
                      Text(
                        "₹$total",
                        style: TextStyle(
                          color: color.onSurface,
                          fontWeight: FontWeight.bold,
                          fontSize: 40,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
        ),
      ],
    );
  }

  Map<String, double> calculateCategoryTotals(
    List<TransactionsModel> transactions,
  ) {
    final Map<String, double> totals = {};
    for (var i in transactions) {
      if (i.type == widget.selectedType) {
        final categoryName = i.name;
        totals[categoryName] = (totals[categoryName] ?? 0) + i.amount;
      }
    }
    return totals;
  }

  Color getColorForIndex(int index) {
    final colors = [
      const Color(0xFFADEBB3),
      const Color(0xFFFFD78E),
      const Color(0xFF89CFF0),
      const Color.fromARGB(255, 50, 50, 50),
    ];
    return colors[index % colors.length];
  }
}