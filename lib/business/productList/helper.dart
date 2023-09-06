// ignore: library_prefixes
import 'dart:convert';

// ignore: library_prefixes
import 'package:flutter/services.dart' as rootBundle;

class ProductHelper {
  static Future<List<dynamic>> getProducts() {
    return rootBundle.rootBundle
        .loadString('assets/jsonFiles/userRegisteredBusiness.json')
        .then((value) {
      return json.decode(value);
    });
  }
}
