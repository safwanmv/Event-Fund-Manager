// abstract class TransactionDbFunctions {
//   Future<List<
// }

import 'package:expense_tracker/models/categroy/category_model.dart';
import 'package:expense_tracker/models/transaction/transaction%20_model.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

// ignore: constant_identifier_names
const TRANSACTION_DB_NAME = 'transaction-db';

abstract class TransactionDbFunctions {
  Future<void> addTransaction(TransactionsModel obj);
  List<TransactionsModel> getAllTransactions();
  Future<void> deleteTransaction(String id);
  Future<void> refreshUI();
}


class TransactionDb implements TransactionDbFunctions {
  ValueNotifier<List<TransactionsModel>> transactionListNotifer = ValueNotifier(
    [],
  );
  TransactionDb._internal();
  static TransactionDb instance = TransactionDb._internal();
  factory TransactionDb() {
    return instance;
  }

  late Box<TransactionsModel> _transactionBox;

  Future<void> initTransactionBox() async {
    _transactionBox = await Hive.openBox<TransactionsModel>(
      TRANSACTION_DB_NAME,
    );
  }

  @override
  Future<void> addTransaction(TransactionsModel obj) async {
    await _transactionBox.put(obj.id, obj);
    await refreshUI();
  }

  @override
  List<TransactionsModel> getAllTransactions() {
    return _transactionBox.values.toList();
  }

  @override
  Future<void> refreshUI() async {
    final _getAllTransactionList = await getAllTransactions();
    _getAllTransactionList.sort(
      (first, second) => second.date.compareTo(first.date),
    );
    transactionListNotifer.value=List.from(_getAllTransactionList);
  }

  @override
  Future<void> deleteTransaction(String id) async {
    await _transactionBox.delete(id);
    refreshUI();
  }

  Future<void> addTransactionTODB(
    String name,double amount,
    CategoryType selectedCategory,
    DateTime selectedDateTime,
    String eventId,
  ) async {
  
    
    final model = TransactionsModel(
      name: name,
      amount: amount,
      date: selectedDateTime,
      type: selectedCategory, 
      eventId: eventId,
    );
    print("Adding transaction with eventId: '$eventId'");

    await TransactionDb.instance.addTransaction(model);
  }
  

  
}
