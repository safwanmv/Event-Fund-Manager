import 'dart:developer';

import 'package:expense_tracker/CustomWidgets/c_text_form_field.dart';
import 'package:expense_tracker/db/Event_db/event_db.dart';
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
    super.initState();

    TransactionDb.instance.refreshUI();
    EventDb.instance.refreshUI();
  }

  final _searchController = TextEditingController();
  bool _isSearching = false;

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme;
    final screenWidth = MediaQuery.of(context).size.width;

    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeInOut,
                      width: _isSearching
                          ? screenWidth - 52.w
                          : screenWidth * 0.55.r,
                      child: CTextFromField(
                        controller: _searchController,
                        title: "Search the Event",
                        validator: (value) {
                          return null;
                        },
                        prefixIcon: const Icon(Icons.search),
                        suffixIcon: _isSearching
                            ? IconButton(
                                icon: const Icon(Icons.close),
                    
                                onPressed: () {
                                  setState(() {
                                    _isSearching = false;
                                    _searchController.clear();
                                  });
                                },
                              )
                            : null,
                        textInputAction: TextInputAction.search,
                        onTap: () {
                          setState(() {
                            _isSearching = true;
                          });
                        },
                        onFieldSubmitted: (value) {
                          EventDb.instance.getEventsById(
                            _searchController.text.trim(),
                          );
                          log("clicked");
                        },
                      ),
                    ),
                  ),
                  SizedBox(width: 10.w),

                  AnimatedSwitcher(
                    duration: const Duration(milliseconds: 300),
                    child: _isSearching
                        ? const SizedBox.shrink()
                        : GestureDetector(
                            onTap: () {
                              log("message");
                            },
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                vertical: 13.h,
                                horizontal: 12.h,
                              ),
                              decoration: BoxDecoration(
                                color: color.onSurfaceVariant,
                                borderRadius: BorderRadius.circular(18.r),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Icon(Icons.add),
                                  Text(
                                    " Create Events",
                                    style: TextStyle(
                                      fontSize: 12.sp,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                  ),
                ],
              ),
            ),

            SizedBox(height: 10.h),
            HomescreenTopBanner(),
            Padding(
              padding: EdgeInsets.only(left: 22.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 20.h),
                  Text(
                    "User in The Last Week,",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16.sp,
                    ),
                  ),
                  Text(
                    "+2.1%",
                    style: TextStyle(
                      fontSize: 40.h,
                      fontWeight: FontWeight.w900,
                    ),
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
