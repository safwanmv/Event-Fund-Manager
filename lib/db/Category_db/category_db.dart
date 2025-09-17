import 'package:expense_tracker/models/categroy/category_model.dart';
import 'package:flutter/widgets.dart';
import 'package:hive/hive.dart';

const CATEGORY_DB_NAME = 'category_db';

abstract class CategoryDbFunctions {
  Future<void> initCategoryBox();
  List<CategoryModel>
  getAllCategories(); // used for converting the db data to a list for future operations
  Future<void> insertCategory(CategoryModel obj);
  Future<void> deleteCategory(String id);
  Future<void> refreshUI();
}

class CategoryDB implements CategoryDbFunctions {
  CategoryDB._internal();
  static CategoryDB instance = CategoryDB._internal();
  factory CategoryDB() {
    return instance;
  }

  ValueNotifier<List<CategoryModel>> incomeCategoryListListner = ValueNotifier(
    [],
  );
  ValueNotifier<List<CategoryModel>> expenseCategoryListListner = ValueNotifier(
    [],
  );

  late final Box<CategoryModel> _categoryBox;

  @override
  Future<void> initCategoryBox() async {
    _categoryBox = await Hive.openBox<CategoryModel>(CATEGORY_DB_NAME);
  }

  @override
  List<CategoryModel> getAllCategories() {
    return _categoryBox.values.toList();
  }

  @override
  Future<void> refreshUI() async {
    final allCategoryList = await getAllCategories();
    incomeCategoryListListner.value.clear();
    expenseCategoryListListner.value.clear();

    await Future.forEach(allCategoryList, (CategoryModel category) {
      if (category.type == CategoryType.income) {
        incomeCategoryListListner.value.add(category);
      } else {
        expenseCategoryListListner.value.add(category);
      }
    });
    incomeCategoryListListner.notifyListeners();
    expenseCategoryListListner.notifyListeners();
  }

  @override
  Future<void> insertCategory(CategoryModel obj) async {
    await _categoryBox.put(obj.id, obj);
    await refreshUI();
  }

  @override
  Future<void> deleteCategory(String id) async {
    await _categoryBox.delete(id);
    refreshUI();
  }

  Future<void> addCategoryToDB(
    String name,
    CategoryType selectedCategory,
  ) async {
    final model = CategoryModel(name: name, type: selectedCategory);
    await CategoryDB.instance.insertCategory(model);
  }
}
