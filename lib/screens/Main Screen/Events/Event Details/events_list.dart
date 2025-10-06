import 'package:expense_tracker/constants/text_messages.dart';
import 'package:expense_tracker/db/Event_db/event_db.dart';
import 'package:expense_tracker/screens/Main%20Screen/Events/Event%20Details/event_page_details.dart';
import 'package:expense_tracker/widgets/Empty_data/text_message_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class EventsList extends StatelessWidget {
  const EventsList({super.key});

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme;
    return ValueListenableBuilder(
      valueListenable: EventDb.instance.eventListNotifer,
      builder: (context, eventList, _) {
        if (eventList.isEmpty) {
          return SafeArea(child: Column(
            children: [
              EmptyDataContainer(text: TextMessages.noEvents,),
            ],
          ));
        }
        return ListView.separated(
          itemBuilder: (context, index) {
            final value = eventList[index];
            return SizedBox(
              child: Slidable(
                key: ValueKey(value.id),
                startActionPane: ActionPane(
                  motion: ScrollMotion(),
                  children: [
                    SlidableAction(
                      onPressed: (context) {
                        EventDb.instance.deleteEvent(value.id);
                      },
                      backgroundColor: Colors.red,
                      foregroundColor: Colors.white,
                      icon: Icons.delete,
                      borderRadius: BorderRadius.circular(23.r),
                      label: "Delete",
                    ),
                  ],
                ),
                child: InkWell(
                  onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (context)=>EventPageDetails(selectedEvent: value,))),
                  child: Card(
                    elevation: 2,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(23.r),
                    ),
                    child: ListTile(
                      textColor: color.primary,
                      title: Center(
                        child: Text(
                          value.title,
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      subtitle: Text(value.joinCode),
                      trailing: Text(value.participants.length.toString()),
                  
                    ),
                  ),
                ),
              ),
            );
          },
          separatorBuilder: (context, index) => SizedBox(height: 6.h),
          itemCount: eventList.length,
        );
      },
    );
  }
}
