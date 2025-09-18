import 'package:hive_flutter/hive_flutter.dart';
import 'package:uuid/uuid.dart';
part 'user_model.g.dart';

@HiveType(typeId: 4)
class UserModel {
  @HiveField(0)
  String id;
  @HiveField(1)
  String name;
  @HiveField(2)
  String email;
  @HiveField(3)
  String password;
  @HiveField(4)
  bool isAdmin;

  UserModel({
    String? id,
    required this.name,
    required this.email,
    required this.password,
    this.isAdmin = false,
  }) : id = id ?? const Uuid().v4();
}
