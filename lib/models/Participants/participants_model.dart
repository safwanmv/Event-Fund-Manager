import 'package:uuid/uuid.dart';

class ParticipantsModel {
  String id;
  String participantId;
  String eventId;
  double amountPaid;
  DateTime joinedAt;

  ParticipantsModel({
    String? id,
    required this.participantId,
    required this.eventId,
    required this.amountPaid,
    required this.joinedAt,
  }) : id = id ?? const Uuid().v4();
}
