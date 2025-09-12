import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class PieChartScreen extends StatefulWidget {
 const PieChartScreen({super.key});

  @override
  State<PieChartScreen> createState() => _PieChartScreenState();
}

class _PieChartScreenState extends State<PieChartScreen> {
  final List<String> titles = ['food', 'grocery', 'petrol', 'bill'];

  final List<Color> colors = [
    const Color(0xFFADEBB3),
    const Color(0xFFFFD78E),
    const Color(0xFF89CFF0),
    const Color.fromARGB(255, 50, 50, 50),
  ];

  final List<double> values = [50, 30, 10, 10];
  int isSelectedIndex = -1;
  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme;

    return SizedBox(
      height: 450,
      child: Stack(
        alignment: Alignment.center,
        children: [
          PieChart(
            PieChartData(
              centerSpaceRadius: 120,
              sectionsSpace: 1,
              startDegreeOffset: 90,

              pieTouchData: PieTouchData(
              
                enabled: true,
                touchCallback: (event, response) {
                  if (!event.isInterestedForInteractions ||
                      response == null ||
                      response.touchedSection == null) {
                    setState(() {
                      isSelectedIndex = -1;
                    });
                    return;
                  }
                  setState(() {
                    isSelectedIndex =
                        response.touchedSection!.touchedSectionIndex;
                  });
                },
              ),
              titleSunbeamLayout: true,
              sections: List.generate(values.length, (index) {
                bool isSelected = index == isSelectedIndex;
                return PieChartSectionData(
                  title: titles[index],
                  titleStyle: TextStyle(
                    color: color.onSurface,
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                  color: colors[index],
                  value: values[index],
                  radius: isSelected ? 80 : 65,
                  // borderSide: BorderSide(color: Colors.black, width: 1),
                );
              }),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Total",style: TextStyle(color:  color.primary),),
              Text("₹45,000",style: TextStyle(color: color.onSurface,fontWeight: FontWeight.bold,fontSize: 40),),
            ],
          )
        ],
      ),
    );
  }
}
