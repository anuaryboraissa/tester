import 'package:erisiti/src/constants/data/brela.dart';
import 'package:erisiti/src/features/screens/dashboard/Business/RegisterBusiness/components/business_page.dart';
import 'package:erisiti/src/features/screens/dashboard/Business/RegisterBusiness/components/top_bar.dart';
import 'package:erisiti/src/features/screens/dashboard/Business/items/businesses.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../../../../constants/styles/style.dart';

class RegisterBusiness extends StatefulWidget {
  const RegisterBusiness({super.key, required this.tinNumber});
  final String tinNumber;
  @override
  State<RegisterBusiness> createState() => _RegisterBusinessState();
}

class _RegisterBusinessState extends State<RegisterBusiness> {
  bool addBusiness = true;

  List<Map<String, dynamic>> businesses = [];
  String businessName = "";
  String businessType = "";
  String businessRegistrationNumber = "";
  String businessTerms = "";

  List<Map<String, dynamic>> brelaBusinesses = [];

  @override
  void initState() {
    setState(() {
      brelaBusinesses = brela;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // print("length ${businesses.length}");
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const BusinessTopBar(
                image: 'assets/images/business.png',
                title: "Business",
                subTitle: 'Register to continue',
              ),
              contentHolder(),
              if (addBusiness)
                RegisterBody(
                  businessName: (String businessName) {
                    this.businessName = businessName;
                  },
                  businessTerms: (String terms) {
                    businessTerms = terms;
                  },
                  businessType: (String type) {
                    businessType = type;
                  },
                  registrationNumber: (String businessRegNumber) {
                    businessRegistrationNumber = businessRegNumber;
                  },
                )
            ],
          ),
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.all(10),
          child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.all(15),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  backgroundColor: ApplicationStyles.realAppColor),
              onPressed: addBusiness || businesses.isEmpty
                  ? null
                  : () {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => RegisteredBusiness(
                          businesses: businesses,
                        ),
                      ));
                    },
              child: const Text("Continue")),
        ),
        floatingActionButton: Align(
          alignment: Alignment.bottomRight,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              if (addBusiness)
                FloatingActionButton(
                  backgroundColor: ApplicationStyles.realAppColor,
                  onPressed: () {
                    setState(() {
                      addBusiness = !addBusiness;
                    });
                  },
                  child: const Icon(Icons.close, color: Colors.red),
                ),
              const SizedBox(
                height: 5,
              ),
              FloatingActionButton(
                backgroundColor: ApplicationStyles.realAppColor,
                onPressed: () {
                  setState(() {
                    if (addBusiness) {
                      if (businessType.isEmpty) {
                        Fluttertoast.showToast(
                            msg: "Business Type is required");
                      } else if (businessName.isEmpty) {
                        Fluttertoast.showToast(
                            msg: "Business Name is required");
                      } else if (businessRegistrationNumber.isEmpty) {
                        Fluttertoast.showToast(
                            msg: "Business Registration Number is required");
                      } else if (businessRegistrationNumber.contains(".") ||
                          businessRegistrationNumber.contains(",") ||
                          // isInteger(int.parse(businessRegistrationNumber)) ||
                          businessRegistrationNumber.length != 6) {
                        Fluttertoast.showToast(
                            msg: "Business Registration Number is not valid");
                      } else {
                        List<Map<String, dynamic>> brelaBusiness =
                            brelaBusinesses
                                .where((element) =>
                                    element['businessRegNumber'] ==
                                        businessRegistrationNumber &&
                                    element['tinNumber'] == widget.tinNumber)
                                .toList();

                        if (brelaBusiness.isNotEmpty) {
                          Map<String, dynamic> business = {
                            "name": businessName,
                            "type": businessType,
                            "registrationNumber": businessRegistrationNumber,
                            "terms": businessTerms,
                            "id": businesses.length + 1,
                            "region": brelaBusiness.single['address']['region'],
                            "district": brelaBusiness.single['address']
                                ['district']
                          };
                          businesses.add(business);
                          businessName = "";
                          addBusiness = !addBusiness;
                        } else {
                          Fluttertoast.showToast(
                              msg: "Your Business is not registered");
                          Fluttertoast.showToast(
                              msg: "Please Contact Brela For more information");
                        }
                      }
                    } else {
                      addBusiness = !addBusiness;
                    }
                  });
                },
                child: Icon(
                  addBusiness ? Icons.check : Icons.add,
                  size: 20,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget contentHolder() {
    return Container(
        padding: const EdgeInsets.only(left: 15, right: 15),
        width: double.infinity,
        height: businesses.isEmpty ? 0 : 60,
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(10)),
        child: ListView.builder(
          padding: const EdgeInsets.all(5),
          scrollDirection: Axis.horizontal,
          itemCount: businesses.length,
          itemBuilder: (BuildContext context, int index) {
            return businessCard(businesses[index]['name'],
                businesses[index]['registrationNumber']);
          },
        ));
  }

  Widget businessCard(String business, String regNumber) {
    return Container(
      margin: const EdgeInsets.only(right: 5),
      padding: const EdgeInsets.only(top: 5, bottom: 5, left: 5),
      decoration: BoxDecoration(
        border: Border.all(),
        borderRadius: BorderRadius.circular(20),
        // color: ApplicationStyles.realAppColor
      ),
      child: Center(
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                business,
                style: const TextStyle(overflow: TextOverflow.ellipsis),
              ),
            ),
            IconButton(
                onPressed: () {
                  setState(() {
                    businesses.remove(businesses
                        .where((element) =>
                            element['registrationNumber'] == regNumber)
                        .single);
                  });
                },
                icon: const Icon(Icons.close))
          ],
        ),
      ),
    );
  }

  bool isInteger(num value) => value is int || value == value.roundToDouble();
}
