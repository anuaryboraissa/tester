import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class Model {
  final String title;
  final double value;
  final Color color;

  Model({required this.title, required this.value, required this.color});
}

class ModelHelper {
  static final List<Model> data = [
    Model(title: "Groceries", value: 20000, color: Colors.green),
    Model(title: "Dining Out", value: 16000, color: Colors.red),
    Model(title: "Transportation", value: 18000, color: Colors.pink),
    Model(title: "Entertainment", value: 23000, color: Colors.blue),
    Model(title: "Utilities", value: 21000, color: Colors.black),
    Model(title: "Other", value: 11000, color: Colors.yellow),
  ]..sort((a, b) => b.value.compareTo(a.value));

  static double calculatePercent(List<Model> data, double item) {
    // double percent = item / (data.map((e) => null).toList());
    double sum = 0;
    for (var i = 0; i < data.length; i++) {
      sum += data[i].value;
    }
    return (item / sum) * 100;
  }

  static List<PieChartSectionData> chartSections(List<Model> sectors) {
    final List<PieChartSectionData> list = [];
    for (var sector in sectors) {
      const double radius = 65.0;
      final data = PieChartSectionData(
          color: sector.color,
          value: calculatePercent(sectors, sector.value),
          radius: radius,
          title: "",
          titleStyle: const TextStyle(color: Colors.white, fontSize: 10));
      list.add(data);
    }
    return list;
  }

  static List<Color> modelColors() {
    return data.map((e) => e.color).toList();
  }

  static List<String> modelTitles() {
    return data.map((e) => e.title).toList();
  }

  static List<double> modelValues() {
    return data.map((e) => calculatePercent(data, e.value)).toList();
  }

  static Widget getDescription(Size size) {
    return chartDescription(modelColors(), modelTitles(), modelValues(), size);
  }

  static Widget chartDescription(List<Color> colors, List<String> titles,
      List<double> percents, Size size) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            avatar(colors[0]),
            SizedBox(
              height: size.height * .007,
            ),
            avatar(colors[1]),
            SizedBox(
              height: size.height * .007,
            ),
            avatar(colors[2]),
            SizedBox(
              height: size.height * .007,
            ),
            avatar(colors[3]),
            SizedBox(
              height: size.height * .007,
            ),
            avatar(colors[4]),
            SizedBox(
              height: size.height * .007,
            ),
            avatar(colors[5]),
          ],
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(titles[0]),
            SizedBox(
              height: size.height * .004,
            ),
            Text(titles[1]),
            SizedBox(
              height: size.height * .004,
            ),
            Text(titles[2]),
            SizedBox(
              height: size.height * .004,
            ),
            Text(titles[3]),
            SizedBox(
              height: size.height * .004,
            ),
            Text(titles[4]),
            SizedBox(
              height: size.height * .004,
            ),
            Text(titles[5]),
            SizedBox(
              height: size.height * .004,
            ),
          ],
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("${percents[0].toStringAsFixed(2)} %"),
            SizedBox(
              height: size.height * .004,
            ),
            Text("${percents[1].toStringAsFixed(2)} %"),
            SizedBox(
              height: size.height * .004,
            ),
            Text("${percents[2].toStringAsFixed(2)} %"),
            SizedBox(
              height: size.height * .004,
            ),
            Text("${percents[3].toStringAsFixed(2)} %"),
            SizedBox(
              height: size.height * .004,
            ),
            Text("${percents[4].toStringAsFixed(2)} %"),
            SizedBox(
              height: size.height * .004,
            ),
            Text("${percents[5].toStringAsFixed(2)} %"),
          ],
        ),
      ],
    );
  }

  static Widget avatar(Color color) {
    return CircleAvatar(backgroundColor: color, radius: 7);
  }
}
