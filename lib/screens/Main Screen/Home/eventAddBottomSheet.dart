
import 'package:expense_tracker/CustomWidgets/c_text_form_field.dart';
import 'package:expense_tracker/db/Event_db/event_db.dart';
import 'package:expense_tracker/db/Users_db/users_db.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

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
    final color = Theme.of(context).colorScheme;
    return ValueListenableBuilder(
      valueListenable: UserDb.instance.activeUserNotifier,
      builder: (context, activeUser, _) {
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
                  style: TextStyle(
                    fontSize: 20.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 12.h),
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
                SizedBox(height: 10.h),
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
                  maxLines: null,
                  minLines: 3,
                ),
                SizedBox(height: 12.h),
                CTextFromField(
                  controller: _targetedAmountController,
                  title: "Targeted Amount",
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Enter the Targeted Amount";
                    }
                    return null;
                  },
                  keyboardType: TextInputType.number,
                ),
                SizedBox(height: 5.h),
                // TextButton.icon(
                //   onPressed: () async {
                //     final selectDateTimeTemp = await showDatePicker(
                //       context: context,
                //       initialDate: DateTime.now(),
                //       firstDate: DateTime.now().subtract(Duration(days: 365)),
                //       lastDate: DateTime.now(),
                //     );
                //     if (selectDateTimeTemp == null) {
                //       return;
                //     }
                //     setState(() {
                //       selectDateTime = selectDateTimeTemp;
                //     });
                //   },
                //   label: Text(
                //     selectDateTime == null
                //         ? "Select Date"
                //         : formattedDate(selectDateTime!),

                //     style: TextStyle(fontSize: 16.sp),
                //   ),
                //   icon: Icon(Icons.calendar_month),
                // ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(
                      horizontal: 26.w,
                      vertical: 6.h,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadiusGeometry.circular(12.r),
                    ),
                    backgroundColor: color.primary,
                    foregroundColor: color.surface,
                  ),
                  onPressed: () async{
                    if (formKey.currentState!.validate()) {
                      final title = _titleController.text.trim();
                      final description = _descriptionController.text.trim();
                      final targetedAmount = _targetedAmountController.text
                          .trim();
                      final targetedAmountDouble = double.parse(targetedAmount);
                      final createdBy = activeUser?.name ?? "no name";
                      final DateTime date=DateTime.now();
                      EventDb.instance.createEvent(title, description, date, createdBy, targetedAmountDouble);
                    await EventDb.instance.refreshUI();
                    EventDb.instance.filteredEventsNotifer.value=EventDb.instance.getAllEvents();
                    if(!mounted) return;
                      Navigator.of(context).pop();
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            "Successfully Added",
                            style: TextStyle(fontSize: 16.sp),
                          ),
                        ),
                      );
                    
                    }
                  },
                  child: Text("Submit"),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  String formattedDate(DateTime date) {
    return DateFormat('dd MMM yyyy').format(date);
  }
}
