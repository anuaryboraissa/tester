import 'package:erisiti/src/features/screens/dashboard/Business/items/components/add_item_body.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../../../../constants/styles/style.dart';
import '../RegisterBusiness/components/top_bar.dart';

class ItemRegisterPage extends StatefulWidget {
  const ItemRegisterPage(
      {super.key,
      required this.business,
      required this.savedProducts,
      required this.businessId});
  final String business;
  final int businessId;
  final Function(Map<String, dynamic> products) savedProducts;

  @override
  State<ItemRegisterPage> createState() => _ItemRegisterPageState();
}

class _ItemRegisterPageState extends State<ItemRegisterPage> {
  bool addProduct = true;

  List<Map<String, dynamic>> items = [];
  String itemName = "";
  String price = "";
  String unit = "";
  String currency = "";
  bool acceptDecimal = false;

  List<Map<String, dynamic>> saved = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              BusinessTopBar(
                  title: "Products",
                  image: "assets/images/product.png",
                  subTitle: "${widget.business} Products"),
              contentHolder(),
              if (addProduct)
                RegisterItemBody(
                  itemName: (name) {
                    itemName = name;
                  },
                  itemUnit: (unit) {
                    this.unit = unit;
                  },
                  itemPrice: (price) {
                    this.price = price;
                  },
                  itemCurrency: (String currency) {
                    this.currency = currency;
                  },
                  acceptDecimal: (bool decimal) {
                    acceptDecimal = decimal;
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
              onPressed: addProduct || items.isEmpty
                  ? null
                  : () {
                      // Navigator.of(context).push(MaterialPageRoute(
                      //   builder: (context) => RegisteredBusiness(
                      //     businesses: businesses,
                      //   ),
                      // ));
                      Navigator.of(context).pop();
                    },
              child: const Text("Save Items")),
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: ApplicationStyles.realAppColor,
          onPressed: () {
            setState(() {
              if (addProduct) {
                if (itemName.isEmpty) {
                  Fluttertoast.showToast(msg: "Item Name is required");
                } else if (price.isEmpty) {
                  Fluttertoast.showToast(msg: "Item price is required");
                } else if (unit.isEmpty) {
                  Fluttertoast.showToast(msg: "Item unit is required");
                } else if (currency.isEmpty) {
                  Fluttertoast.showToast(msg: "Item Currency is required");
                } else {
                  Map<String, dynamic> item = {
                    "name": itemName,
                    "currency": currency,
                    "unit": unit,
                    "price": price,
                    "acceptDecimal": acceptDecimal,
                    "id": items.length + 1
                  };
                  items.add(item);
                  Map<String, dynamic> businessProducts = {
                    "businessId": widget.businessId,
                    "products": [item]
                  };
                  widget.savedProducts(businessProducts);

                  addProduct = !addProduct;
                }
              } else {
                addProduct = !addProduct;
              }
            });
          },
          child: Icon(
            addProduct ? Icons.check : Icons.add,
            size: 20,
            color: Colors.white,
          ),
        ));
  }

  Widget contentHolder() {
    return Container(
        padding: const EdgeInsets.only(left: 15, right: 15),
        width: double.infinity,
        height: items.isEmpty ? 0 : 60,
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(10)),
        child: ListView.builder(
          padding: const EdgeInsets.all(5),
          scrollDirection: Axis.horizontal,
          itemCount: items.length,
          itemBuilder: (BuildContext context, int index) {
            return businessCard(items[index]['name'], items[index]['id']);
          },
        ));
  }

  Widget businessCard(String itemName, int id) {
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
                itemName,
                style: const TextStyle(overflow: TextOverflow.ellipsis),
              ),
            ),
            IconButton(
                onPressed: () {
                  setState(() {
                    items.remove(
                        items.where((element) => element['id'] == id).single);
                  });
                },
                icon: const Icon(Icons.close))
          ],
        ),
      ),
    );
  }
}
