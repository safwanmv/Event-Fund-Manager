import 'package:expense_tracker/db/Event_db/event_db.dart';
import 'package:expense_tracker/db/Users_db/users_db.dart';
import 'package:expense_tracker/db/transaction_db/transaction_db.dart';
import 'package:expense_tracker/models/Events/event_model.dart';
import 'package:expense_tracker/models/categroy/category_model.dart';
import 'package:expense_tracker/models/transaction/transaction%20_model.dart';
import 'package:expense_tracker/screens/Main%20Screen/Balance/Add%20Screen/category_add_bottom_sheet.dart';
import 'package:expense_tracker/screens/Main%20Screen/Balance/Add%20Screen/transaction_add_bottom_sheet.dart';
import 'package:expense_tracker/screens/Main%20Screen/Balance/transaction_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BalanceScreen extends StatefulWidget {
  const BalanceScreen({super.key});

  @override
  State<BalanceScreen> createState() => _BalanceScreenState();
}

class _BalanceScreenState extends State<BalanceScreen> {
  EventModel? selectedEvent;
  @override
  void initState() {
    super.initState();
    TransactionDb.instance.refreshUI();
    EventDb.instance.refreshUI();
  }

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme;
    return SafeArea(
      child: Column(
        children: [
          ValueListenableBuilder<List<EventModel>>(
            valueListenable: EventDb.instance.eventListNotifer,
            builder: (context, allEvents, _) {
              final activeUser = UserDb.instance.activeUserNotifier.value;
              if (activeUser == null) {
                return Text("No user");
              }
              final userEvents = allEvents
                  .where((i) => i.createdBy == activeUser.name)
                  .toList();

              return DropdownButton<EventModel>(
                hint: Text(
                  "Select Your Event",
                  style: TextStyle(fontSize: 14.sp),
                ),
                value: selectedEvent,
                isExpanded: false,
                underline: SizedBox(),
                items: userEvents.map((event) {
                  return DropdownMenuItem<EventModel>(
                    value: event,
                    child: Text(event.title, style: TextStyle(fontSize: 14.sp)),
                  );
                }).toList(),
                onChanged: (event) {
                  WidgetsBinding.instance.addPostFrameCallback((_){

           
                  setState(() {
                    selectedEvent = event;
                  });
                },
              );
                     });
            },
          ),
          Row(
            children: [
              Expanded(child: BalanceCard()),
              Column(
                children: [
                  OutlinedButton(
                    onPressed: () {
                      showModalBottomSheet(
                        context: context,
                        isScrollControlled: true,
                        builder: (context) => TransactionAddBottomSheet(),
                      );
                    },
                    style: OutlinedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.r),
                      ),
                      padding: EdgeInsets.all(25.r),
                    ),
                    child: Icon(Icons.add, size: 24.r),
                  ),
                  SizedBox(height: 40.h),
                  OutlinedButton(
                    onPressed: () {
                      showAddCategoryBottomSheet(context);
                    },
                    style: OutlinedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.r),
                      ),
                      padding: EdgeInsets.all(25.r),
                    ),
                    child: Icon(Icons.category, size: 24.r),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: 20.h),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Transactions", style: TextStyle(fontSize: 16.sp)),
              Text(
                "Amount",
                style: TextStyle(color: color.primary, fontSize: 14.sp),
              ),
            ],
          ),
          SizedBox(height: 10.h),
          Expanded(child: TransactionList()),
        ],
      ),
    );
  }
}

class BalanceCard extends StatelessWidget {
  const BalanceCard({super.key});

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme;

    return ValueListenableBuilder(
      valueListenable: TransactionDb.instance.transactionListNotifer,
      builder: (BuildContext ctx, List<TransactionsModel> newList, Widget? _) {
        double totalIncome = newList
            .where((i) => i.type == CategoryType.income)
            .fold(
              0.0,
              (previousValue, element) => previousValue + element.amount,
            );

        double totalExpense = newList
            .where((i) => i.type == CategoryType.expense)
            .fold(
              0.0,
              (previousValue, element) => previousValue + element.amount,
            );
        double balance = totalIncome - totalExpense;
        return ValueListenableBuilder(
          valueListenable: UserDb.instance.activeUserNotifier,
          builder: (context, activeUser, _) {
            return Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.0.w),
              child: SafeArea(
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadiusGeometry.circular(29.r),
                            ),
                            child: Column(
                              children: [
                                Container(
                                  width: double
                                      .infinity, // Fills the Card horizontally
                                  decoration: BoxDecoration(
                                    color: const Color(0xFF89CFF0),
                                    borderRadius: BorderRadius.vertical(
                                      top: Radius.circular(29.r),
                                    ),
                                  ),
                                  constraints: BoxConstraints(minHeight: 100.h),
                                  padding: EdgeInsets.all(16.r),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        activeUser?.name ?? "Loading..",
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 14.sp,
                                        ),
                                      ),
                                      SizedBox(height: 10.h),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            maskCardNumber("102034324"),
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 16.sp,
                                            ),
                                          ),
                                          Text(
                                            "11/25",
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 16.sp,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.all(16.r), // Add padding

                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Balance",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 16.sp,
                                        ),
                                      ),
                                      Text(
                                        "₹$balance",
                                        style: TextStyle(
                                          fontSize: 40.sp,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Row(
                                        children: [
                                          Text(
                                            "Total week Expense      23.3%",
                                            style: TextStyle(
                                              color: color.primary,
                                              fontSize: 16.sp,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}

String maskCardNumber(String number) {
  String lastFour = number.substring(number.length - 4);
  return "**** $lastFour";
}
