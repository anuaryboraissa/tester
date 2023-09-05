// import 'package:fl_chart/fl_chart.dart';
import 'package:erisiti/src/constants/styles/style.dart';
import 'package:erisiti/src/features/screens/dashboard/features/home/components/charts/linechart/model.dart';
import 'package:erisiti/src/features/screens/dashboard/features/home/components/charts/pichart/model.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class RecentReceiptDescription extends StatefulWidget {
  const RecentReceiptDescription({super.key});

  @override
  State<RecentReceiptDescription> createState() =>
      _RecentReceiptDescriptionState();
}

class _RecentReceiptDescriptionState extends State<RecentReceiptDescription> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      // margin: const EdgeInsets.only(top: 10),
      padding: const EdgeInsets.only(top: 15),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(20)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            "Expense Categories Breakdown",
            style:
                TextStyle(fontSize: 17, color: ApplicationStyles.realAppColor),
          ),
          const Text(
            "In July, 2023",
            style: TextStyle(fontSize: 15),
          ),
          AspectRatio(
              aspectRatio: 1,
              child: PieChart(
                  swapAnimationDuration:
                      const Duration(milliseconds: 150), // Optional
                  swapAnimationCurve: Curves.linear,
                  PieChartData(
                    sections: ModelHelper.chartSections(ModelHelper.data),
                    centerSpaceRadius: 65.0,
                  ))),
          const SizedBox(
            height: 10,
          ),
          ModelHelper.getDescription(size),
          const SizedBox(
            height: 15,
          ),
          const Text(
            "Monthly Spending Trends",
            style:
                TextStyle(fontSize: 17, color: ApplicationStyles.realAppColor),
          ),
          const SizedBox(
            height: 10,
          ),
          AspectRatio(
            aspectRatio: 1,
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: LineChartHelper.getLineChart(),
            ),
          )
        ],
      ),
    );
  }
}
