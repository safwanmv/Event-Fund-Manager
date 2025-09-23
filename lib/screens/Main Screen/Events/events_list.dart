import 'package:expense_tracker/db/Event_db/event_db.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class EventsList extends StatelessWidget {
  const EventsList({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: EventDb.instance.eventListNotifer,
      builder: (context, eventList, _) {
        return ListView.separated(
          itemBuilder: (context, index) {
            final value=eventList[index];
            return Slidable(
              child: Card(
                elevation: 2,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(26.r),
                ),
                child: ListTile(
                  title: Text(value.title),
                ),
              ),
            );
          },
          separatorBuilder: (context, index) => SizedBox(height: 6.h),
          itemCount: eventList.length,
        );
      }
    );
  }
}
