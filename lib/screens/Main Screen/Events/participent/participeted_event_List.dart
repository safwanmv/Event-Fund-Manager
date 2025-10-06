import 'package:expense_tracker/constants/text_messages.dart';
import 'package:expense_tracker/db/Event_db/event_db.dart';
import 'package:expense_tracker/db/Particpents_db/participents_db.dart';
import 'package:expense_tracker/db/Users_db/users_db.dart';
import 'package:expense_tracker/screens/Main%20Screen/Events/participent/participent_event_page_details.dart';
import 'package:expense_tracker/widgets/Empty_data/text_message_widget.dart';
import 'package:expense_tracker/widgets/formatted/formatted_date.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ParticipetedEventList extends StatelessWidget {
  const ParticipetedEventList({super.key});

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme;
    return ValueListenableBuilder(
      valueListenable: UserDb.instance.activeUserNotifier,
      builder: (context, activeUser, _) {
        if (activeUser == null) {
          return const Center(child: CircularProgressIndicator());
        }
        return ValueListenableBuilder(
          valueListenable: ParticipantDb.instance.participantsListNotifer,
          builder: (context, particpants, _) {
            if (particpants.isEmpty) {
              return const Center(
                child: EmptyDataContainer(
                  text: TextMessages.notParticipatedAnyEvents,
                ),
              );
            }
            final myEvents = particpants
                .where((i) => i.participantId == activeUser.id)
                .toList();
            if (myEvents.isEmpty) {
              return const Center(
                child: EmptyDataContainer(
                  text: TextMessages.notParticipatedAnyEvents,
                ),
              );
            }
            return ListView.separated(
              separatorBuilder: (context, index) => SizedBox(height: 6.h),

              itemCount: myEvents.length,
              itemBuilder: (context, index) {
                final participantEntry = myEvents[index];
                final event = EventDb.instance.getEventsById(
                  participantEntry.eventId,
                );
                if (event == null) {
                  return const Center(child: CircularProgressIndicator());
                }
                final eventName = event.title;

                return InkWell(
                  onTap: () => Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) =>
                          ParticipentEventPageDetails(selectedEvent: event),
                    ),
                  ),
                  child: Card(
                    elevation: 2,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(32.r),
                    ),
                    child: ListTile(
                      title: Text(eventName, style: TextStyle(fontSize: 16.sp)),
                      subtitle: Text(
                        FormattedDate.date(event.date),
                        style: TextStyle(color: color.onSurface),
                      ),
                    ),
                  ),
                );
              },
            );
          },
        );
      },
    );
  }
}
