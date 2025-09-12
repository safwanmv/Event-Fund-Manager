import 'package:expense_tracker/screens/Main%20Screen/Balance/transaction_list.dart';
import 'package:flutter/material.dart';

class BalanceScreen extends StatelessWidget {
  const BalanceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: SafeArea(
        child: Column(
          children: [
            Row(
              spacing: 20,
              children: [
                Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadiusGeometry.circular(29),
                  ),
                  child: Column(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: const Color(0xFF89CFF0),
                          borderRadius: BorderRadiusGeometry.vertical(
                            top: Radius.circular(29),
                          ),
                        ),
                        constraints: const BoxConstraints(minHeight: 100),
                        padding: const EdgeInsets.all(16), // Add padding
                        // color:const Color(0xFF89CFF0),
                        width: 220,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Mohammed Safwan.MV",
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 14,
                              ),
                            ),
                            Row(
                              spacing: 50,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  maskCardNumber("102034324"),
                                  style: TextStyle(color: Colors.black),
                                ),
                                Text(
                                  "11/25",
                                  style: TextStyle(color: Colors.black),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.all(16), // Add padding

                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Balance",
                              style: TextStyle(color: Colors.white),
                            ),
                            Text(
                              "₹45,000",
                              style: TextStyle(
                                fontSize: 40,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Row(
                              children: [
                                Text(
                                  "Total week Expense      23.3%",
                                  style: TextStyle(color: color.primary),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                OutlinedButton(
                  onPressed: () {},
                  style: OutlinedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadiusGeometry.circular(20),
                    ),
                    padding: EdgeInsets.all(25),
                  ),
                  child: Icon(Icons.add),
                ),
              ],
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Transactions", style: TextStyle(fontSize: 16)),
                Text("Analytics", style: TextStyle(color: color.primary)),
              ],
            ),
            SizedBox(height: 10),
            Expanded(child: TransactionList()),
          ],
        ),
      ),
    );
  }

  String maskCardNumber(String number) {
    String lastFour = number.substring(number.length - 4);
    return "**** $lastFour";
  }
}
