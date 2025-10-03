import 'package:expense_tracker/models/Users/user_model.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

const SESSION_DB_NAME = 'session_db';
// ignore: constant_identifier_names
const USER_DB_NAME = 'users_db';

abstract class UserDbFunctions {
  Future<void> initUserBox();
  Future<void> insertUser(UserModel user);
  List<UserModel> getAllUsers();
  UserModel? getUserByEmail(String email);
  Future<void> updateUser(UserModel user);
  Future<void> deleteUser(String id);
  Future<void> refreshUI();
}

class UserDb implements UserDbFunctions {
  UserDb._internal();
  static UserDb instance = UserDb._internal();
  factory UserDb() {
    return instance;
  }

  ValueNotifier<List<UserModel>> userListNotifier = ValueNotifier([]);
  late final Box<UserModel> _userBox;

  @override
  Future<void> initUserBox() async {
    _userBox = await Hive.openBox<UserModel>(USER_DB_NAME);
  }

  @override
  List<UserModel> getAllUsers() {
    return _userBox.values.toList();
  }

  @override
  Future<void> refreshUI() async {
    userListNotifier.value.clear();
    userListNotifier.value.addAll(getAllUsers());
    userListNotifier.value = [...userListNotifier.value];
  }

  @override
  Future<void> insertUser(UserModel user) async {
    await _userBox.put(user.id, user);
    await refreshUI();
  }

  @override
  Future<void> deleteUser(String id) async {
    await _userBox.delete(id);
    await refreshUI();
  }

  @override
  UserModel? getUserByEmail(String email) {
    try {
      return _userBox.values.firstWhere((i) => i.email == email);
    } catch (_) {
      return null;
    }
  }

  @override
  Future<void> updateUser(UserModel user) async {
    await _userBox.put(user.id, user);
    await refreshUI();
  }

  Future<bool> addDataToDB({
    required String name,
    required String email,
    required String password,
  }) async {
    final existingUser = getUserByEmail(email);
    if (existingUser != null) {
      return false;
    }
    final dataToDB = UserModel(name: name, email: email, password: password);
    await UserDb.instance.insertUser(dataToDB);
    return true;
  }

  ValueNotifier<UserModel?> activeUserNotifier = ValueNotifier(null);

  Future<void> setActiveUser(String email) async {
    final user = getUserByEmail(email);
    if (user != null) {
      activeUserNotifier.value = user;
    }
    final sessionBox = await Hive.openBox<String>(SESSION_DB_NAME);
    await sessionBox.put('active_user_email', email);
    print("Active user set & persisted");
  }

  Future<void> clearActiveUser() async {
    activeUserNotifier.value = null;
    final sessionBox = await Hive.openBox<String>(SESSION_DB_NAME);
    await sessionBox.delete('active_user_email');
  }

  Future<void> loadActiveUser() async {
    final sessionBox = await Hive.openBox<String>(SESSION_DB_NAME);
    final email = sessionBox.get('active_user_email');
    if (email != null) {
      final user = getUserByEmail(email);
      if (user != null) {
        activeUserNotifier.value = user;
        print("Loaded active User: ${user.email}");
      }
    }
  }

  UserModel? getUserById(String id) {
    try {
      return _userBox.values.firstWhere((i) => i.id == id);
    } catch (_) {
      return null;
    }
  }
}
