import 'package:expense_tracker/models/Events/event_model.dart';
import 'package:flutter/cupertino.dart';

class SelectedEventNotifer {
  static ValueNotifier<EventModel?>selectedEvent=ValueNotifier(null);
}