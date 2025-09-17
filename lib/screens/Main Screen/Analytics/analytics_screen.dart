

import 'package:expense_tracker/models/categroy/category_model.dart';
import 'package:expense_tracker/screens/chart/pie_chart_screen.dart';
import 'package:expense_tracker/screens/Main%20Screen/Balance/transaction_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
        _scrollController.position.minScrollExtent + 300.h,
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
      padding:  EdgeInsets.all(8.r),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Montly ${selectedType == CategoryType.expense ? 'Expenses' : 'Income'}",
            style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.w500),
          ),
          Text(
            "Total  ${selectedType == CategoryType.expense ? 'Expenses' : 'Income'} of this Month",
            style: TextStyle(color: color.primary,fontSize: 15.sp),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ChoiceChip(
                label:  Text("Expense",style: TextStyle(color:color.primary,fontSize: 14.sp),),
                selected: selectedType == CategoryType.expense,
                onSelected: (val) {
                  setState(() {
                    selectedType = CategoryType.expense;
                  });
                },
              ),
               SizedBox(width: 8.w),
              ChoiceChip(
                label:  Text("Income",style: TextStyle(color: color.primary,fontSize: 14.sp),),
                selected: selectedType == CategoryType.income,
                onSelected: (value) {
                  setState(() {
                    selectedType = CategoryType.income;
                  });
                },
              ),
            ],
          ),
          SizedBox(height: 40.h,),
          SizedBox( child: PieChartScreen(selectedType: selectedType)),
          SizedBox(height:40.h ,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Recent Transaction",
                style: TextStyle(
                  fontSize: 25.sp,
                  fontWeight: FontWeight.w500,
                  color: color.primary,
                ),
              ),
              GestureDetector(onTap: scrollToList, child: Text("See All",style: TextStyle(fontSize: 14.sp),)),
            ],
          ),
          Expanded(child: SizedBox( child: TransactionList(type: selectedType))),
        ],
      ),
    );
  }
}
