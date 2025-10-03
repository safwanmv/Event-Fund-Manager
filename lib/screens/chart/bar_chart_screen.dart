import 'dart:math' as math;

import 'package:expense_tracker/db/transaction_db/transaction_db.dart';
import 'package:expense_tracker/models/Events/event_model.dart';
import 'package:expense_tracker/models/categroy/category_model.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BarChartScreen extends StatelessWidget {
  final EventModel? selectedEvent;
  const BarChartScreen({super.key, this.selectedEvent});

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme;

    return SizedBox(
      height: 200.h,
      child: ValueListenableBuilder(
        valueListenable: TransactionDb.instance.transactionListNotifer,
        builder: (context, newList, child) {
          final filteredList=selectedEvent==null?newList:newList.where((i)=>i.eventId==selectedEvent!.id).toList();
          final incomes = filteredList
              .where((i) => i.type == CategoryType.income)
              .toList();
          if (incomes.isEmpty) {
            return Center(
              child: Text(
                "No Transaction data",
                style: TextStyle(fontSize: 16.sp),
              ),
            );
          }
          incomes.sort((a, b) => b.amount.compareTo(a.amount));
          final topIncomes = incomes.take(4).toList();

          final double highest = topIncomes
              .map((i) => i.amount)
              .fold(0.0, (p, e) => math.max(p, e));

          const double step = 5000; //we can set limit by the admin

          final double rawMaxY = highest * 1.2;

          final double maxY = ((rawMaxY / step).ceil()) * step;

          final double interval = step;

          return BarChart(
            BarChartData(
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
                      "$amt.toStringAsFixed(2)",
                      TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 14.sp,
                      ),
                    );
                  },

                  tooltipBorder: BorderSide(color: Colors.white),
                  tooltipPadding: EdgeInsets.all(8.r),
                  tooltipRoundedRadius: 10.r,
                  tooltipHorizontalAlignment: FLHorizontalAlignment.left,
                ),
              ),
              borderData: FlBorderData(show: false),
              titlesData: FlTitlesData(
                rightTitles: AxisTitles(),
                topTitles: AxisTitles(),
                leftTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: true,
                    interval: interval,
                    reservedSize: 40.w,
                    getTitlesWidget: (value, meta) {
                      if (value > maxY)
                        return const SizedBox(); // hide anything above maxY
                      return Text(
                        (value >= 1000)
                            ? "${(value / 1000).toInt()}k"
                            : value.toString(),
                        style: TextStyle(
                          fontSize: 12.sp,
                          color: Colors.grey[700],
                        ),
                      );
                    },
                  ),
                ),
                bottomTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: true,
                    reservedSize: 30.w,
                    getTitlesWidget: (value, meta) {
                      final i = value.toInt();
                      if (i < 0 || i >= topIncomes.length) {
                        return const SizedBox();
                      }
                      return Text(
                        topIncomes[i].name.length > 8
                            ? '${topIncomes[i].name.substring(0, 8)}...'
                            : topIncomes[i].name,
                        style: TextStyle(
                          color: color.primary,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w400,
                        ),
                      );
                    },
                  ),
                ),
              ),
              barGroups: List.generate(topIncomes.length, (index) {
                final amt = topIncomes[index].amount;
                return BarChartGroupData(
                  x: index,

                  barRods: [
                    BarChartRodData(
                      toY: amt,
                      width: 22.w,
                      borderRadius: BorderRadius.circular(8.r),
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
  }
}
