import 'package:expense_tracker/chart/bar_chart_screen.dart';
import 'package:expense_tracker/screens/Main%20Screen/Balance/transaction_list.dart';
import 'package:expense_tracker/widgets/homecreen_top_banner/homescreen_top_banner.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String? selectedValue;
  final List<String> items = ["Every 2 Hours", "Every 12 Hours", "24 Hours"];
  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme;
    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          HomescreenTopBanner(),
          Padding(
            padding: const EdgeInsets.only(left: 22),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "User in The Last Week,",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(
                  "+2,1%",
                  style: TextStyle(fontSize: 40, fontWeight: FontWeight.w900),
                ),
              ],
            ),
          ),
          SizedBox(height: 10),
          BarChartScreen(),

          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 22.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Last Orders",
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      DropdownMenu(
                        initialSelection: "Every 2 Hours",
                        textStyle: TextStyle(
                          fontSize: 16,
                          color: color.primary,
                        ),

                        width: 180, // 👈 keeps dropdown popup same width
                        onSelected: (value) {
                          setState(() {
                            selectedValue = value.toString();
                          });
                        },
                        dropdownMenuEntries: items.map((item) {
                          return DropdownMenuEntry(value: item, label: item);
                        }).toList(),
                        menuStyle: MenuStyle(
                          minimumSize: WidgetStatePropertyAll(Size(8, 9)),
                          padding: WidgetStatePropertyAll(
                            EdgeInsetsGeometry.symmetric(horizontal: 2),
                          ),
                          maximumSize: WidgetStatePropertyAll(
                            Size.fromWidth(double.infinity),
                          ),
                          shape: WidgetStatePropertyAll(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                        inputDecorationTheme: const InputDecorationTheme(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(12)),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  Expanded(child: TransactionList()),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

//analathyics //home //balance // transactions
