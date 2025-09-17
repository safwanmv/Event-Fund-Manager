import 'package:expense_tracker/db/transaction_db/transaction_db.dart';
import 'package:expense_tracker/models/categroy/category_model.dart';
import 'package:expense_tracker/theme/colors/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:intl/intl.dart';

class HomescreenTopBanner extends StatelessWidget {
  final Color? color;
  const HomescreenTopBanner({super.key, this.color});

  @override
  Widget build(BuildContext context) {
    final double initialOffset = 312.w * 2;
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
          return Center(
            child: Text("No Data", style: TextStyle(fontSize: 16.sp)),
          );
        }
        incomes.sort((a, b) => b.amount.compareTo(a.amount));
        final topIncomes = incomes.take(4).toList();

        return SizedBox(
          height: 230.h,
          child: GridView.builder(
            controller: scrollController,
            scrollDirection: Axis.horizontal,

            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 1,
              mainAxisExtent: 330.w,
            ),
            itemBuilder: (context, index) {
              final value = topIncomes[index];
              final formattedDate = DateFormat('dd-MM-yyyy').format(value.date);
              return Container(
                margin: EdgeInsets.all(10.r),
                decoration: BoxDecoration(
                  color: topBannerColors[index % topBannerColors.length],
                  borderRadius: BorderRadius.circular(35.r),
                ),
                height: 80.h,
                child: Padding(
                  padding: EdgeInsets.all(10.0.r),
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
                                    fontSize: 10.sp,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                Text(
                                  "₹${value.amount}",
                                  style: TextStyle(
                                    fontSize: 28.sp,
                                    fontWeight: FontWeight.w700,
                                  ),
                                  overflow: TextOverflow.ellipsis,
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
                                    fontSize: 10.sp,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                Text(
                                  formattedDate,
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20.sp,
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
