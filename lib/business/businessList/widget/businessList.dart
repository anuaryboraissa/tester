// ignore_for_file: library_prefixes

import 'dart:convert';
import 'package:erisiti/business/productList/productList.dart';
import 'package:erisiti/src/constants/styles/style.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' as rootBundle;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../../src/features/screens/dashboard/Business/items/bloc/register_service_bloc.dart';
import '../../productList/widgets.dart/searchWidget.dart';
import 'businessWidget.dart';

class UserBusinessListWidget extends StatefulWidget {
  const UserBusinessListWidget({
    super.key,
    required this.tinNumber,
  });
  final String tinNumber;
  @override
  State<UserBusinessListWidget> createState() => _UserBusinessListWidgetState();
}

class _UserBusinessListWidgetState extends State<UserBusinessListWidget> {
  String businessName = "";
  @override
  void initState() {
    // readJSON();
    bloc.add(FindBusinessEvent(widget.tinNumber));
    super.initState();
  }

  RegisterServiceBloc bloc = RegisterServiceBloc();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RegisterServiceBloc, RegisterServiceState>(
      bloc: bloc,
      listener: (context, state) {
        if (state is BusinessByTinState) {
          businessInfo = state.businesses;
          if (state.error) {
            Fluttertoast.showToast(msg: state.message);
          }
        }
      },
      builder: (context, state) {
        return businessInfo == null
            ? const Center(
                child: CircularProgressIndicator(
                  color: ApplicationStyles.realAppColor,
                ),
              )
            : businessInfo!.isEmpty
                ? const Center(
                    child: Text("No data is Available"),
                  )
                : Column(
                    children: [
                      SearchWidget(
                        hintText: "Search Business",
                        result: (String query) {
                          setState(() {
                            if (query.isNotEmpty) {
                              searching = true;
                              businessName = query;
                            } else {
                              searching = false;
                              businessName = "";
                            }
                          });
                        },
                      ),
                      Expanded(
                        child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: searching
                              ? searchBusiness(businessName).length
                              : businessInfo!.length,
                          itemBuilder: (context, index) {
                            final businesses = searching
                                ? searchBusiness(businessName)[index]
                                : businessInfo![index];
                            return InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => ProductList(
                                              businessName:
                                                  businesses['businessName']
                                                      .toString(),
                                              businessRegNumber: businesses[
                                                  'businessRegistrationNumber'],
                                              businessId: businesses['id'],
                                            )));
                              },
                              child: BusinessWidget(
                                  businessName: "${businesses['businessName']}",
                                  brelaNo:
                                      "${businesses['businessRegistrationNumber']}"),
                            );
                          },
                        ),
                      )
                    ],
                  );
      },
    );
  }

  List<dynamic>? businessInfo;
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
    return businessInfo!
        .where((element) => element['businessName']
            .toString()
            .toLowerCase()
            .contains(businessName.toLowerCase()))
        .toList();
  }
}
