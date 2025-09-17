import 'package:expense_tracker/db/transaction_db/transaction_db.dart';
import 'package:expense_tracker/screens/chart/bar_chart_screen.dart';
import 'package:expense_tracker/widgets/homecreen_top_banner/homescreen_top_banner.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String? selectedValue;

  @override
  void initState() {
    TransactionDb.instance.refreshUI();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            HomescreenTopBanner(),
            Padding(
              padding:  EdgeInsets.only(left: 22.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 20.h,),
                  Text(
                    "User in The Last Week,",
                    style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16.sp),
                  ),
                  Text(
                    "+2.1%",
                    style: TextStyle(fontSize: 40.h, fontWeight: FontWeight.w900),
                  ),
                  SizedBox(height: 50.h),
                  BarChartScreen(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

