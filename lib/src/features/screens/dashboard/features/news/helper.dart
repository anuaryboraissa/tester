import 'dart:convert';

import 'package:erisiti/src/constants/assets.dart';
import 'package:flutter/services.dart';

class NewsSample {
  Future<List> readJsonFile() async {
    var input = await loadAsset();
    List map = jsonDecode(input)['results'];

    return map;
  }

  Future<String> loadAsset() async {
    return await rootBundle.loadString('assets/Sample_Report.json');
  }

  static List<String> images = [
    ApplicationAssets.mosque,
    ApplicationAssets.river,
    ApplicationAssets.river2,
    ApplicationAssets.rock,
    ApplicationAssets.rock2
  ];
}
