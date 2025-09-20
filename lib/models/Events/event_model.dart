import 'package:uuid/uuid.dart';

class EventModel {
  String id;
  String title;
  String description;
  double targetedAmount;
  DateTime date;
  String createdBy;
  List<String> participants;
  EventModel({
    String? id,
    required this.title,
    required this.description,
    required this.date,
    required this.createdBy,
    required this.targetedAmount,
    List<String>? participants,
  }) : id = id ?? _generatedId(title),
       participants = participants ?? [];

  static String _generatedId(String title) {
    final uuid = const Uuid();
    final safeTitle = title
        .trim()
        .replaceAll(RegExp(r'\s+'), "_")
        .toUpperCase();
    return "${safeTitle}_${uuid.v4()}";
  }
}
