// import 'package:expense_tracker/main.dart';
import 'package:expense_tracker/screens/Main%20Screen/main_screen.dart';
import 'package:flutter/material.dart';

class BottomNaviagtion extends StatelessWidget {
  const BottomNaviagtion({super.key});

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme;
    // final colorScheme = Theme.of(context).colorScheme;
    // final backgroundColor = colorScheme.surface;
    // print("BottomNavigation background = $backgroundColor");

    return ValueListenableBuilder(
      valueListenable: MainScreen.selectedIndexNotifer,
      builder: (BuildContext ctx, int updatedIndex, _) {
        return NavigationBar(
          backgroundColor:color.onSurfaceVariant,
          // indicatorColor: color.onSurface,
          // indicatorColor: const Color.fromARGB(198, 255, 255, 255),
          selectedIndex: updatedIndex,
          onDestinationSelected: (newIndex) {
            MainScreen.selectedIndexNotifer.value = newIndex;
          },
          // type: BottomNavigationBarType.fixed,
          // selectedItemColor: Colors.lightBlue,
          // unselectedItemColor: Colors.green, 
          destinations: [
            NavigationDestination(
              icon: Icon(Icons.pie_chart,color: color.primary,),
              label: "",
            ),
            NavigationDestination(icon: Icon(Icons.desktop_windows,color: color.primary,), label: ""),
            NavigationDestination(icon: Icon(Icons.credit_card,color: color.primary,), label: ""),
            NavigationDestination(icon: Icon(Icons.account_circle_outlined ,color: color.primary,), label: ""),
            // NavigationDestination(
            //   icon: Icon(isLight ? Icons.light_mode : Icons.dark_mode),
            //   label: "",
            // ),w
          ],
        );
      },
    );
  }
}
