import 'dart:convert';

import 'package:erisiti/business/viewReceipt/horizontalLine.dart';
import 'package:erisiti/business/viewReceipt/rowMaker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' as rootBundle;
import 'package:qr_flutter/qr_flutter.dart';

class ViewReciept extends StatefulWidget {
  const ViewReciept({super.key, required this.receiptGenerated});
  final Map receiptGenerated;

  @override
  State<ViewReciept> createState() => _ViewRecieptState();
}

class _ViewRecieptState extends State<ViewReciept> {
  @override
  void initState() {
    super.initState();
    readJSON();
    readUserInformation();
    readCustomerInformation();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: 1,
        itemBuilder: (context, index) {
          return businessesInformation.isEmpty
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : Container(
                  margin: const EdgeInsets.all(21),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text("*** START OF LEGAL RECEIPT ***"),
                      Text(widget.receiptGenerated['businessProfile']
                              ['businessName']
                          .toString()
                          .toUpperCase()),
                      Text(
                          "${widget.receiptGenerated['businessProfile']['region']}-${widget.receiptGenerated['businessProfile']['district']}"
                              .toString()
                              .toUpperCase()),
                      Text(widget.receiptGenerated['businessProfile']['region']
                          .toString()
                          .toUpperCase()),
                      Text(businessesInformation[index]['businessPhone']
                          .toString()),
                      Text(businessesInformation[index]['businessEmail']
                          .toString()),
                      Text(
                        widget.receiptGenerated['businessProfile']['tinNo']
                            .toString(),
                        style: const TextStyle(
                            color: Colors.black,
                            fontSize: 14,
                            fontWeight: FontWeight.bold),
                      ),
                      Text(
                          userInformation[index]['userVRN'].toString() == "null"
                              ? "VRN *NOT REGISTERED*"
                              : userInformation[index]['userVRN'].toString()),
                      const HorizontalLine(),
                      RowMaker(
                          JSONKey: "Customer's Name",
                          JSONValue: widget.receiptGenerated['client']
                                  ['fullName']
                              .toString()),
                      RowMaker(
                          JSONKey: "Customer's Phone",
                          JSONValue: widget.receiptGenerated['client']['phone']
                              .toString()),
                      RowMaker(
                          JSONKey: "Customer's TIN",
                          JSONValue: widget.receiptGenerated['client']['tinNo']
                              .toString()),
                      const HorizontalLine(),
                      RowMaker(
                          JSONKey: "Receipt Date",
                          JSONValue: widget.receiptGenerated['createdAt']
                              .toString()
                              .replaceRange(
                                  widget.receiptGenerated['createdAt']
                                      .toString()
                                      .indexOf("T"),
                                  widget.receiptGenerated['createdAt']
                                      .toString()
                                      .length,
                                  "")),
                      RowMaker(
                          JSONKey: "Receipt Time",
                          JSONValue: widget.receiptGenerated['createdAt']
                              .toString()
                              .replaceRange(
                                  0,
                                  widget.receiptGenerated['createdAt']
                                          .toString()
                                          .indexOf("T") +
                                      1,
                                  "")),
                      const HorizontalLine(),
                      const Padding(
                        padding: EdgeInsets.all(8),
                        child: Text("Items"),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0, right: 8),
                        child: Table(
                            // defaultColumnWidth: const FixedColumnWidth(120.0),
                            border: TableBorder.all(
                              color: Colors.black,
                              style: BorderStyle.solid,
                              width: 2,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            children: (widget
                                        .receiptGenerated['receiptProducts']
                                    as List)
                                .map((e) => TableRow(children: [
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Column(
                                          children: [
                                            Text(e['id'].toString()),
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Column(
                                          children: [
                                            Text(e['productName'].toString()),
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Column(
                                          children: [
                                            Text(e['amount'].toString()),
                                          ],
                                        ),
                                      ),
                                    ]))
                                .toList()),
                      ),
                      const HorizontalLine(),
                      RowMaker(
                          JSONKey: "Total Amount TAX excluded",
                          JSONValue: ((widget.receiptGenerated['amount']) +
                                  (widget.receiptGenerated['tozo']) +
                                  (widget.receiptGenerated['vat']))
                              .toString()),
                      RowMaker(JSONKey: "Discount", JSONValue: "0"),
                      const HorizontalLine(),
                      RowMaker(
                          JSONKey: "Total TAX",
                          JSONValue:
                              widget.receiptGenerated['tozo'].toString()),
                      RowMaker(
                          JSONKey: "Total Amount TAX included",
                          JSONValue:
                              widget.receiptGenerated['amount'].toString()),
                      const HorizontalLine(),
                      RowMaker(
                          JSONKey: "RECEIPT VERIFICATION CODE",
                          JSONValue: "HDSRGZ"),
                      QrImageView(
                        data: widget.receiptGenerated['receiptNumber'],
                        eyeStyle: const QrEyeStyle(
                            color: Color(0xFF0081A0),
                            eyeShape: QrEyeShape.square),
                        size: 70,
                      ),
                      const Text("*** END OF LEGAL RECEIPT ***"),
                    ],
                  ),
                );
        },
      ),
    );
  }

  List<dynamic> businessesInformation = [];
  readJSON() {
    rootBundle.rootBundle
        .loadString('assets/jsonFiles/userRegisteredBusiness.json')
        .then((value) {
      businessesInformation = json.decode(value);
    });
  }

  List<dynamic> userInformation = [];
  readUserInformation() {
    rootBundle.rootBundle
        .loadString('assets/jsonFiles/userRegistration.json')
        .then((value) {
      setState(() {
        userInformation = json.decode(value);
      });
    });

    // userInformation = capturedJSONData;
  }

  List<dynamic> customerInformation = [];
  readCustomerInformation() {
    rootBundle.rootBundle
        .loadString('assets/jsonFiles/customerInformation.json')
        .then((value) {
      setState(() {
        customerInformation = json.decode(value);
      });
    });
    // final capturedJSONData = await
    // customerInformation = capturedJSONData;
    // print(customerInformation);
  }
}
