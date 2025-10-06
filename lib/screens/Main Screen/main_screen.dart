import 'package:expense_tracker/screens/Main%20Screen/Analytics/analytics_screen.dart';
import 'package:expense_tracker/screens/Main%20Screen/Balance/balance_screen.dart';
import 'package:expense_tracker/screens/Main%20Screen/Events/event_participant_page.dart';
import 'package:expense_tracker/screens/Main%20Screen/Home/home_screen.dart';
import 'package:expense_tracker/screens/Main%20Screen/Profile/profile_screen.dart';
import 'package:expense_tracker/widgets/bottom_navigation/bottom_naviagtion.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});
  static ValueNotifier<int> selectedIndexNotifer = ValueNotifier(2);
  final _pages = const [
    AnalyticsScreen(),
    BalanceScreen(),
    HomeScreen(),
    EventParticipantPage(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme;
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 8.0, left: 8, right: 8),
        child: Container(
          decoration: BoxDecoration(
            color: color.surface,

            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(40.r),
              bottomRight: Radius.circular(40.r),
            ),
          ),

          child: ValueListenableBuilder(
            valueListenable: selectedIndexNotifer,
            builder: (BuildContext ctx, int updatedIndex, _) {
              return IndexedStack(index: updatedIndex, children: _pages);
            },
          ),
        ),
      ),

      bottomNavigationBar: const BottomNaviagtion(),
    );
  }
}

//
//completed:-analythics screen drop down and new screen when we tap the event from the event list and go to that page and 
//
//completed:-filtering search
//completed:-.we can add money 


//3.participated events
//4.single transaction list for all the income
//5.pie chart make dynamic with particepnets also 
//6.make two screen one for created events and other for participated events
//7.make not visible when user is not create an event
//8.profile ui changes
//9.check everything
//10. connect to firebase