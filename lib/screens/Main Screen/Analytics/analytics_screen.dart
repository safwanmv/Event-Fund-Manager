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
        _scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme;
    final screenHeight = MediaQuery.of(context).size.height;

    return CustomScrollView(
      controller: _scrollController,
      slivers: [
        /// ---- Collapsible + Shrinkable Header ----
        SliverPersistentHeader(
          pinned: true,
          delegate: _AnalyticsHeaderDelegate(
            minExtent: screenHeight * 0.5.h, // stays until half screen
            maxExtent: screenHeight * 0.6.h, // fully expanded
            selectedType: selectedType,
            onTypeChanged: (type) {
              setState(() => selectedType = type);
            },
          ),
        ),
    
        /// ---- Recent Transaction Title ----
        SliverToBoxAdapter(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 1.h),
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
            height: screenHeight * 0.35,
            child: TransactionList(type: selectedType),
          ),
        ),
      ],
    );
  }
}

/// Custom Delegate to control shrinking
class _AnalyticsHeaderDelegate extends SliverPersistentHeaderDelegate {
  @override
  final double minExtent;
  @override
  final double maxExtent;
  final CategoryType selectedType;
  final ValueChanged<CategoryType> onTypeChanged;

  _AnalyticsHeaderDelegate({
    required this.minExtent,
    required this.maxExtent,
    required this.selectedType,
    required this.onTypeChanged,
  });

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    final color = Theme.of(context).colorScheme;
    final shrinkRatio = (shrinkOffset / (maxExtent - minExtent)).clamp(0.0, 1);

    return Container(
      padding: EdgeInsets.all(12.r),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Monthly ${selectedType == CategoryType.expense ? 'Expenses' : 'Income'}",
            style: TextStyle(
              fontSize: (20 - 4 * shrinkRatio).sp,
              fontWeight: FontWeight.w500,
            ),
          ),
          Text(
            "Total ${selectedType == CategoryType.expense ? 'Expenses' : 'Income'} of this Month",
            style: TextStyle(
              color: color.primary,
              fontSize: (15 - 3 * shrinkRatio).sp,
            ),
          ),
          SizedBox(height: 12.h * (1 - shrinkRatio)),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ChoiceChip(
                label: Text(
                  "Expense",
                  style: TextStyle(color: color.primary, fontSize: 14.sp),
                ),
                selected: selectedType == CategoryType.expense,
                onSelected: (val) => onTypeChanged(CategoryType.expense),
              ),
              SizedBox(width: 8.w),
              ChoiceChip(
                label: Text(
                  "Income",
                  style: TextStyle(color: color.primary, fontSize: 14.sp),
                ),
                selected: selectedType == CategoryType.income,
                onSelected: (val) => onTypeChanged(CategoryType.income),
              ),
            ],
          ),
          SizedBox(height: 40.h * (1 - shrinkRatio)),
          Expanded(
            child: Transform.scale(
              scale: 1 - (0.3 * shrinkRatio), // smoothly shrink pie chart
              alignment: Alignment.center,
              child: PieChartScreen(selectedType: selectedType),
            ),
          ),
        ],
      ),
    );
  }

  @override
  bool shouldRebuild(covariant _AnalyticsHeaderDelegate oldDelegate) {
    return oldDelegate.selectedType != selectedType;
  }
}
