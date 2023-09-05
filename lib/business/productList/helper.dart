// ignore: library_prefixes
import 'dart:convert';

import 'package:flutter/services.dart' as rootBundle;

class ProductHelper {
  static Future<List<dynamic>> getProducts() {
    return rootBundle.rootBundle
        .loadString('assets/jsonFiles/productList.json')
        .then((value) {
      return json.decode(value);
    });
  }
}
