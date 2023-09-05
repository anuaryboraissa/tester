import 'package:erisiti/src/features/screens/dashboard/features/receipts/components/body.dart';
import 'package:flutter/material.dart';

import 'components/topbar.dart';

class ReceiptPage extends StatefulWidget {
  const ReceiptPage({super.key, required this.receiptsOverview});
  final Map receiptsOverview;

  @override
  State<ReceiptPage> createState() => _ReceiptPageState();
}

class _ReceiptPageState extends State<ReceiptPage> {
  @override
  Widget build(BuildContext context) {
    print(
        "nor ${widget.receiptsOverview['totalReceipts']} tax ${widget.receiptsOverview['taxAmount'].toString()} total  ${widget.receiptsOverview['totalAmount']}");
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            TopBar(
              taxAmount: widget.receiptsOverview['taxAmount'].toString(),
              totalReceipts: widget.receiptsOverview['totalReceipts'],
              totalAmount: widget.receiptsOverview['totalAmount'],
            ),
            const ReceiptReport()
          ],
        ),
      ),
    );
  }
}
