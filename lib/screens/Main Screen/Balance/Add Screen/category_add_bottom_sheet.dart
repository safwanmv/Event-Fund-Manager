import 'package:expense_tracker/CustomWidgets/c_text_form_field.dart';
import 'package:expense_tracker/db/Category_db/category_db.dart';
import 'package:expense_tracker/models/categroy/category_model.dart';
import 'package:flutter/material.dart';

void showAddCategoryBottomSheet(BuildContext context) {
  CategoryDB.instance.refreshUI();
  final color = Theme.of(context).colorScheme;
  final categoryNameController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  CategoryType? selectedCategory;
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
    builder: (context) {
      return StatefulBuilder(
        builder: (context, setState) {
          return Padding(
            padding: EdgeInsets.only(
              right: 16,
              left: 16,
              top: 16,
              bottom: MediaQuery.of(context).viewInsets.bottom + 16,
            ),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "Add Category",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Row(
                        children: [
                          Radio(
                            value: CategoryType.expense,
                            groupValue: selectedCategory,
                            onChanged: (newValue) {
                              setState(() {
                                selectedCategory = newValue;
                              });
                            },
                          ),
                          Text("Expense"),
                        ],
                      ),
                      Row(
                        children: [
                          Radio(
                            value: CategoryType.income,
                            groupValue: selectedCategory,
                            onChanged: (newValue) {
                              setState(() {
                                selectedCategory = newValue;
                              });
                            },
                          ),
                          Text("Income"),
                        ],
                      ),
                    ],
                  ),

                  CTextFromField(
                    controller: categoryNameController,
                    title: "Category name",
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return "Please Enter Catergory";
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 16),

                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(
                        horizontal: 26,
                        vertical: 6,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      backgroundColor: color.primary,
                      foregroundColor: color.onSurface,
                    ),
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        final name = categoryNameController.text.trim();
                        final selectedType = selectedCategory;
                        CategoryDB.instance.addCategoryToDB(
                          name,
                          selectedType!,
                        );
                        Navigator.of(context).pop();
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text("Successfully Added")),
                        );
                      }
                    },
                    child: Text("Add"),
                  ),
                ],
              ),
            ),
          );
        },
      );
    },
  );
}
