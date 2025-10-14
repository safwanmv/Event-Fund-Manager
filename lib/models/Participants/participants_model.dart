import 'package:expense_tracker/models/categroy/category_model.dart';
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
  @HiveField(5)
  final CategoryModel paymentCategory;
  @HiveField(6)
  bool isReceived;
  @HiveField(7)
  String participantName;

  ParticipantsModel({
    String? id,
    required this.participantId,
    required this.participantName,
    required this.eventId,
    required this.amountPaid,
    required this.joinedAt,
    required this.paymentCategory,
    this.isReceived = false,
  }) : id = id ?? const Uuid().v4();

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'participantId': participantId,
      'eventId': eventId,
      'amountPaid': amountPaid,
      'joinedAt': joinedAt.toIso8601String(),
      'paymentCategory': paymentCategory.toMap(),
      'isReceived': isReceived,
      'participantName': participantName,
    };
  }

  factory ParticipantsModel.fromMap(Map<String, dynamic> map) {
    return ParticipantsModel(
      id: map['id'] ?? const Uuid().v4(),
      participantId: map['participantId']??'',
      participantName: map['participantName']??'',
      eventId: map['eventId']??'',
      amountPaid: (map['amountPaid'] ?? 0).toDouble(),
      joinedAt: DateTime.tryParse(map['joinedAt'] ?? '') ?? DateTime.now(),
      isReceived: map['isReceived']??false,
      paymentCategory: map['paymentCategory'] !=null?CategoryModel.fromMap(Map<String,dynamic>.from(map['paymentCategory'])
      ):CategoryModel(name: 'unknown', type: CategoryType.income, eventId: map['eventId'])
    );
  }
}
