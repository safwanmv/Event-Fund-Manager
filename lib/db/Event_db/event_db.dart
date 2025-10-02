import 'package:expense_tracker/models/Events/event_model.dart';
import 'package:flutter/widgets.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:collection/collection.dart';

// ignore: constant_identifier_names
const EVENT_DB_NAME = 'events_db';

abstract class EventDbFunctions {
  Future<void> initEventBox();
  Future<void> createEvent(
    String title,
    String description,
    DateTime date,
    String createdBy,
    double targetedAmount,
  );
  List<EventModel> getAllEvents();
  EventModel? getEventsById(String id);
  Future<void> updateEvent(EventModel obj);
  Future<void> deleteEvent(String id);
  Future<void> refreshUI();
  EventModel? getEventByJoinCode(String code);
}

class EventDb extends EventDbFunctions {
  EventDb._internal();
  static EventDb instance = EventDb._internal();
  factory EventDb() {
    return instance;
  }

  ValueNotifier<List<EventModel>> eventListNotifer = ValueNotifier([]);
  ValueNotifier<List<EventModel>> filteredEventsNotifer = ValueNotifier([]);
  //used for get the value of selected event to use across all the screen
  ValueNotifier<EventModel?> selectedEventNotifer = ValueNotifier(null);
  late final Box<EventModel> _eventBox;

  @override
  Future<void> initEventBox() async {
    _eventBox = await Hive.openBox(EVENT_DB_NAME);
  }

  @override
  Future<void> createEvent(
    String title,
    String description,
    DateTime date,
    String createdBy,
    double targetedAmount,
  ) async {
    String uniqueCode;
    print("0");
    do {
      uniqueCode = EventModel.generateJoinCode(title);
    } while (_eventBox.values.any((event) => event.joinCode == uniqueCode));
    final event = EventModel(
      title: title,
      description: description,
      date: date,
      createdBy: createdBy,
      targetedAmount: targetedAmount,
      joinCode: uniqueCode,
    );
    await _eventBox.put(event.id, event);
    await refreshUI();
  }

  @override
  List<EventModel> getAllEvents() {
    return _eventBox.values.toList();
  }

  @override
  EventModel? getEventsById(String id) {
    try {
      return _eventBox.values.firstWhere((i) => i.id == id);
    } catch (_) {
      return null;
    }
  }

  @override
  Future<void> refreshUI() async {
    final events = getAllEvents();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      eventListNotifer.value = events;
    });
  }

  @override
  Future<void> updateEvent(EventModel obj) async {
    await _eventBox.put(obj.id, obj);
  }

  @override
  Future<void> deleteEvent(String id) async {
    await _eventBox.delete(id);
    await refreshUI();
  }

  @override
  EventModel? getEventByJoinCode(String code) {
    try {
      return _eventBox.values.firstWhereOrNull((i) => i.joinCode == code);
    } catch (_) {
      return null;
    }
  }

  List<EventModel> getEventByUser(String userName) {
    return _eventBox.values.where((i) => i.createdBy == userName).toList();
  }

  void selectedEvent(EventModel? event) {
    selectedEventNotifer.value = event;
  }
}
