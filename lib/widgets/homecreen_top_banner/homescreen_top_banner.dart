import 'package:expense_tracker/theme/colors/color.dart';
import 'package:flutter/material.dart';

class HomescreenTopBanner extends StatelessWidget {
  final Color? color;
  const HomescreenTopBanner({super.key, this.color});

  @override
  Widget build(BuildContext context) {
    final double initialOffset=312*2;
    final ScrollController scrollController=ScrollController(initialScrollOffset: initialOffset);
    return SizedBox(
      height: 230,
      child: GridView.builder(
        controller: scrollController,
        scrollDirection: Axis.horizontal,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 1,
          mainAxisExtent: 330,

        ),

        itemBuilder: (context, index) {
          
          return Container(
            margin: EdgeInsets.all(10),
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
                                fontSize: 38,
                                fontWeight: FontWeight.w700,
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
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                              ),
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
