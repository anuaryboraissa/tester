import 'package:erisiti/src/constants/styles/style.dart';
import 'package:erisiti/src/features/screens/dashboard/features/receipts/bloc/receipt_page_bloc.dart';
import 'package:erisiti/src/features/screens/dashboard/features/receipts/modal/helper.dart';
import 'package:erisiti/src/features/screens/dashboard/features/receipts/modal/receipt.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ReceiptReport extends StatefulWidget {
  const ReceiptReport({super.key});

  @override
  State<ReceiptReport> createState() => _ReceiptReportState();
}

class _ReceiptReportState extends State<ReceiptReport> {
  TextEditingController searchController = TextEditingController();
  ReceiptPageBloc receiptBloc = ReceiptPageBloc();
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ReceiptPageBloc, ReceiptPageState>(
      bloc: receiptBloc,
      builder: (context, state) {
        return Container(
          height: MediaQuery.of(context).size.height * .74,
          margin: const EdgeInsets.only(left: 15, right: 15),
          child: Column(
            children: [
              TextFormField(
                onChanged: (value) {
                  receiptBloc.add(SearchReceiptEvent(query: value));
                },
                decoration: InputDecoration(
                    focusedBorder: const OutlineInputBorder(
                        borderSide:
                            BorderSide(color: ApplicationStyles.realAppColor),
                        borderRadius: BorderRadius.all(Radius.circular(50))),
                    suffixIcon: (state is ReceiptSearchState)
                        ? Padding(
                            padding: const EdgeInsets.all(15),
                            child: Text(
                                "${(state).receipts.length}/${ReceiptHelper.receipts.length}"),
                          )
                        : null,
                    border: const OutlineInputBorder(
                        borderSide:
                            BorderSide(color: ApplicationStyles.realAppColor),
                        borderRadius: BorderRadius.all(Radius.circular(50))),
                    contentPadding: const EdgeInsets.all(10),
                    prefixIcon: const Icon(
                      Icons.search,
                      color: ApplicationStyles.realAppColor,
                    ),
                    hintText: "Search receipt here"),
                controller: searchController,
              ),
              SizedBox(
                height: ApplicationStyles.getScreenHeight(context) * .01,
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: (state is ReceiptSearchState)
                      ? (state).receipts.length
                      : ReceiptHelper.receipts.length,
                  itemBuilder: (context, index) {
                    Receipt receipt = (state is ReceiptSearchState)
                        ? (state).receipts[index]
                        : ReceiptHelper.receipts[index];
                    return Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          border: Border.all(
                              color: ApplicationStyles.realAppColor)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  children: [
                                    const Text("issuer name:"),
                                    (state is ReceiptSearchState)
                                        ? Text.rich(ReceiptHelper().searchMatch(
                                            receipt.issuer, (state).query))
                                        : Text(receipt.issuer)
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  children: [
                                    const Text("Address: "),
                                    (state is ReceiptSearchState)
                                        ? Text.rich(ReceiptHelper().searchMatch(
                                            receipt.address, (state).query))
                                        : Text(receipt.address)
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  children: [
                                    const Text("Phone Number: "),
                                    (state is ReceiptSearchState)
                                        ? Text.rich(ReceiptHelper().searchMatch(
                                            receipt.phone, (state).query))
                                        : Text(receipt.phone)
                                  ],
                                ),
                              )
                            ],
                          ),
                          IconButton(
                              onPressed: () {},
                              icon: const Icon(
                                Icons.remove_red_eye_outlined,
                                color: ApplicationStyles.realAppColor,
                              ))
                        ],
                      ),
                    );
                  },
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
