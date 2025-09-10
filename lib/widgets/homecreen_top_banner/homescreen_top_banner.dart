import 'package:expense_tracker/theme/colors/color.dart';
import 'package:flutter/material.dart';

class HomescreenTopBanner extends StatelessWidget {
  final Color? color;
  const HomescreenTopBanner({super.key, this.color});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 250,
      child: PageView.builder(
        itemBuilder: (context, index) {
          return Container(
            margin: EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: topBannerColors[index],
              borderRadius: BorderRadius.circular(35),
            ),
            height: 80,
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Salary",
                              style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            Text(
                              "₹45,000",
                              style: TextStyle(
                                fontSize: 30,
                                fontWeight: FontWeight.bold,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              "Deposit",
                              style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            Text(
                              '01-03-2025',
                              style: TextStyle(fontWeight: FontWeight.bold,fontSize: 30),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
        itemCount: 4,
      ),
    );
  }
}
