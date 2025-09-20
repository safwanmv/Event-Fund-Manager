import 'package:expense_tracker/CustomWidgets/c_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Eventaddbottomsheet extends StatefulWidget {
  const Eventaddbottomsheet({super.key});

  @override
  State<Eventaddbottomsheet> createState() => _EventaddbottomsheetState();
}

class _EventaddbottomsheetState extends State<Eventaddbottomsheet> {
  final formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _targetedAmountController = TextEditingController();
  @override
  Widget build(BuildContext context) {
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
              "Add Events",
              style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold),
            ),
            CTextFromField(
              controller: _titleController,
              title: "Title",
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Enter title ";
                }
                return null;
              },
            ),
            CTextFromField(
              controller: _descriptionController,
              title: "Description",
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Give Descriptioin";
                }
                return null;
              },
              keyboardType: TextInputType.multiline,
              maxLength: null,
              minLines: 3,
            ),
            CTextFromField(
              controller: _targetedAmountController,
              title: "Targeted Amount",
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Enter the Targeted Amount";
                }
                return null;
              },
            ),
          ],
        ),
      ),
    );
  }
}
