import 'package:hive_flutter/hive_flutter.dart';
import 'package:uuid/uuid.dart';
part 'participants_model.g.dart';

@HiveType(typeId: 6)
class ParticipantsModel {
  @HiveField(0)
  String id;
  @HiveField(1)
  String participantId;
  @HiveField(2)
  String eventId;
  @HiveField(3)
  double amountPaid;
  @HiveField(4)
  DateTime joinedAt;

  ParticipantsModel({
    String? id,
    required this.participantId,
    required this.eventId,
    required this.amountPaid,
    required this.joinedAt,
  }) : id = id ?? const Uuid().v4();
}
