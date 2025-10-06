import 'package:expense_tracker/db/Particpents_db/participents_db.dart';
import 'package:expense_tracker/models/Events/event_model.dart';
import 'package:expense_tracker/screens/Main%20Screen/Balance/balance_screen.dart';
import 'package:expense_tracker/screens/Main%20Screen/Events/participent/Add_Screen/participant_add_fund_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ParticipentEventPageDetails extends StatelessWidget {
  final EventModel? selectedEvent;
  const ParticipentEventPageDetails({super.key, this.selectedEvent});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Event Page")),
      body: Padding(
        padding: EdgeInsets.all(8.r),
        child: Column(
          children: [
            ValueListenableBuilder(
              valueListenable: ParticipantDb.instance.participantsListNotifer,
              builder: (context, value, _) {
                return BalanceCard(selectedEvent: selectedEvent);
              }
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
                      builder: (context) =>
                          ParticipantAddFundScreen(eventId: selectedEvent!.id),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(
                      vertical: 16.h,
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
            // Expanded(child: ())
          ],
        ),
      ),
    );
  }
}
