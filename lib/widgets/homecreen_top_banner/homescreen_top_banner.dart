import 'dart:math' as math;

import 'package:expense_tracker/db/transaction_db/transaction_db.dart';
import 'package:expense_tracker/models/categroy/category_model.dart';
import 'package:expense_tracker/theme/colors/color.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class HomescreenTopBanner extends StatelessWidget {
  final Color? color;
  const HomescreenTopBanner({super.key, this.color});

  @override
  Widget build(BuildContext context) {
    final double initialOffset = 312 * 2;
    final ScrollController scrollController = ScrollController(
      initialScrollOffset: initialOffset,
    );
    return ValueListenableBuilder(
      valueListenable: TransactionDb.instance.transactionListNotifer,
      builder: (context, newList, _) {
        final incomes = newList
            .where((i) => i.type == CategoryType.income)
            .toList();
        if (incomes.isEmpty) {
          return const Center(child: Text("data"));
        }
        incomes.sort((a, b) => b.amount.compareTo(a.amount));
        final topIncomes=incomes.take(4).toList();

        // final double highest=topIncomes.map((i)=>i.amount).fold(0.0, (p,e)=>math.max(p,e));
        return SizedBox(
          height: 230,
          child: GridView.builder(
            controller: scrollController,
            scrollDirection: Axis.horizontal,

            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 1,
              mainAxisExtent: 330,
            ),
            itemBuilder: (context, index) {
              final value = topIncomes[index];
              final formattedDate = DateFormat('dd-MM-yyyy').format(value.date);
              return Container(
                margin: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: topBannerColors[index % topBannerColors.length],
                  borderRadius: BorderRadius.circular(35),
                ),
                height: 80,
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  value.name,
                                  style: TextStyle(
                                    fontSize: 10,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                Text(
                                  "₹${value.amount}",
                                  style: TextStyle(
                                    fontSize: 28,
                                    fontWeight: FontWeight.w700,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  value.type.toString(),
                                  style: TextStyle(
                                    fontSize: 10,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                Text(
                                  formattedDate,
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
            itemCount: topIncomes.length,

          ),
        );
      },
    );
  }
}
