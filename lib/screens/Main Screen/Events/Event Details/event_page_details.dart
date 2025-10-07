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
      appBar: AppBar(
        title: const Text("Event Details"),
        centerTitle: true,
        elevation: 1,
      ),

      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 🔹 [1] Event title & description wrapped in a Card
            Card(
              color: color.surfaceDim,
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Padding(
                padding: EdgeInsets.all(16.r),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      selectedEvent!.title,
                      style: TextStyle(
                        fontSize: 24.sp,
                        fontWeight: FontWeight.bold,
                        color: color.primary,
                      ),
                    ),
                    SizedBox(height: 8.h),
                    Text(
                      selectedEvent!.description,
                      style: TextStyle(
                        fontSize: 15.sp,
                        color: color.onSurface.withOpacity(0.8),
                      ),
                    ),
                    SizedBox(height: 10.h),
                    Text(
                      "Created on: ${FormattedDate.date(selectedEvent!.date)}",
                      style: TextStyle(
                        fontSize: 13.sp,
                        color: color.onSurface.withOpacity(0.6),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            SizedBox(height: 10.h),

            // 🔹 [2] Amount summary with subtle container
            Container(
              padding: EdgeInsets.all(16.r),
              decoration: BoxDecoration(
                color: color.surfaceDim,
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _amountColumn(
                    "Targeted",
                    selectedEvent!.targetedAmount.toString(),
                    color.primary,
                  ),
                  _amountColumn(
                    "Collected",
                    selectedEvent!.collectedAmount.toString(),
                    Colors.green,
                  ),
                ],
              ),
            ),

            SizedBox(height: 10.h),

            // 🔹 [3] Join code card with icons
            Card(
              color: color.surfaceDim,
              elevation: 1,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.r),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        "Join Code: ${selectedEvent!.joinCode}",
                        style: TextStyle(
                          fontSize: 15.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.copy),
                      color: color.primary,
                      onPressed: () {
                        Clipboard.setData(
                          ClipboardData(text: selectedEvent!.joinCode),
                        );
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: const Text("Copied to clipboard!")),
                        );
                      },
                    ),
                    IconButton(
                      icon: const Icon(Icons.share),
                      color: color.primary,
                      onPressed: () {
                        // TODO: Add share logic
                      },
                    ),
                  ],
                ),
              ),
            ),

            SizedBox(height: 20.h),

            // 🔹 [4] Participants Table section
            Text(
              "Participants",
              style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10.h),

            ValueListenableBuilder(
              valueListenable: ParticipantDb.instance.participantsListNotifer,
              builder: (context, List<ParticipantsModel> participants, _) {
                final eventParticipants = participants
                    .where((p) => p.eventId == selectedEvent!.id)
                    .toList();

                if (eventParticipants.isEmpty) {
                  return Padding(
                    padding: EdgeInsets.only(top: 20.h),
                    child: EmptyDataContainer(text: TextMessages.noParticpants),
                  );
                }

                return Card(
                  color: color.surfaceDim,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                  elevation: 2,
                  child: Padding(
                    padding: EdgeInsets.all(5.r),
                    child: Table(
                      border: TableBorder.symmetric(
                        inside: BorderSide(
                          color: color.primary.withValues(alpha: 0.2),
                        ), // updated for new Flutter version
                      ),
                      columnWidths: const {
                        0: FlexColumnWidth(1),
                        1: FlexColumnWidth(3),
                        2: FlexColumnWidth(2),
                        3: FlexColumnWidth(3), // 👈 new column for Joined Date
                      },
                      children: [
                        TableRow(
                          decoration: BoxDecoration(
                            color: color.primary.withValues(alpha: 0.1),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          children: const [
                            CustomTableCell(
                              text: "S.No",
                              isHeader: true,
                              textAlign: TextAlign.center,
                            ),
                            CustomTableCell(
                              text: "Name",
                              isHeader: true,
                              textAlign: TextAlign.center,
                            ),
                            CustomTableCell(
                              text: "Amount",
                              isHeader: true,
                              textAlign: TextAlign.center,
                            ),
                            CustomTableCell(
                              text: "Joined Date",
                              isHeader: true,
                              textAlign: TextAlign.center,
                            ), // 👈 new header
                          ],
                        ),
                        ...eventParticipants.asMap().entries.map((entry) {
                          int idx = entry.key + 1;
                          ParticipantsModel p = entry.value;
                          final user = UserDb.instance.getUserById(
                            p.participantId,
                          );

                          return TableRow(
                            children: [
                              CustomTableCell(text: "$idx"),
                              CustomTableCell(text: user?.name ?? "Unknown"),
                              CustomTableCell(text: "${p.amountPaid}"),
                              CustomTableCell(
                                text: FormattedDate.date(p.joinedAt),
                              ),
                            ],
                          );
                        }),
                      ],
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  // 🔹 [Helper Widget] for displaying amounts
  Widget _amountColumn(String label, String value, Color color) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          label,
          style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w500),
        ),
        SizedBox(height: 4.h),
        Text(
          value,
          style: TextStyle(
            fontSize: 16.sp,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
      ],
    );
  }
}
