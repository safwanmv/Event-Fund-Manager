import 'package:expense_tracker/db/Category_db/category_db.dart';
import 'package:expense_tracker/db/Event_db/event_db.dart';
import 'package:expense_tracker/db/Particpents_db/participents_db.dart';
import 'package:expense_tracker/screens/Main%20Screen/Events/Event%20Details/events_list.dart';
import 'package:expense_tracker/screens/Main%20Screen/Events/participent/participeted_event_List.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class EventParticipantPage extends StatefulWidget {
  const EventParticipantPage({super.key});

  @override
  State<EventParticipantPage> createState() => _EventParticipantPageState();
}

class _EventParticipantPageState extends State<EventParticipantPage>
    with SingleTickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      CategoryDB.instance.refreshUI();
      EventDb.instance.refreshUI();
      ParticipantDb.instance.refreshUI();
    });
  }

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme;
    return DefaultTabController(
      length: 2,
      child: Padding(
        padding: const EdgeInsets.all(0.0),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 16.w),
              child: Column(
                children: [
                  TabBar(
                    automaticIndicatorColorAdjustment: true,
                    labelColor: color.onSurface,
                    unselectedLabelColor: color.surfaceTint,
                    dividerColor: color.surface,
                    tabs: const [
                      Tab(text: "Created Events"),
                      Tab(text: "Participants"),
                    ],
                  ),
                ],
              ),
            ),
            Expanded(
              child: TabBarView(
                children: const [EventsList(), ParticipetedEventList()],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
