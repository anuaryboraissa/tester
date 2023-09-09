// ignore_for_file: library_prefixes

import 'dart:convert';
import 'package:erisiti/business/productList/productList.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' as rootBundle;

import '../../productList/widgets.dart/searchWidget.dart';
import 'businessWidget.dart';

class UserBusinessListWidget extends StatefulWidget {
  const UserBusinessListWidget({
    super.key,
  });

  @override
  State<UserBusinessListWidget> createState() => _UserBusinessListWidgetState();
}

class _UserBusinessListWidgetState extends State<UserBusinessListWidget> {
  String businessName = "";
  @override
  void initState() {
    readJSON();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return businessInfo.isEmpty
        ? const Center(
            child: CircularProgressIndicator(),
          )
        : Column(
            children: [
              SearchWidget(
                hintText: "Search Business",
                result: (String query) {
                  setState(() {
                    if (query.isNotEmpty) {
                      searching = true;
                      this.businessName = query;
                    } else {
                      searching = false;
                      this.businessName = "";
                    }
                  });
                },
              ),
              Expanded(
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: searching
                      ? searchBusiness(businessName).length
                      : businessInfo.length,
                  itemBuilder: (context, index) {
                    final businesses = searching
                        ? searchBusiness(businessName)[index]
                        : businessInfo[index];
                    return InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ProductList(
                                    businessName: businesses['businessName']
                                        .toString())));
                      },
                      child: BusinessWidget(
                          businessName: "${businesses['businessName']}",
                          brelaNo: "${businesses['businessBRELA']}"),
                    );
                  },
                ),
              ),
            ],
          );
  }

  List<dynamic> businessInfo = [];
  Future<void> readJSON() async {
    final String theFileWithJSONData = await rootBundle.rootBundle
        .loadString('assets/jsonFiles/userRegisteredBusiness.json');
    final capturedJSONData = await json.decode(theFileWithJSONData);
    setState(() {
      businessInfo = capturedJSONData;
    });
  }

  bool searching = false;
  List<dynamic> searchBusiness(String businessName) {
    return businessInfo
        .where((element) => element['businessName']
            .toString()
            .toLowerCase()
            .contains(businessName.toLowerCase()))
        .toList();
  }
}
