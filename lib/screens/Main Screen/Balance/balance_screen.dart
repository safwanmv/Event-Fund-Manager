import 'package:expense_tracker/constants/text_messages.dart';
import 'package:expense_tracker/db/Event_db/event_db.dart';
import 'package:expense_tracker/db/Users_db/users_db.dart';
import 'package:expense_tracker/db/transaction_db/transaction_db.dart';
import 'package:expense_tracker/models/Events/event_model.dart';
import 'package:expense_tracker/models/categroy/category_model.dart';
import 'package:expense_tracker/models/transaction/transaction%20_model.dart';
import 'package:expense_tracker/screens/Main%20Screen/Balance/Add%20Screen/category_add_bottom_sheet.dart';
import 'package:expense_tracker/screens/Main%20Screen/Balance/Add%20Screen/transaction_add_bottom_sheet.dart';
import 'package:expense_tracker/screens/Main%20Screen/Balance/transaction_list.dart';
import 'package:expense_tracker/widgets/Empty_data/text_message_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

class BalanceScreen extends StatefulWidget {
  const BalanceScreen({super.key});

  @override
  State<BalanceScreen> createState() => _BalanceScreenState();
}

class _BalanceScreenState extends State<BalanceScreen> {
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
      child: ValueListenableBuilder(
        valueListenable: EventDb.instance.eventListNotifer,
        builder: (context, eventlist, _) {
          return eventlist.isEmpty
              ? Column(
                children: [
                  Center(child: EmptyDataContainer(text: TextMessages.noEvents)),
                ],
              )
              : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ValueListenableBuilder<List<EventModel>>(
                      valueListenable: EventDb.instance.eventListNotifer,
                      builder: (context, allEvents, _) {
                        final activeUser =
                            UserDb.instance.activeUserNotifier.value;
                        if (activeUser == null) {
                          return Text("No user");
                        }
                        final userEvents = allEvents
                            .where((i) => i.createdBy == activeUser.name)
                            .toList();
                        final currentSelected =
                            EventDb.instance.selectedEventNotifer.value;
                        if (currentSelected != null &&
                            !userEvents.contains(currentSelected)) {
                          WidgetsBinding.instance.addPostFrameCallback((_) {
                            if (userEvents.isNotEmpty) {
                              EventDb.instance.selectedEvent(userEvents.first);
                            } else {
                              EventDb.instance.selectedEvent(null);
                            }
                          });
                        }
                        if (EventDb.instance.selectedEventNotifer.value ==
                            null) {
                          WidgetsBinding.instance.addPostFrameCallback((_) {
                            EventDb.instance.selectedEvent(userEvents.first);
                          });
                        }

                        return ValueListenableBuilder(
                          valueListenable:
                              EventDb.instance.selectedEventNotifer,
                          builder: (context, selectedEvent, _) {
                            final safeSelectedEvent =
                                userEvents.contains(selectedEvent)
                                ? selectedEvent
                                : null;
                            return DropdownButton<EventModel>(
                              hint: Text(
                                "Select Your Event",
                                style: TextStyle(fontSize: 14.sp),
                              ),
                              value: safeSelectedEvent,
                              isExpanded: false,
                              underline: SizedBox(),
                              items: userEvents.map((event) {
                                return DropdownMenuItem<EventModel>(
                                  value: event,
                                  child: Text(
                                    event.title,
                                    style: TextStyle(fontSize: 14.sp),
                                  ),
                                );
                              }).toList(),
                              onChanged: (event) {
                                EventDb.instance.selectedEvent(event);
                              },
                            );
                          },
                        );
                      },
                    ),
                    ValueListenableBuilder(
                      valueListenable: EventDb.instance.selectedEventNotifer,
                      builder: (context, selectedEvent, child) {
                        return Row(
                          children: [
                            Expanded(
                              child: BalanceCard(selectedEvent: selectedEvent),
                            ),
                            Column(
                              children: [
                                OutlinedButton(
                                  onPressed: selectedEvent == null
                                      ? null
                                      : () {
                                          showModalBottomSheet(
                                            context: context,
                                            isScrollControlled: true,
                                            builder: (context) =>
                                                TransactionAddBottomSheet(
                                                  eventId: selectedEvent.id,
                                                ),
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
                                  onPressed: selectedEvent == null
                                      ? null
                                      : () {
                                          showAddCategoryBottomSheet(
                                            context: context,
                                            eventId: selectedEvent.id,
                                          );
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
                        );
                      },
                    ),
                    SizedBox(height: 20.h),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Transactions", style: TextStyle(fontSize: 16.sp)),
                        Text(
                          "Amount",
                          style: TextStyle(
                            color: color.primary,
                            fontSize: 14.sp,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10.h),
                    Expanded(
                      child: ValueListenableBuilder(
                        valueListenable: EventDb.instance.selectedEventNotifer,
                        builder: (context, selectedEvent, child) {
                          if (selectedEvent == null) {
                            return Center(
                              child: Text(
                                "Please select an event to view transactions",
                                style: TextStyle(
                                  fontSize: 14.sp,
                                  color: Colors.grey,
                                ),
                              ),
                            );
                          } else {
                            return TransactionList(eventId: selectedEvent.id);
                          }
                        },
                      ),
                      // :
                    ),
                  ],
                );
        },
      ),
    );
  }
}

class BalanceCard extends StatelessWidget {
  final EventModel? selectedEvent;
  const BalanceCard({super.key, required this.selectedEvent});

  @override
  Widget build(BuildContext context) {
    if (selectedEvent == null) {
      return Center(
        child: Text(
          "Please select an event to view balance",
          style: TextStyle(fontSize: 14.sp, color: Colors.grey),
        ),
      );
    }
    final color = Theme.of(context).colorScheme;

    return ValueListenableBuilder(
      valueListenable: TransactionDb.instance.transactionListNotifer,
      builder: (BuildContext ctx, List<TransactionsModel> newList, Widget? _) {
        List<TransactionsModel> filteredList = selectedEvent == null
            ? newList
            : newList.where((i) => i.eventId == selectedEvent!.id).toList();
        double totalIncome = filteredList
            .where((i) => i.type == CategoryType.income)
            .fold(
              0.0,
              (previousValue, element) => previousValue + element.amount,
            );

        double totalExpense = filteredList
            .where((i) => i.type == CategoryType.expense)
            .fold(
              0.0,
              (previousValue, element) => previousValue + element.amount,
            );
        double balance = totalIncome - totalExpense;
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
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    selectedEvent!.title,
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
                                      Expanded(
                                        child: Text(
                                          selectedEvent!.description,
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 16.sp,
                                          ),
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                      Text(
                                        formattedDate(selectedEvent!.date),
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
                                crossAxisAlignment: CrossAxisAlignment.start,
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
                                        "Targeted Amount: ${selectedEvent!.targetedAmount.toString()}",
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
  }
}

String formattedDate(DateTime date) {
  return DateFormat('dd MMM yyyy').format(date);
}
