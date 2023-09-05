import 'package:erisiti/src/features/screens/dashboard/Business/IssueReceipt/components/issue_page.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../../../../constants/styles/style.dart';
import '../RegisterBusiness/components/top_bar.dart';

class IssueReceiptPage extends StatefulWidget {
  const IssueReceiptPage({super.key});

  @override
  State<IssueReceiptPage> createState() => _IssueReceiptPageState();
}

class _IssueReceiptPageState extends State<IssueReceiptPage> {
  bool addItem = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const BusinessTopBar(
              image: "assets/images/issue.png",
              title: "Customer",
              subTitle: 'Business Name',
            ),
            const Padding(
              padding: EdgeInsets.only(left: 20, right: 20, top: 2, bottom: 2),
              child: Text(
                "User Information",
                style: TextStyle(color: ApplicationStyles.realAppColor),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 18.0, right: 18, top: 8),
              child: TextField(
                keyboardType: TextInputType.number,
                onChanged: (value) {
                  // widget.businessName(value);
                },
                decoration: const InputDecoration(
                    hintText: "Tin Number (Optional)",
                    contentPadding: EdgeInsets.all(20),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)))),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 18.0, right: 18, top: 8),
              child: TextField(
                onChanged: (value) {
                  // widget.businessName(value);
                },
                decoration: const InputDecoration(
                    hintText: "Full Name",
                    contentPadding: EdgeInsets.all(20),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)))),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 18.0, right: 18, top: 8),
              child: TextField(
                keyboardType: TextInputType.number,
                onChanged: (value) {
                  // widget.businessName(value);
                },
                decoration: const InputDecoration(
                    hintText: "Phone number",
                    contentPadding: EdgeInsets.all(20),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)))),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20, bottom: 5, top: 10),
              child: Text(
                "Service Information (Items ${itemsAdded.length})",
                style: const TextStyle(color: ApplicationStyles.realAppColor),
              ),
            ),
            contentHolder(),
            if (addItem)
              IssueBody(
                itemAmount: (String amount) {
                  print("item amount is of $amount..........................");
                },
                itemName: (String name) {
                  itemName = name;
                },
                itemQuantity: (String quantity) {
                  itemQuantity = quantity;
                  print(
                      "number amount ${itemAmount.replaceAll("Tshs", "").replaceAll(" ", "")}");
                  setState(() {
                    itemAmount =
                        "${int.parse(itemAmount.replaceAll("Tshs", "").replaceAll(" ", "")) * int.parse(quantity.isEmpty ? "1" : quantity)} Tshs";
                  });
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
            onPressed: itemsAdded.isNotEmpty && !addItem ? () {} : null,
            child: const Text("Generate Receipt")),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: ApplicationStyles.realAppColor,
        onPressed: () {
          setState(() {
            if (addItem) {
              if (itemName.isEmpty) {
                Fluttertoast.showToast(msg: "Business Type is required");
              } else if (itemQuantity.isEmpty) {
                Fluttertoast.showToast(
                    msg: "Business Registration Number is required");
              } else {
                Map<String, dynamic> item = {
                  "name": itemName,
                  "quantity": itemQuantity,
                  "price": itemAmount
                };
                itemsAdded.add(item);

                addItem = !addItem;
              }
            } else {
              addItem = !addItem;
            }
          });
        },
        child: Icon(
          addItem ? Icons.check : Icons.add,
          size: 20,
          color: Colors.white,
        ),
      ),
    );
  }

  List<Map<String, dynamic>> itemsAdded = [];
  String itemName = "";
  String itemQuantity = "";
  String itemAmount = "";

  Widget contentHolder() {
    return Container(
        padding: const EdgeInsets.only(left: 15, right: 15),
        width: double.infinity,
        height: itemsAdded.isEmpty ? 0 : 60,
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(10)),
        child: ListView.builder(
          padding: const EdgeInsets.all(5),
          scrollDirection: Axis.horizontal,
          itemCount: itemsAdded.length,
          itemBuilder: (BuildContext context, int index) {
            return businessCard(
                itemsAdded[index]['name'], itemsAdded[index]['quantity']);
          },
        ));
  }

  Widget businessCard(String itemName, String itemQuantity) {
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
                    itemsAdded.remove(itemsAdded
                        .where((element) => element['name'] == itemName)
                        .single);
                  });
                },
                icon: const Icon(Icons.close))
          ],
        ),
      ),
    );
  }
}
