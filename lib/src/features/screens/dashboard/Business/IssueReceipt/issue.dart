import 'package:erisiti/src/features/screens/dashboard/Business/IssueReceipt/components/issue_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../../../../constants/styles/style.dart';
import '../RegisterBusiness/components/top_bar.dart';
import '../items/bloc/register_service_bloc.dart';

class IssueReceiptPage extends StatefulWidget {
  const IssueReceiptPage(
      {super.key,
      required this.businessId,
      required this.products,
      required this.businessName});
  final int businessId;
  final List products;
  final String businessName;

  @override
  State<IssueReceiptPage> createState() => _IssueReceiptPageState();
}

class _IssueReceiptPageState extends State<IssueReceiptPage> {
  bool addItem = true;
  List tozo = [
    {"tozoRedirect": "Barabara", "amount": 200, "percent": 10}
  ];
  String vat = "0.18";
  double totalTozo = 0.0;
  double totalAmount = 0.0;

  TextEditingController tinNumber = TextEditingController();
  RegisterServiceBloc bloc = RegisterServiceBloc();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: BlocConsumer<RegisterServiceBloc, RegisterServiceState>(
          bloc: bloc,
          listener: (context, state) {
            if (state is GenerateReceiptState) {
              Fluttertoast.showToast(msg: state.message);
            }
          },
          builder: (context, state) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                BusinessTopBar(
                  image: "assets/images/issue.png",
                  title: "Customer",
                  subTitle: widget.businessName,
                ),
                const Padding(
                  padding:
                      EdgeInsets.only(left: 20, right: 20, top: 2, bottom: 2),
                  child: Text(
                    "User Information",
                    style: TextStyle(color: ApplicationStyles.realAppColor),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 18.0, right: 18, top: 8),
                  child: TextField(
                    controller: tinNumber,
                    keyboardType: TextInputType.number,
                    onChanged: (value) {
                      // widget.businessName(value);
                    },
                    decoration: const InputDecoration(
                        hintText: "Tin Number (Optional)",
                        contentPadding: EdgeInsets.all(20),
                        border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10)))),
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
                            borderRadius:
                                BorderRadius.all(Radius.circular(10)))),
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
                            borderRadius:
                                BorderRadius.all(Radius.circular(10)))),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20, bottom: 5, top: 10),
                  child: Text(
                    "Service Information (Items ${itemsAdded.length})",
                    style:
                        const TextStyle(color: ApplicationStyles.realAppColor),
                  ),
                ),
                contentHolder(),
                if (addItem)
                  IssueBody(
                    itemAmount: (String amount) {
                      itemAmount = amount;
                    },
                    itemName: (String name) {
                      itemName = name;
                    },
                    itemQuantity: (String quantity) {
                      itemQuantity = quantity;

                      setState(() {
                        itemAmount =
                            "${int.parse(itemAmount.replaceAll("Tshs", "").replaceAll(" ", "").replaceAll(",", "")) * int.parse(quantity.isEmpty ? "1" : quantity)} Tshs";
                      });
                    },
                    products: widget.products,
                  )
              ],
            );
          },
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
            onPressed: itemsAdded.isNotEmpty && !addItem
                ? () {
                    Map<String, dynamic> finalProduct = {
                      "amount": totalAmount - (double.parse(vat) * totalAmount),
                      "vat": double.parse(vat) * totalAmount,
                      "tozo": totalTozo,
                      "businessId": widget.businessId,
                      "tinNo": tinNumber.text,
                      "products": itemsAdded
                    };
                    bloc.add(GenerateReceiptEvent(finalProduct));
                  }
                : null,
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
                // Map<String, dynamic> item = {
                //   "name": itemName,
                //   "quantity": itemQuantity,
                //   "price": itemAmount
                // };

                Map<String, dynamic> item = {
                  "productName": itemName,
                  "amount": double.parse(
                      itemAmount.replaceAll("Tshs", "").replaceAll(" ", "")),
                  "tozos": tozo
                };

                totalTozo = tozo[0]['amount'] + totalTozo;
                totalAmount = (double.parse(itemAmount
                            .replaceAll("Tshs", "")
                            .replaceAll(" ", "")) -
                        tozo[0]['amount']) +
                    totalAmount;
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
            return businessCard(itemsAdded[index]['productName']);
          },
        ));
  }

  Widget businessCard(String itemName) {
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
                        .where((element) => element['productName'] == itemName)
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
