import 'package:erisiti/business/businessList/widget/userBusinessListWidget.dart';
import 'package:erisiti/src/features/screens/dashboard/Business/IssueReceipt/issue.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BusinessList extends StatelessWidget {
  const BusinessList({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.cyan,
        title: const Text(
          "My Business",
          style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 21),
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
                color: Colors.white,
              )),
          TextButton(
            onPressed: () {},
            child: PopupMenuButton(
              position: PopupMenuPosition.under,
              itemBuilder: (context) => List.generate(4, (value) {
                return PopupMenuItem(child: Text(value.toString()));
              }).toList(),
            ),
          )
        ],
      ),
      body: const UserBusinessListWidget(),
    );
  }
}
