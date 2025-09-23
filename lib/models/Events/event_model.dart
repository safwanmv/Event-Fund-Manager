import 'dart:math';

import 'package:hive_flutter/hive_flutter.dart';
import 'package:uuid/uuid.dart';
part 'event_model.g.dart';

@HiveType(typeId: 5)
class EventModel {
  @HiveField(0)
  String id;
  @HiveField(1)
  String title;
  @HiveField(2)
  String description;
  @HiveField(3)
  double targetedAmount;
  @HiveField(4)
  DateTime date;
  @HiveField(5)
  String createdBy;
  @HiveField(6)
  List<String> participants;
  @HiveField(7)
  String joinCode;
  @HiveField(8)
  double collectedAmount;
  EventModel({
    String? id,
    required this.title,
    required this.description,
    required this.date,
    required this.createdBy,
    required this.targetedAmount,
    double? collectedAmount,
    List<String>? participants,
    String? joinCode,
  }) : id = id ?? _generatedId(title),
       joinCode = joinCode ?? generateJoinCode(title),
       participants = participants ?? [],
       collectedAmount = collectedAmount ?? 0;

  static String _generatedId(String title) {
    final uuid = const Uuid();
    final safeTitle = title
        .trim()
        .replaceAll(RegExp(r'\s+'), "_")
        .toUpperCase();
    return "${safeTitle}_${uuid.v4()}";
  }

  static String generateJoinCode(String title, {int length = 4}) {
    const chars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
    final rnd = Random();

    final prefix = title.trim().toUpperCase()
      ..replaceAll(RegExp(r'[^A-Z0-9]'), '');
    final shortPrefix = prefix.isEmpty
        ? "EVT"
        : prefix.substring(0, min(3, prefix.length));

    final randomPart = List.generate(
      length,
      (_) => chars[rnd.nextInt(chars.length)],
    ).join();

    return "${shortPrefix}_$randomPart";
  }
}
