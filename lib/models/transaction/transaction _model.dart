
import 'package:expense_tracker/models/categroy/category_model.dart';
import 'package:hive_flutter/hive_flutter.dart';
part 'transaction _model.g.dart';

@HiveType(typeId: 3)
class TransactionModel {
  @HiveField(0)
  final String id;
  @HiveField(1)
  final String name;
  @HiveField(2)
  final bool isDeleted;
  @HiveField(3)
  final CategoryType type;

  TransactionModel({
    required this.id,
    required this.name,
    required this.type,
    this.isDeleted = false,
  });
}
