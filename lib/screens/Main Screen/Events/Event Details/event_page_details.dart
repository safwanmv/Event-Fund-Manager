import 'package:expense_tracker/constants/text_messages.dart';
import 'package:expense_tracker/db/Particpents_db/participents_db.dart';
import 'package:expense_tracker/db/Users_db/users_db.dart';
import 'package:expense_tracker/models/Events/event_model.dart';
import 'package:expense_tracker/models/Participants/participants_model.dart';
import 'package:expense_tracker/widgets/Custom_table_cell/custom_table_cell.dart';
import 'package:expense_tracker/widgets/Empty_data/text_message_widget.dart';
import 'package:expense_tracker/widgets/formatted/formatted_date.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class EventPageDetails extends StatelessWidget {
  final EventModel? selectedEvent;
  const EventPageDetails({super.key, this.selectedEvent});

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(title: Text("Event Details")),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Text(
                selectedEvent!.title,
                style: TextStyle(
                  fontSize: 30.sp,
                  fontWeight: FontWeight.bold,
                  color: color.primary,
                ),
              ),
            ),
            Text(
              selectedEvent!.description,
              style: TextStyle(fontSize: 16.sp),
              softWrap: true,
            ),
            SizedBox(height: 16.h),
            Text("Created Date: ${FormattedDate.date(selectedEvent!.date)}"),
            SizedBox(height: 12.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Text("Targeted Amount"),
                Text("Collected Amount"),
              ],
            ),
            Padding(
              padding: EdgeInsets.all(15.0.r),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("${selectedEvent!.targetedAmount}"),
                  Text(
                    "${selectedEvent!.collectedAmount}",
                    style: TextStyle(color: Colors.green),
                  ),
                ],
              ),
            ),

            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(7.r),
                border: BoxBorder.all(color: color.onPrimary, width: 3),
              ),
              padding: EdgeInsets.symmetric(horizontal: 8),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      "Join Code: ${selectedEvent!.joinCode}",
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.copy, color: color.onSurface),
                    onPressed: () {
                      Clipboard.setData(
                        ClipboardData(text: selectedEvent!.joinCode),
                      );
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text("Copied to clipboard!"),
                          backgroundColor: color.primary,
                        ),
                      );
                    },
                  ),
                  IconButton(
                    onPressed: () {
                      print("share clicked");
                    },
                    icon: Icon(Icons.share, color: color.primary),
                  ),
                ],
              ),
            ),
            SizedBox(height: 16),
            Text(
              "Participants",
              style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w400),
            ),
            SizedBox(height: 8.h),
            ValueListenableBuilder(
              valueListenable: ParticipantDb.instance.participantsListNotifer,
              builder: (context, List<ParticipantsModel> participants, _) {
                final eventParticipants = participants
                    .where((p) => p.eventId == selectedEvent!.id)
                    .toList();
                if (eventParticipants.isEmpty) {
                  return EmptyDataContainer(text: TextMessages.noParticpants);
                }
                return Table(
                  border: TableBorder.all(color: color.primary,borderRadius: BorderRadius.circular(7.r)),
                  columnWidths: const {
                    0: FlexColumnWidth(1),
                    1: FlexColumnWidth(3),
                    2: FlexColumnWidth(2),
                  },
                  children: [
                    TableRow(
                      // decoration: BoxDecoration(color: color.primary,),
                      children: [
                        CustomTableCell(
                          text: "S.NO",
                          isHeader: true,
                          textAlign: TextAlign.center,
                        ),
                        CustomTableCell(
                          text: "Participant Name",
                          isHeader: true,
                          textAlign: TextAlign.center,
                        ),
                        CustomTableCell(
                          text: "Amount",
                          isHeader: true,
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                    ...eventParticipants.asMap().entries.map((entry) {
                      int idx = entry.key + 1;
                      ParticipantsModel p = entry.value;

                      final user = UserDb.instance.getUserById(p.participantId);
                      // double amount=entry.value;
                      return TableRow(
                        // decoration: BoxDecoration(color: color.primary),

                        children: [
                          CustomTableCell(text: "$idx"),
                          CustomTableCell(text: user?.name ?? "unknown"),
                          CustomTableCell(text: "${p.amountPaid}"),
                        ],
                      );
                    }),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  void copyText(String text) {
    Clipboard.setData(ClipboardData(text: text));
  }
}
