import 'package:erisiti/business/businessList/widget/businessList.dart';
import 'package:erisiti/src/features/screens/dashboard/Business/IssueReceipt/issue.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BusinessList extends StatelessWidget {
  const BusinessList({super.key, required this.tinNumber});
  final String tinNumber;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: const Text(
          "My Business",
          style: TextStyle(
              color: Colors.black, fontWeight: FontWeight.bold, fontSize: 21),
        ),
        actions: [
          IconButton(
              onPressed: () {},
              icon: const Icon(
                CupertinoIcons.add,
                color: Color(0xFF0081A0),
              )),
        ],
      ),
      body: UserBusinessListWidget(
        tinNumber: tinNumber,
      ),
    );
  }
}
