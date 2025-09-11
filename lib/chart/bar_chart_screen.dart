import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class BarChartScreen extends StatelessWidget {
  const BarChartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme;

    return SizedBox(
      height: 200,
      child: BarChart(
        BarChartData(
          maxY: 50, //here we can set the limit
          gridData: FlGridData(show: false),
          barTouchData: BarTouchData(
            touchTooltipData: BarTouchTooltipData(

              getTooltipColor: (group) =>
                  color.onSurface,
              getTooltipItem: (group, groupIndex, rod, rodIndex) =>
                  BarTooltipItem(
                    "37.452",
                    TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                    
                  ),
                  tooltipBorder: BorderSide(color: Colors.white),
                  tooltipPadding: EdgeInsets.all(8),
                  tooltipRoundedRadius:10 ,
                  tooltipHorizontalAlignment: FLHorizontalAlignment.left,
                  
                  
            ),
            
          ),
          borderData: FlBorderData(show: false),
          titlesData: FlTitlesData(
            rightTitles: AxisTitles(),
            topTitles: AxisTitles(),
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                reservedSize: 30,
                getTitlesWidget: (value, meta) {
                  String title = '';
                  switch (value.toInt()) {
                    case 0:
                      title = "Mon";
                      break;
                    case 1:
                      title = "Tue";
                      break;
                    case 2:
                      title = "Wed";
                      break;
                    case 3:
                      title = "Thu";
                      break;
                    case 4:
                      title = "Fri";
                      break;
                    case 5:
                      title = "Sat";
                      break;
                    case 6:
                      title = "Sun";
                      break;
                  }
                  return Text(
                    title,
                    style: TextStyle(
                      color: color.primary,
                      fontSize: 12,
                      fontWeight: FontWeight.w300,
                    ),
                  );
                },
              ),
            ),
          ),
          barGroups: List.generate(
            7,
            (index) => BarChartGroupData(
              x: index,

              barRods: [
                BarChartRodData(
                  toY: 40,
                  width: 22,
                  borderRadius: BorderRadius.circular(8),
                  color: color.primary,
                  backDrawRodData: BackgroundBarChartRodData(
                    color: color.onSurfaceVariant,
                    show: true,
                    toY: 50,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
    // return Text("data");
  }
}
