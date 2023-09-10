import 'dart:convert';

import 'package:erisiti/business/viewReceipt/horizontalLine.dart';
import 'package:erisiti/business/viewReceipt/rowMaker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' as rootBundle;
import 'package:qr_flutter/qr_flutter.dart';

class ViewReciept extends StatefulWidget {
  const ViewReciept({super.key});

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
          :
          Container(
            margin: const EdgeInsets.all(21),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text("*** START OF LEGAL RECEIPT ***"),
                Text(businessesInformation[index]['businessName'].toString().toUpperCase()),
                Text(businessesInformation[index]['businessAddress'].toString().toUpperCase()),
                Text(businessesInformation[index]['businessLocation'].toString().toUpperCase()),
                Text(businessesInformation[index]['businessPhone'].toString()),
                Text(businessesInformation[index]['businessEmail'].toString()),
                Text(
                  userInformation[index]['userTIN'].toString(),
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 14,
                    fontWeight: FontWeight.bold
                  ),
                ),
                Text(
                  userInformation[index]['userVRN'].toString() == "null" ? "VRN *NOTREGISTERED*": userInformation[index]['userVRN'].toString()
                ),
                const HorizontalLine(),
                RowMaker(JSONKey: "Customer's Name", JSONValue: customerInformation[index]['customerName'].toString()),
                RowMaker(JSONKey: "Customer's Phone", JSONValue: customerInformation[index]['customerPhone'].toString()),
                RowMaker(JSONKey: "Customer's email", JSONValue: customerInformation[index]['customerEmail'].toString()),
                RowMaker(JSONKey: "Customer's TIN", JSONValue: customerInformation[index]['customerTIN'].toString()),
                const HorizontalLine(),
                RowMaker(JSONKey: "Receipt Date", JSONValue: "DD-MM-YY"),
                RowMaker(JSONKey: "Receipt Time", JSONValue: "HH-MM-SS"),
                const HorizontalLine(),
                RowMaker(JSONKey: "Item's Name", JSONValue: "null"),
                RowMaker(JSONKey: "Item's Quantity", JSONValue: "null"),
                RowMaker(JSONKey: "Item's Amount", JSONValue: "null"),
                const HorizontalLine(),
                RowMaker(JSONKey: "Total Amount TAX excluded", JSONValue: "0"),
                RowMaker(JSONKey: "Discount", JSONValue: "0"),
                const HorizontalLine(),
                RowMaker(JSONKey: "Total TAX", JSONValue: "0"),
                RowMaker(JSONKey: "Total Amount TAX included", JSONValue: "0"),
                const HorizontalLine(),
                RowMaker(JSONKey: "Payment Method", JSONValue: "NMB"),
                RowMaker(JSONKey: "Payment Method Ref", JSONValue: "0x03JHDSR834HDVZ"),
                const HorizontalLine(),
                RowMaker(JSONKey: "RECEIPT VERIFICATION CODE", JSONValue: "HDSRGZ"),
                QrImageView(
                  data: "e-RISITI e-GA",
                  eyeStyle: const QrEyeStyle(
                    color: Color(0xFF0081A0),
                    eyeShape: QrEyeShape.square
                  ),
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
  Future<void> readJSON() async{
    final String theFileWithJSONData = await rootBundle.rootBundle.loadString('assets/jsonFiles/userRegisteredBusiness.json');
    final capturedJSONData = await json.decode(theFileWithJSONData);
    businessesInformation = capturedJSONData;
  }
  List<dynamic> userInformation = [];
  Future<void> readUserInformation() async{
    final String theFileWithJSONData = await rootBundle.rootBundle.loadString('assets/jsonFiles/userRegistration.json');
    final capturedJSONData = await json.decode(theFileWithJSONData);
    userInformation = capturedJSONData;
  }
  List<dynamic> customerInformation = [];
  Future<void> readCustomerInformation() async{
    final String theFileWithJSONData = await rootBundle.rootBundle.loadString('assets/jsonFiles/customerInformation.json');
    final capturedJSONData = await json.decode(theFileWithJSONData);
    customerInformation = capturedJSONData;
    print(customerInformation);
  }
}
