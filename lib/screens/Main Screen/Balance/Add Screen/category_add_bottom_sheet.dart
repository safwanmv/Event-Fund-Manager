import 'package:expense_tracker/CustomWidgets/c_text_form_field.dart';
import 'package:expense_tracker/db/Category_db/category_db.dart';
import 'package:expense_tracker/models/categroy/category_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void showAddCategoryBottomSheet(BuildContext context,String eventId) {
  CategoryDB.instance.refreshUI();
  final color = Theme.of(context).colorScheme;
  final categoryNameController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  CategoryType? selectedCategory=CategoryType.expense;
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.r)),
    builder: (context) {
      return StatefulBuilder(
        builder: (context, setState) {
          return Padding(
            padding: EdgeInsets.only(
              right: 26.w,
              left: 26.w,
              top: 16.h,
              bottom:
                  MediaQuery.of(context).viewInsets.bottom +
                  56.h, 
            ),
            child: Form(
              key: formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "Add Category",
                    style: TextStyle(
                      fontSize: 20.sp,
                      fontWeight: FontWeight.bold,
                    ),
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
                          Text("Expense", style: TextStyle(fontSize: 16.sp)),
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
                          Text("Income", style: TextStyle(fontSize: 16.sp)),
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
                  SizedBox(height: 26.h),

                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(
                        horizontal: 36.w,
                        vertical: 6.h,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                      backgroundColor: color.primary,
                      foregroundColor: color.onSurface,
                    ),
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        final name = categoryNameController.text.trim();
                        final selectedType = selectedCategory;
                        CategoryDB.instance.addCategoryToDB(
                          name,
                          selectedType!,
                          eventId,

                        );
                        Navigator.of(context).pop();
                        ScaffoldMessenger.of(context).showSnackBar(
                           SnackBar(content: Text("Successfully Added",style: TextStyle(fontSize: 16.sp),)),
                        );
                      }
                    },
                    child: Text("Add",style: TextStyle(fontSize: 16.sp),),
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
