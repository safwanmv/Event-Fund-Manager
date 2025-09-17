import 'package:expense_tracker/screens/Main%20Screen/Analytics/analytics_screen.dart';
import 'package:expense_tracker/screens/Main%20Screen/Balance/balance_screen.dart';
import 'package:expense_tracker/screens/Main%20Screen/Home/home_screen.dart';
import 'package:expense_tracker/screens/Main%20Screen/Profile/profile_screen.dart';
import 'package:expense_tracker/widgets/homecreen_top_banner/bottom_naviagtion.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});
  static ValueNotifier<int> selectedIndexNotifer = ValueNotifier(1);
  final _pages = const [
    AnalyticsScreen(),
    HomeScreen(),
    BalanceScreen(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme;
    return SafeArea(
      bottom: false,
      child: Scaffold(
        backgroundColor: color.onSurfaceVariant,
        body: Container(
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
      
        bottomNavigationBar: const BottomNaviagtion(),
      ),
    );
  }
}
