import 'dart:math' as math;

import 'package:expense_tracker/db/transaction_db/transaction_db.dart';
import 'package:expense_tracker/models/categroy/category_model.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class BarChartScreen extends StatelessWidget {
  const BarChartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme;

    return SizedBox(
      height: 200,
      child: ValueListenableBuilder(
        valueListenable: TransactionDb.instance.transactionListNotifer,
        builder: (context, newList, child) {
          final incomes = newList
              .where((i) => i.type == CategoryType.income)
              .toList();
          if (incomes.isEmpty) {
            return const Center(child: Text("No income data"));
          }
          incomes.sort((a, b) => b.amount.compareTo(a.amount));
          final topIncomes = incomes.take(4).toList();

          //set maxY
  
          final double highest = topIncomes
              .map((i) => i.amount)
              .fold(0.0, (p, e) => math.max(p, e));
          final double maxY = highest == 0 ? 10 : (highest * 1.3);
          return BarChart(
            BarChartData(
              //here we can set the limit
              maxY: maxY,
              gridData: FlGridData(show: false),
              barTouchData: BarTouchData(
                touchTooltipData: BarTouchTooltipData(
                  getTooltipColor: (group) => color.onSurface,
                  getTooltipItem: (group, groupIndex, rod, rodIndex) {
                    final idx = group.x.toInt();
                    if (idx < 0 || idx >= topIncomes.length) return null;
                    final amt = topIncomes[idx].amount;

                    return BarTooltipItem(
                      "${amt.toStringAsFixed(2)}",
                      TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    );
                  },

                  tooltipBorder: BorderSide(color: Colors.white),
                  tooltipPadding: EdgeInsets.all(8),
                  tooltipRoundedRadius: 10,
                  tooltipHorizontalAlignment: FLHorizontalAlignment.left,
                ),
              ),
              borderData: FlBorderData(show: false),
              titlesData: FlTitlesData(
                rightTitles: AxisTitles(),
                topTitles: AxisTitles(),
                bottomTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: true,
                    reservedSize: 30,
                    getTitlesWidget: (value, meta) {
                      final i = value.toInt();
                      if (i < 0 || i >= topIncomes.length)
                        return const SizedBox();

                      return Text(
                        topIncomes[i].name,
                        style: TextStyle(
                          color: color.primary,
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                        ),
                      );
                    },
                  ),
                ),
              ),
              barGroups: List.generate(topIncomes.length, (index) {
                final amt=topIncomes[index].amount;
                return BarChartGroupData(
                  x: index,

                  barRods: [
                    BarChartRodData(
                      toY: amt,
                      width: 22,
                      borderRadius: BorderRadius.circular(8),
                      color: color.primary,
                      backDrawRodData: BackgroundBarChartRodData(
                        color: color.onSurfaceVariant,
                        show: true,
                        toY: maxY,
                      ),
                    ),
                  ],
                );
              }),
            ),
          );
        },
      ),
    );
    // return Text("data");
  }
}
