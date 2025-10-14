import 'package:expense_tracker/models/categroy/category_model.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:uuid/uuid.dart';
part 'transaction_model.g.dart';

@HiveType(typeId: 3)
class TransactionsModel {
  @HiveField(0)
  final String id;
  @HiveField(1)
  final String name;
  @HiveField(2)
  final double amount;
  @HiveField(3)
  final DateTime date;
  @HiveField(4)
  final CategoryType type;
  @HiveField(5)
  final String eventId;
  @HiveField(6)
  final String? participantId;

  TransactionsModel({
    String? id,
    required this.name,
    required this.amount,
    required this.date,
    required this.type,
    required this.eventId,
    this.participantId,
  }) : id = id ?? const Uuid().v4();
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'amount': amount,
      'date': date.toIso8601String(),
      'type': type.name,
      'eventId': eventId,
      'participantId': participantId,
    };
  }

  factory TransactionsModel.fromMap(Map<String, dynamic> map) {
    return TransactionsModel(
      id: map['id'] ?? const Uuid().v4(),
      name: map['name'] ?? "",
      amount: (map['amount'] ?? 0).toDouble(),
      date: DateTime.tryParse(map['date'] ?? '') ?? DateTime.now(),
      type: map['type'] == 'income'
          ? CategoryType.income
          : map['type'] == 'expense'
          ? CategoryType.expense
          : CategoryType.expense,
      eventId: map['eventId'] ?? '',
      participantId: map['participantId'] ,
    );
  }
}
