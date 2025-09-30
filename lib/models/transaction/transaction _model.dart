import 'package:expense_tracker/models/categroy/category_model.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:uuid/uuid.dart';
part 'transaction _model.g.dart';

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

  TransactionsModel({
    String? id,
    required this.name,
    required this.amount,
    required this.date,
    required this.type, 
    required this.eventId,
  }) : id = id ?? const Uuid().v4();
}
