import 'dart:convert';
import 'package:erisiti/business/productList/widgets.dart/productWidget.dart';
import 'package:erisiti/business/productList/widgets.dart/searchWidget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' as rootBundle;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../src/constants/styles/style.dart';
import '../../src/features/screens/dashboard/Business/IssueReceipt/issue.dart';
import '../../src/features/screens/dashboard/Business/items/bloc/register_service_bloc.dart';

class ProductList extends StatefulWidget {
  final String businessName;
  const ProductList(
      {super.key,
      required this.businessName,
      required this.businessRegNumber,
      required this.businessId});
  final String businessRegNumber;
  final int businessId;

  @override
  State<ProductList> createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
  @override
  void initState() {
    bloc.add(FindProductsByBusinessNumberEvent(widget.businessRegNumber));
    super.initState();
    // readJSON();
  }

  String query = "";
  RegisterServiceBloc bloc = RegisterServiceBloc();

  List<String> categories = ["issue", "receipts"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(color: const Color(0xFF0081A0)),
        elevation: 0,
        backgroundColor: Colors.white,
        title: Text(
          widget.businessName,
          // "${ownerBusinesses[widget.businessID]['businessName'].toString()}",
          style: const TextStyle(
              color: Colors.black, fontWeight: FontWeight.bold, fontSize: 21),
        ),
        actions: [
          IconButton(
              onPressed: () {},
              icon: const Icon(
                CupertinoIcons.add,
                color: Color(0xFF0081A0),
              )),
          IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.receipt,
                color: Color(0xFF0081A0),
              )),
          PopupMenuButton<String>(
            onSelected: (value) {
              if (value == "issue") {
                if (theProductList != null) {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => IssueReceiptPage(
                      businessId: widget.businessId,
                      products: theProductList!,
                      businessName: widget.businessName,
                    ),
                  ));
                }
              } else if (value == "receipts") {}
            },
            icon: const Icon(
              Icons.more_vert,
              color: ApplicationStyles.realAppColor,
            ),
            itemBuilder: (context) => categories
                .map((e) => PopupMenuItem(
                      value: e,
                      child: Text(e),
                    ))
                .toList(),
          )
        ],
        centerTitle: true,
      ),
      body: BlocConsumer<RegisterServiceBloc, RegisterServiceState>(
        bloc: bloc,
        listener: (context, state) {
          if (state is FindProductsByBusinessNumberState) {
            theProductList = state.items;
          }
        },
        builder: (context, state) {
          return theProductList == null
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : theProductList!.isEmpty
                  ? const Center(
                      child: Text("No data is available"),
                    )
                  : Column(
                      children: [
                        SearchWidget(
                          hintText: "Search Products",
                          result: (String query) {
                            setState(() {
                              if (query.isNotEmpty) {
                                searching = true;
                                this.query = query;
                              } else {
                                searching = false;
                                this.query = "";
                              }
                            });
                          },
                        ),
                        Expanded(
                          child: ListView.builder(
                            shrinkWrap: true,
                            itemCount: searching
                                ? searchItem(query).length
                                : theProductList!.length,
                            itemBuilder: (context, index) {
                              final item = searching
                                  ? searchItem(query)[index]
                                  // : productList[0]['businessProducts'][0]['name'];
                                  : theProductList![index];
                              return Slidable(
                                startActionPane: ActionPane(
                                    motion: const StretchMotion(),
                                    children: [
                                      SlidableAction(
                                        onPressed: (context) {},
                                        backgroundColor: Color(0xFF0081A0),
                                        icon: CupertinoIcons.refresh_circled,
                                        label: 'Edit',
                                      ),
                                      SlidableAction(
                                        onPressed: (context) {},
                                        backgroundColor: Colors.red,
                                        icon: CupertinoIcons.delete,
                                        label: 'Delete',
                                      ),
                                    ]),
                                endActionPane: ActionPane(
                                    motion: const BehindMotion(),
                                    children: [
                                      SlidableAction(
                                        onPressed: (context) {},
                                        backgroundColor:
                                            const Color(0xFF0081A0),
                                        icon: Icons.more_horiz,
                                        label: 'More',
                                      ),
                                    ]),
                                child: ProductWidget(
                                    productName: "${item['productName']}",
                                    productUnit: "${item['unit']}",
                                    productAmount: "${item['price']}"),
                              );
                            },
                          ),
                        ),
                      ],
                    );
        },
      ),
    );
  }

  String BRELAID = "002202";
  String businessName = "OMEGA - DAR";
  List<dynamic> ownerBusinesses = [];
  List<dynamic>? theProductList;
  Future<void> readJSON() async {
    final String theFileWithJSONData = await rootBundle.rootBundle
        .loadString('assets/jsonFiles/userRegisteredBusiness.json');
    final capturedJSONData = await json.decode(theFileWithJSONData);
    setState(() {
      ownerBusinesses = capturedJSONData;
    });
    // theProductList = ownerBusinesses[widget.businessID]['businessProducts'];
    theProductList = ownerBusinesses
        .where((element) =>
            element['businessName'].toString().contains(widget.businessName))
        .toList();
    theProductList = theProductList![0]['businessProducts'];
  }

  bool searching = false;

  List<dynamic> searchItem(String query) {
    return theProductList!
        .where((element) => element['productName']
            .toString()
            .toLowerCase()
            .contains(query.toLowerCase()))
        .toList();
  }
}
