import 'package:flutter/material.dart';
import 'package:expense_tracker/CustomWidgets/c_text_form_field.dart';
import 'package:expense_tracker/db/Category_db/category_db.dart';
import 'package:expense_tracker/db/transaction_db/transaction_db.dart';
import 'package:expense_tracker/models/categroy/category_model.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
    CategoryDB.instance.refreshUI();
    selectedCategory = CategoryType.expense;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    final color = Theme.of(context).colorScheme;
    return Padding(
      padding: EdgeInsets.only(
        right: 26.w,
        left: 26.w,
        top: 16.h,
        bottom: MediaQuery.of(context).viewInsets.bottom + 46.h,
      ),
      child: Form(
        key: formKey,

        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "Add Category",
              style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold),
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
                    Text("Expense",style: TextStyle(fontSize: 16.sp),),
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
                Text("income",style: TextStyle(fontSize: 16.sp),),
              ],
            ),
            SizedBox(height: 12.h),
            DropdownButtonFormField(
              decoration: InputDecoration(
               border: InputBorder.none,
               
              ),
              hint: Text("Select Category",style: TextStyle(fontSize: 16.sp),),
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
            SizedBox(height: 12.h),
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
            SizedBox(height: 10.h),
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
            SizedBox(height: 10.h),
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
                    
              style: TextStyle(fontSize: 16.sp),),
              icon: Icon(Icons.calendar_month),
            ),
            SizedBox(height: 13.h),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(horizontal: 26.w, vertical: 6.h),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadiusGeometry.circular(12.r),
                ),
                backgroundColor: color.primary,
                foregroundColor: color.surface,
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
                     SnackBar(content: Text("Successfully Added",style: TextStyle(fontSize: 16.sp),)),
                  );
                }
              },
              child: Text("Submit",style: TextStyle(fontSize: 16.sp),),
            
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
