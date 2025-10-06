import 'package:expense_tracker/CustomWidgets/c_text_form_field.dart';
import 'package:expense_tracker/db/Category_db/category_db.dart';
import 'package:expense_tracker/db/Event_db/event_db.dart';
import 'package:expense_tracker/db/Particpents_db/participents_db.dart';
import 'package:expense_tracker/db/Users_db/users_db.dart';
import 'package:expense_tracker/db/transaction_db/transaction_db.dart';
import 'package:expense_tracker/models/Participants/participants_model.dart';
import 'package:expense_tracker/models/categroy/category_model.dart';
import 'package:expense_tracker/models/transaction/transaction%20_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ParticipantAddFundScreen extends StatefulWidget {
  final String eventId;
  const ParticipantAddFundScreen({super.key, required this.eventId});

  @override
  State<ParticipantAddFundScreen> createState() =>
      _ParticipantAddFundScreenState();
}

class _ParticipantAddFundScreenState extends State<ParticipantAddFundScreen> {
  final formKey = GlobalKey<FormState>();
  final _amountController = TextEditingController();
  String? selectedCategoryId;
  CategoryModel? selectedCategoryModel;

  @override
  void initState() {
    CategoryDB.instance.refreshUI();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme;
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.only(
          right: 26.w,
          left: 26.w,
          top: 26.h,
          bottom: MediaQuery.of(context).viewInsets.bottom + 46.h,
        ),
        child: Form(
          key: formKey,

          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "Add Amount",
                style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 25.h),
              ValueListenableBuilder(
                valueListenable: CategoryDB.instance.incomeCategoryListListner,
                builder: (context, categoryList, _) {
                  final eventCategories = categoryList
                      .where((i) => i.eventId == widget.eventId)
                      .toList();
                  return DropdownButtonFormField<String>(
                    decoration: InputDecoration(border: InputBorder.none),
                    hint: Text(
                      "Select Payment Mode",
                      style: TextStyle(fontSize: 16.sp),
                    ),
                    items: eventCategories.map((e) {
                      return DropdownMenuItem<String>(
                        value: e.id,
                        onTap: () {
                          selectedCategoryModel = e;
                        },
                        child: Text(e.name),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        selectedCategoryId = value;
                      });
                    },
                    validator: (value) {
                      if (value == null) {
                        return "Please select a payment mode";
                      }
                      return null;
                    },
                  );
                },
              ),
              SizedBox(height: 12.h),
              CTextFromField(
                controller: _amountController,
                title: "Amount",
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return "Please Enter Amount";
                  }
                  final parsed = double.tryParse(value);
                  if (parsed == null || parsed <= 0) {
                    return "Enter an Amount Greater than Zero";
                  }
                  return null;
                },
              ),
              SizedBox(height: 17.h),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(
                    horizontal: 86.w,
                    vertical: 13.h,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadiusGeometry.circular(12.r),
                  ),
                  backgroundColor: color.primary,
                  foregroundColor: color.surface,
                ),
                onPressed: () async {
                  if (formKey.currentState!.validate()) {
                    final amount = _amountController.text;
                    final doubleAmount = double.tryParse(amount);
                    final currentUser =
                        UserDb.instance.activeUserNotifier.value;

                    if (currentUser == null) return;
                    final selectedEvent =
                        EventDb.instance.selectedEventNotifer.value;
                    if (selectedEvent == null) return;
                    final participant = ParticipantsModel(
                      participantName: currentUser.name,
                      paymentCategory: selectedCategoryModel!,
                      participantId: currentUser.id,
                      eventId: selectedEvent.id,
                      amountPaid: doubleAmount!,
                      joinedAt: DateTime.now(),
                    );
                    final participantTransaction = TransactionsModel(
                      name: participant.participantName,
                      amount: participant.amountPaid,
                      date: DateTime.now(),
                      type: CategoryType.income,
                      eventId: participant.eventId,
                      participantId: participant.participantId,
                    );
                    await ParticipantDb.instance.addParticipant(participant);
                    await TransactionDb.instance.addTransaction(
                      participantTransaction,
                    );
                    selectedEvent.collectedAmount += doubleAmount;
                    if (!selectedEvent.participants.contains(currentUser.id)) {
                      selectedEvent.participants.add(currentUser.id);
                    }
                    await EventDb.instance.updateEvent(selectedEvent);
                    Navigator.of(context).pop();
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          "successfully Added",
                          style: TextStyle(fontSize: 16.sp),
                        ),
                      ),
                    );
                  }
                },
                child: Text("Add", style: TextStyle(fontSize: 16.sp)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
