import 'dart:async';
import 'dart:developer';

import 'package:expense_tracker/CustomWidgets/c_text_form_field.dart';
import 'package:expense_tracker/constants/text_messages.dart';
import 'package:expense_tracker/db/Event_db/event_db.dart';
import 'package:expense_tracker/db/transaction_db/transaction_db.dart';
import 'package:expense_tracker/models/Events/event_model.dart';
import 'package:expense_tracker/screens/Main%20Screen/Events/participent/participent_event_page_details.dart';
import 'package:expense_tracker/screens/Main%20Screen/Home/eventAddBottomSheet.dart';
import 'package:expense_tracker/screens/chart/bar_chart_screen.dart';
import 'package:expense_tracker/widgets/Empty_data/text_message_widget.dart';
import 'package:expense_tracker/widgets/homcreen_top_banner/homescreen_top_banner.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late List<EventModel> _allEvents;
  Timer? _debounce;

  @override
  void initState() {
    super.initState();

    TransactionDb.instance.refreshUI();
    EventDb.instance.refreshUI();
    _allEvents = EventDb.instance.getAllEvents();
    EventDb.instance.filteredEventsNotifer.value = _allEvents;
  }

  @override
  void dispose() {
    _debounce?.cancel();
    _searchController.dispose();
    super.dispose();
  }

  final _searchController = TextEditingController();
  bool _isSearching = false;

  @override
  Widget build(BuildContext context) {
    final focusNode = FocusNode();
    final color = Theme.of(context).colorScheme;
    final screenWidth = MediaQuery.of(context).size.width;

    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                    width: _isSearching
                        ? screenWidth - 52.w
                        : screenWidth * 0.55.r,
                    child: CTextFromField(
                      // focusNode: focusNode,
                      controller: _searchController,
                      title: "Search the Event",
                      validator: (value) {
                        return null;
                      },
                      prefixIcon: const Icon(Icons.search),
                      suffixIcon: _isSearching
                          ? IconButton(
                              icon: const Icon(Icons.close),

                              onPressed: () {
                                setState(() {
                                  _isSearching = false;
                                  _searchController.clear();
                                  EventDb.instance.filteredEventsNotifer.value =
                                      EventDb.instance.getAllEvents();
                                });
                              },
                            )
                          : null,
                      textInputAction: TextInputAction.search,

                      onTap: () {
                        setState(() {
                          _isSearching = true;
                        });
                        FocusScope.of(context).requestFocus(focusNode);
                      },
                      onFieldSubmitted: (value) {
                        FocusScope.of(context).unfocus();
                        setState(() {
                          _isSearching = true;
                        });
                        EventDb.instance.searchEvents(value.trim());
                      },
                      // onChanged: (value) {
                      //   if (_debounce?.isActive ?? false) _debounce!.cancel();
                      //   _debounce = Timer(
                      //     const Duration(milliseconds: 200),
                      //     () {
                      //       EventDb.instance.searchEvents(value.trim());
                      //     },
                      //   );
                      // },
                    ),
                  ),
                ),
                SizedBox(width: 10.w),

                AnimatedSwitcher(
                  duration: const Duration(milliseconds: 300),
                  child: _isSearching
                      ? const SizedBox.shrink()
                      : GestureDetector(
                          onTap: () {
                            log("message");
                            showModalBottomSheet(
                              context: context,
                              isScrollControlled: true,
                              builder: (context) => Eventaddbottomsheet(),
                            );
                            Eventaddbottomsheet();
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(
                              vertical: 13.h,
                              horizontal: 12.h,
                            ),
                            decoration: BoxDecoration(
                              color: color.onSurfaceVariant,
                              borderRadius: BorderRadius.circular(18.r),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Icon(Icons.add),
                                Text(
                                  " Create Events",
                                  style: TextStyle(
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                ),
              ],
            ),
            SizedBox(height: 10.h),
            _isSearching == true && _searchController.text.trim().length == 8
                ? ValueListenableBuilder<List<EventModel>>(
                    valueListenable: EventDb.instance.filteredEventsNotifer,
                    builder: (context, events, _) {
                      if (_searchController.text.isEmpty) {
                        return SizedBox();
                      }
                      if (_searchController.text.isNotEmpty && events.isEmpty) {
                        return const Center(
                          child: EmptyDataContainer(
                            text: TextMessages.noEvents,
                          ),
                        );
                      }
                      if (events.isEmpty) {
                        return Center(
                          child: EmptyDataContainer(
                            text: TextMessages.noEvents,
                          ),
                        );
                      }
                      return ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: events.length,
                        itemBuilder: (context, index) {
                          final event = events[index];
                          return InkWell(
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(builder: (context)=>ParticipentEventPageDetails(selectedEvent: event,)));
                            },
                            child: Card(
                              child: ListTile(
                                textColor: color.onSurface,
                                title: Text(event.title,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16.sp),),
                                subtitle: Text(event.description,maxLines: 1,overflow: TextOverflow.ellipsis,),
                                trailing: Text(event.joinCode),
                              ),
                            ),
                          );
                        },
                      );
                    },
                  )
                : SizedBox(height: 10.h),

            ValueListenableBuilder(
              valueListenable: EventDb.instance.selectedEventNotifer,
              builder: (context, selectedEvent, child) {
                return HomescreenTopBanner(selectedEvent: selectedEvent);
              },
            ),

            ValueListenableBuilder(
              valueListenable: EventDb.instance.eventListNotifer,
              builder: (context, eventList, child) {
                return eventList.isEmpty
                    ? EmptyDataContainer(text: TextMessages.noEvents)
                    : ValueListenableBuilder(
                        valueListenable: EventDb.instance.selectedEventNotifer,
                        builder: (context, selectedEvent, _) {
                          return ValueListenableBuilder(
                            valueListenable:
                                TransactionDb.instance.transactionListNotifer,

                            builder: (context, transactionList, _) {
                              return transactionList.isEmpty
                                  ? EmptyDataContainer(
                                      text: TextMessages.noTransaction,
                                    )
                                  : Padding(
                                      padding: EdgeInsets.only(left: 22.w),

                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          // SizedBox(height: 20.h),
                                          // Text(
                                          //   "User in The Last Week,",
                                          //   style: TextStyle(
                                          //     fontWeight: FontWeight.bold,
                                          //     fontSize: 16.sp,
                                          //   ),
                                          // ),
                                          // Text(
                                          //   "+2.1%",
                                          //   style: TextStyle(
                                          //     fontSize: 40.h,
                                          //     fontWeight: FontWeight.w900,
                                          //   ),
                                          // ),
                                          SizedBox(height: 50.h),
                                          BarChartScreen(
                                            selectedEvent: selectedEvent,
                                          ),
                                        ],
                                      ),
                                    );
                            },
                          );
                        },
                      );
              },
            ),
          ],
        ),
      ),
    );
  }
}
