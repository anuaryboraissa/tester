import 'package:erisiti/src/constants/styles/style.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class LineChartModel {
  static final List<Map<String, dynamic>> distribution = [
    {"y": 89.6, "x": 0.0},
    {"y": 27.4, "x": 1.0},
    {"y": 46.9, "x": 2.0},
    {"y": 39.9, "x": 3.0},
    {"y": 29.2, "x": 4.0},
    {"y": 59.8, "x": 5.0},
    {"y": 28.4, "x": 6.0},
    {"y": 84.2, "x": 7.0},
    {"y": 64.6, "x": 8.0},
    {"y": 59.7, "x": 9.0},
    {"y": 35.0, "x": 10.0},
    {"y": 45.3, "x": 11.0}
  ];
  static final List<int> sideValues = [0, 20, 40, 60, 80, 100];
  static final List<String> bottomTitles = [
    "Jan",
    "Feb",
    "Mar",
    "Apr",
    "May",
    "Jun",
    "Jul",
    "Aug",
    "Sept",
    "Oct",
    "Nov",
    "Dec"
  ];
}

class LineChartHelper {
  static Widget getLineChart() {
    return LineChart(LineChartData(
      lineBarsData: [
        LineChartBarData(
            spots: LineChartModel.distribution
                .map((point) => FlSpot(point['x'], point['y']))
                .toList(),
            isCurved: false,
            dotData: const FlDotData(
              show: false,
            ),
            color: Colors.red),
      ],
      borderData: FlBorderData(
          border: const Border(bottom: BorderSide(), left: BorderSide())),
      gridData: const FlGridData(show: false),
      titlesData: FlTitlesData(
        bottomTitles: AxisTitles(sideTitles: _bottomTitles),
        leftTitles: AxisTitles(sideTitles: _leftTitles),
        topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
        rightTitles:
            const AxisTitles(sideTitles: SideTitles(showTitles: false)),
      ),
      lineTouchData: LineTouchData(
          enabled: true,
          touchCallback:
              (FlTouchEvent event, LineTouchResponse? touchResponse) {},
          touchTooltipData: LineTouchTooltipData(
            tooltipBgColor: ApplicationStyles.realAppColor,
            tooltipRoundedRadius: 20.0,
            showOnTopOfTheChartBoxArea: true,
            fitInsideHorizontally: true,
            tooltipMargin: 0,
            getTooltipItems: (touchedSpots) {
              return touchedSpots.map(
                (LineBarSpot touchedSpot) {
                  const textStyle = TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  );
                  return LineTooltipItem(
                    LineChartModel.distribution[touchedSpot.spotIndex]['y']
                        .toStringAsFixed(2),
                    textStyle,
                  );
                },
              ).toList();
            },
          ),
          getTouchedSpotIndicator:
              (LineChartBarData barData, List<int> indicators) {
            return indicators.map(
              (int index) {
                const line = FlLine(
                    color: Colors.grey, strokeWidth: 1, dashArray: [2, 4]);
                return const TouchedSpotIndicatorData(
                  line,
                  FlDotData(show: false),
                );
              },
            ).toList();
          },
          getTouchLineEnd: (_, __) => double.infinity),
    ));
  }

  static SideTitles get _bottomTitles => SideTitles(
      showTitles: true,
      getTitlesWidget: (value, meta) {
        String text = '';
        switch (value.toInt()) {
          case 0:
            text = 'Jan';
            break;
          case 1:
            text = 'Feb';
            break;
          case 2:
            text = 'Mar';
            break;
          case 3:
            text = 'Apr';
            break;
          case 4:
            text = 'May';
            break;
          case 5:
            text = 'Jun';
            break;

          case 6:
            text = 'Jul';
            break;
          case 7:
            text = 'Aug';
            break;
          case 8:
            text = 'Sept';
            break;
          case 9:
            text = 'Oct';
            break;
          case 10:
            text = 'Nov';
            break;
          case 11:
            text = 'Dec';
            break;
        }
        return Text(
          text,
          style: const TextStyle(fontSize: 10),
        );
      });
  static SideTitles get _leftTitles => SideTitles(
      showTitles: true,
      getTitlesWidget: (value, meta) {
        String text = '';
        switch (value.toInt()) {
          case 0:
            text = '0';
            break;
          case 10:
            text = '10';
            break;
          case 20:
            text = '20';
            break;
          case 30:
            text = '30';
            break;
          case 40:
            text = '40';
            break;
          case 50:
            text = '50';
            break;
          case 60:
            text = '60';
            break;
          case 70:
            text = '70';
            break;
          case 80:
            text = '80';
            break;
          case 90:
            text = '90';
            break;
          case 100:
            text = '100';
            break;
        }
        return Text(
          text,
          style: const TextStyle(fontSize: 12),
        );
      });
}
