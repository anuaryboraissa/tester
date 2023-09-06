import 'package:erisiti/business/businessList/widget/businessList.dart';
import 'package:erisiti/src/features/screens/dashboard/Business/IssueReceipt/issue.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BusinessList extends StatelessWidget {
  const BusinessList({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: Text(
          "My Business",
          style: TextStyle(
              color: Colors.black, fontWeight: FontWeight.bold, fontSize: 21),
        ),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const IssueReceiptPage(),
                ));
              },
              icon: const Icon(
                CupertinoIcons.add,
                color: Color(0xFF0081A0),
              )),
          TextButton(
            onPressed: () {},
            child: Text(
              "issue",
              style: TextStyle(
                color: Color(0xFF0081A0),
              ),
            ),
          )
        ],
      ),
      body: UserBusinessListWidget(),
    );
  }
}
