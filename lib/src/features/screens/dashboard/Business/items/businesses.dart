import 'package:erisiti/src/features/screens/dashboard/Business/RegisterBusiness/components/top_bar.dart';
import 'package:erisiti/src/features/screens/dashboard/Business/items/components/business_card.dart';
import 'package:erisiti/src/features/screens/dashboard/Business/items/register.dart';
import 'package:erisiti/src/features/screens/login/Login.dart';
import 'package:flutter/material.dart';

import '../../../../../constants/styles/style.dart';

class RegisteredBusiness extends StatefulWidget {
  const RegisteredBusiness({super.key, required this.businesses});

  final List<Map<String, dynamic>> businesses;

  @override
  State<RegisteredBusiness> createState() => _RegisteredBusinessState();
}

class _RegisteredBusinessState extends State<RegisteredBusiness> {
  @override
  void initState() {
    super.initState();
  }

  List<Map<String, dynamic>> savedProducts = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const BusinessTopBar(
              title: "Products",
              image: "assets/images/product.png",
              subTitle: "Businesses to be registered"),
          const Padding(
            padding: EdgeInsets.only(right: 15, bottom: 5),
            child: Text("Tap to Register Products in Each Business"),
          ),
          Expanded(
              child: ListView.builder(
            itemCount: widget.businesses.length,
            itemBuilder: (context, index) {
              Map<String, dynamic> business = widget.businesses[index];
              print(
                  "business ${business['name']} ${business['registeredItems']}");
              return BusinessListCard(
                title: business['name'],
                businessNo: business['registrationNumber'],
                registered: savedProducts.isEmpty
                    ? false
                    : savedProducts
                        .where((element) =>
                            element['businessId'] == business['id'])
                        .isNotEmpty,
                tapped: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => ItemRegisterPage(
                      business: business['name'],
                      savedProducts: (Map<String, dynamic> products) {
                        if (products.isNotEmpty) {
                          setState(() {
                            if (savedProducts.isEmpty ||
                                (savedProducts
                                        .where((element) =>
                                            element["businessId"] ==
                                            products['businessId'])
                                        .toList())
                                    .isEmpty) {
                              savedProducts.add(products);
                            } else {
                              (savedProducts
                                      .where((element) =>
                                          element["businessId"] ==
                                          products['businessId'])
                                      .toList()
                                      .last['products'] as List)
                                  .add(products['products'][0]);
                            }
                          });
                          print(savedProducts);
                          print(savedProducts.length);
                        }
                      },
                      businessId: business['id'],
                    ),
                  ));
                },
              );
            },
          ))
        ],
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(10),
        child: ElevatedButton(
            style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.all(15),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                backgroundColor: ApplicationStyles.realAppColor),
            onPressed: savedProducts.length == widget.businesses.length
                ? () {
                    Navigator.of(context).popUntil((route) => route.isFirst);
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const Login(),
                        ));
                  }
                : null,
            child: const Text("Finish")),
      ),
    );
  }
}
