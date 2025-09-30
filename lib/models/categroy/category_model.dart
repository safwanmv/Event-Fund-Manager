import 'package:hive_flutter/hive_flutter.dart';
import 'package:uuid/uuid.dart';
part 'category_model.g.dart';

@HiveType(typeId: 1)
enum CategoryType {
  @HiveField(0)
  income,
  @HiveField(1)
  expense,
}

@HiveType(typeId: 2)
class CategoryModel {
  @HiveField(0)
  final String id;
  @HiveField(1)
  final String name;
  @HiveField(2)
  final bool isDeleted;
  @HiveField(3)
  final CategoryType type;
  @HiveField(4)
  final String eventId;

  CategoryModel({
    String? id,
    required this.name,
    required this.type,
    this.isDeleted = false,
    required this.eventId,
  }) : id = id ?? const Uuid().v4();
}
