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
        _scrollController.position.maxScrollExtent, // scrolls down to list
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme;

    return Scaffold(
      body: CustomScrollView(
        controller: _scrollController,
        slivers: [
          /// ---- Collapsible Header with Pie Chart ----
          SliverAppBar(
            expandedHeight: 550.h,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              background: Padding(
                padding: EdgeInsets.all(12.r),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 10.h), // leave space for status bar
                    Text(
                      "Monthly ${selectedType == CategoryType.expense ? 'Expenses' : 'Income'}",
                      style: TextStyle(
                        fontSize: 20.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      "Total ${selectedType == CategoryType.expense ? 'Expenses' : 'Income'} of this Month",
                      style: TextStyle(color: color.primary, fontSize: 15.sp),
                    ),
                    SizedBox(height: 12.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ChoiceChip(
                          label: Text("Expense",
                              style: TextStyle(
                                color: color.primary,
                                fontSize: 14.sp,
                              )),
                          selected: selectedType == CategoryType.expense,
                          onSelected: (val) {
                            setState(() => selectedType = CategoryType.expense);
                          },
                        ),
                        SizedBox(width: 8.w),
                        ChoiceChip(
                          label: Text("Income",
                              style: TextStyle(
                                color: color.primary,
                                fontSize: 14.sp,
                              )),
                          selected: selectedType == CategoryType.income,
                          onSelected: (val) {
                            setState(() => selectedType = CategoryType.income);
                          },
                        ),
                      ],
                    ),
                    SizedBox(height: 40.h),
                    Expanded(
                      child: PieChartScreen(selectedType: selectedType),
                    ),
                  ],
                ),
              ),
            ),
          ),

          /// ---- Recent Transaction Title ----
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
              child: Row(
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
                  GestureDetector(
                    onTap: scrollToList,
                    child: Text("See All", style: TextStyle(fontSize: 14.sp)),
                  ),
                ],
              ),
            ),
          ),

          /// ---- Transaction List ----
          SliverToBoxAdapter(
            child: SizedBox(
              height: MediaQuery.of(context).size.height * 0.4, // give enough height
              child: TransactionList(type: selectedType),
            ),
          ),
        ],
      ),
    );
  }
}
