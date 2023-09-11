import 'package:erisiti/business/viewReceipt/viewReciept.dart';
import 'package:erisiti/src/constants/styles/style.dart';
import 'package:erisiti/src/features/screens/dashboard/features/receipts/bloc/receipt_page_bloc.dart';
import 'package:erisiti/src/features/screens/dashboard/features/receipts/modal/helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ReceiptReport extends StatefulWidget {
  const ReceiptReport({super.key, required this.receipts});
  final List receipts;

  @override
  State<ReceiptReport> createState() => _ReceiptReportState();
}

class _ReceiptReportState extends State<ReceiptReport> {
  TextEditingController searchController = TextEditingController();
  ReceiptPageBloc receiptBloc = ReceiptPageBloc();
  List? receipts;

  @override
  void initState() {
    setState(() {
      receipts = widget.receipts;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ReceiptPageBloc, ReceiptPageState>(
      listener: (context, state) {},
      bloc: receiptBloc,
      builder: (context, state) {
        return Container(
          height: MediaQuery.of(context).size.height * .74,
          margin: const EdgeInsets.only(left: 15, right: 15),
          child: Column(
            children: [
              TextFormField(
                onChanged: (value) {
                  if (receipts != null) {
                    receiptBloc.add(
                        SearchReceiptEvent(query: value, receipts: receipts!));
                  }
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
                                "${(state).receipts.length}/${receipts!.length}"),
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
              receipts == null
                  ? const Center(
                      child: CircularProgressIndicator(
                        color: ApplicationStyles.realAppColor,
                      ),
                    )
                  : Expanded(
                      child: ListView.builder(
                        itemCount: (state is ReceiptSearchState)
                            ? (state).receipts.length
                            : receipts!.length,
                        itemBuilder: (context, index) {
                          final receipt = (state is ReceiptSearchState)
                              ? (state).receipts[index]
                              : receipts![index];
                          return Container(
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                                border: Border.all(
                                    color: ApplicationStyles.realAppColor)),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        children: [
                                          const Text("Number: "),
                                          (state is ReceiptSearchState)
                                              ? Text.rich(ReceiptHelper()
                                                  .searchMatch(
                                                      receipt["receiptNumber"],
                                                      (state).query))
                                              : Text(receipt["receiptNumber"])
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        children: [
                                          const Text("Amount: "),
                                          (state is ReceiptSearchState)
                                              ? Text.rich(ReceiptHelper()
                                                  .searchMatch(
                                                      receipt['amount']
                                                          .toString(),
                                                      (state).query))
                                              : Text(
                                                  receipt['amount'].toString())
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        children: [
                                          const Text("Tozo - Vat: "),
                                          (state is ReceiptSearchState)
                                              ? Text.rich(ReceiptHelper()
                                                  .searchMatch(
                                                      "${receipt['tozo']} ${receipt['vat']}",
                                                      (state).query))
                                              : Text(
                                                  "${receipt['tozo']} - ${receipt['vat']}")
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                                IconButton(
                                    onPressed: () {
                                      Navigator.of(context)
                                          .push(MaterialPageRoute(
                                        builder: (context) => ViewReciept(
                                          receiptGenerated: receipt,
                                        ),
                                      ));
                                    },
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
