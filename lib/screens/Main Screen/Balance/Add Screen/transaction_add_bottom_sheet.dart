import 'package:flutter/material.dart';
import 'package:expense_tracker/CustomWidgets/c_text_form_field.dart';
import 'package:expense_tracker/db/Category_db/category_db.dart';
import 'package:expense_tracker/db/transaction_db/transaction_db.dart';
import 'package:expense_tracker/models/categroy/category_model.dart';
import 'package:intl/intl.dart';

class TransactionAddBottomSheet extends StatefulWidget {
  const TransactionAddBottomSheet({super.key});

  @override
  State<TransactionAddBottomSheet> createState() =>
      _TransactionAddBottomSheetState();
}

class _TransactionAddBottomSheetState extends State<TransactionAddBottomSheet> {
  CategoryType? selectedCategory = CategoryType.expense;

  CategoryModel? selectedCategoryModel;

  String? categoryId;

  final nameController = TextEditingController();

  final amountController = TextEditingController();

  DateTime? selectDateTime;

  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    // TODO: implement initState
    CategoryDB.instance.refreshUI();
    selectedCategory = CategoryType.expense;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    final color = Theme.of(context).colorScheme;
    return Padding(
      padding: EdgeInsets.only(
        right: 16,
        left: 16,
        top: 16,
        bottom: MediaQuery.of(context).viewInsets.bottom + 16,
      ),
      child: Form(
        key: formKey,

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
                          selectedCategory = CategoryType.expense;
                          categoryId = null;
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
                          selectedCategory = CategoryType.income;
                          categoryId = null;
                        });
                      },
                    ),
                  ],
                ),
                Text("income"),
              ],
            ),
            SizedBox(height: 12),
            DropdownButtonFormField(
              hint: Text("Select Category"),
              value: categoryId,
              items:
                  (selectedCategory == CategoryType.expense
                          ? CategoryDB.instance.expenseCategoryListListner.value
                          : CategoryDB.instance.incomeCategoryListListner.value)
                      .map((e) {
                        return DropdownMenuItem<String>(
                          value: e.id,
                          child: Text(e.name),
                          onTap: () => selectedCategoryModel = e,
                        );
                      })
                      .toList(),

              onChanged: (selectedValue) {
                setState(() {
                  categoryId = selectedValue;
                });
              },
              validator: (value) {
                if (value == null) {
                  return "Category is required";
                }
                return null;
              },
            ),
            SizedBox(height: 12),
            CTextFromField(
              controller: nameController,
              title: "Name ",
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return "Enter Transaction Name";
                }
                return null;
              },
            ),
            SizedBox(height: 10),
            CTextFromField(
              controller: amountController,
              title: "Amount",
              keyboardType: TextInputType.number,
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return "Please Enter Amount";
                }
                final parsed = double.tryParse(value);

                if (parsed == null || parsed <= 0) {
                  return "Enter an amount Greater than Zero";
                }
                return null;
              },
            ),
            SizedBox(height: 10),
            TextButton.icon(
              onPressed: () async {
                final selectDateTimeTemp = await showDatePicker(

                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime.now().subtract(Duration(days: 365)),
                  lastDate: DateTime.now(),
                
                );
                if (selectDateTimeTemp == null) {
                  return;
                }
                setState(() {
                  selectDateTime = selectDateTimeTemp;
                });
              },
              label: Text(
                selectDateTime == null
                    ? "Select Date"
                    : formattedDate(selectDateTime!),
                    
              ),
              icon: Icon(Icons.calendar_month),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(horizontal: 26, vertical: 6),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadiusGeometry.circular(12),
                ),
                backgroundColor: color.primary,
                foregroundColor: color.onSurface,
              ),
              onPressed: () {
                if (formKey.currentState!.validate()) {
                  final name = nameController.text;
                  final amountText = amountController.text.trim();
                  final amount = double.tryParse(amountText);
                  TransactionDb.instance.addTransactionTODB(
                    name,
                    amount!,
                    selectedCategory!,
                    selectDateTime!,
                  );
                  Navigator.of(context).pop();
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Successfully Added")),
                  );
                }
              },
              child: Text("Submit"),
            ),
          ],
        ),
      ),
    );
  }
  String formattedDate(DateTime date){
    return DateFormat('dd MMM yyyy').format(date);
  }
}
