import 'package:expense_tracker/db/transaction_db/transaction_db.dart';
import 'package:expense_tracker/models/Events/event_model.dart';
import 'package:expense_tracker/models/categroy/category_model.dart';
import 'package:expense_tracker/models/transaction/transaction%20_model.dart';
import 'package:fl_chart/fl_chart.dart';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PieChartScreen extends StatefulWidget {
  final CategoryType? selectedType;
  final EventModel? selectedEvent;

  const PieChartScreen({super.key, this.selectedType, this.selectedEvent});

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
            final filteredList=widget.selectedEvent==null?newList:newList.where((i)=>i.eventId==widget.selectedEvent!.id).toList();
            final categoryTotals = calculateCategoryTotals(filteredList);
            final titles = categoryTotals.keys.toList();
            final List<double> values = categoryTotals.values.toList();
            if (values.isEmpty) {
              return SizedBox(
                height: 300.h,
                child: Center(
                  child: Text(
                    "No ${widget.selectedType == CategoryType.expense ? "expenses" : "income"} to show",
                    style: TextStyle(fontSize: 16.sp, color: color.onSurface),
                  ),
                ),
              );
            }

            final double total = values.fold<double>(
              0.0,
              (previousValue, element) => previousValue + element,
            );

            return SizedBox(
              height: 300.h,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  PieChart(
                    PieChartData(
                      centerSpaceRadius: 120.r,
                      sectionsSpace: 1,
                      startDegreeOffset: 90.r,

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
                          title: titles[index].length > 7
                              ?"${ titles[index].substring(0, 5)} ..."
                              : titles[index],
                          titleStyle: TextStyle(
                            color: color.onSurface,
                            fontSize: 14.sp,
                            fontWeight: FontWeight.bold,
                            overflow: TextOverflow.ellipsis,
                          ),
                          color: getColorForIndex(index),
                          value: values[index],
                          radius: isSelected ? 80.r : 65.r,
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
                        style: TextStyle(color: color.primary, fontSize: 18.sp),
                      ),
                      Text(
                        "₹$total",
                        style: TextStyle(
                          color: color.onSurface,
                          fontWeight: FontWeight.bold,
                          fontSize: 40.sp,
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
