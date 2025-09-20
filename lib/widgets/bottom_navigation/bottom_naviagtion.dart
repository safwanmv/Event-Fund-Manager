import 'package:expense_tracker/screens/Main%20Screen/main_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BottomNaviagtion extends StatelessWidget {
  const BottomNaviagtion({super.key});

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme;

    return ValueListenableBuilder(
      valueListenable: MainScreen.selectedIndexNotifer,
      builder: (BuildContext ctx, int updatedIndex, _) {
        return Padding(
          padding: EdgeInsets.only(bottom: 1.h),
          child: NavigationBar(
            backgroundColor: color.onSurfaceVariant,
            selectedIndex: updatedIndex,
            onDestinationSelected: (newIndex) {
              MainScreen.selectedIndexNotifer.value = newIndex;
            },
            destinations: [
              NavigationDestination(
                icon: Icon(Icons.pie_chart, color: color.primary, size: 24.r),
                label: "",
              ),
              NavigationDestination(
                icon: Icon(
                  Icons.desktop_windows,
                  color: color.primary,
                  size: 24.r,
                ),
                label: "",
              ),
              NavigationDestination(
                icon: Icon(Icons.credit_card, color: color.primary, size: 24.r),
                label: "",
              ),
              NavigationDestination(
                icon: Icon(
                  Icons.account_circle_outlined,
                  color: color.primary,
                  size: 24.r,
                ),
                label: "",
              ),
            ],
          ),
        );
      },
    );
  }
}
