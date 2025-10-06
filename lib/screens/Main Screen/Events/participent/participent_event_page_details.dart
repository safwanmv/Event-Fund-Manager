import 'package:expense_tracker/db/Particpents_db/participents_db.dart';
import 'package:expense_tracker/db/Users_db/users_db.dart';
import 'package:expense_tracker/models/Events/event_model.dart';
import 'package:expense_tracker/screens/Main%20Screen/Balance/balance_screen.dart';
import 'package:expense_tracker/screens/Main%20Screen/Balance/transaction_list.dart';
import 'package:expense_tracker/screens/Main%20Screen/Events/participent/Add_Screen/participant_add_fund_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ParticipentEventPageDetails extends StatelessWidget {
  final EventModel? selectedEvent;
  const ParticipentEventPageDetails({super.key, this.selectedEvent});

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: AppBar(title: Text("Event Page")),
      body: ValueListenableBuilder(
        valueListenable: UserDb.instance.activeUserNotifier,
        builder: (context, activeUser, _) {
          if (activeUser == null) {
            return const Center(child: CircularProgressIndicator());
          }
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.r),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                ValueListenableBuilder(
                  valueListenable:
                      ParticipantDb.instance.participantsListNotifer,
                  builder: (context, value, _) {
                    return BalanceCard(selectedEvent: selectedEvent);
                  },
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24.0.w),
                  child: SizedBox(
                    width: double.infinity, // full width
                    child: ElevatedButton(
                      onPressed: () {
                        showModalBottomSheet(
                          context: context,
                          isScrollControlled: true,
                          builder: (context) => ParticipantAddFundScreen(
                            eventId: selectedEvent!.id,
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.symmetric(
                          vertical: 12.h,
                        ), // adjust height
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.add, size: 24.sp),
                          SizedBox(width: 2.w),
                          Text(
                            "Add",
                            style: TextStyle(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20.h),
                Padding(
                  padding: const EdgeInsets.only(left: 18.0),
                  child: Text(
                    "Recent Transaction",
                    style: TextStyle(
                      fontSize: 22.sp,
                      fontWeight: FontWeight.w500,
                      color: color.primary,
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: (TransactionList(
                      eventId: selectedEvent!.id,
                      userId: activeUser.id,
                    )),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
