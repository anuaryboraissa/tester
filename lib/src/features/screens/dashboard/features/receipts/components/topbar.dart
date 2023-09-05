import 'package:flutter/material.dart';

import '../../../../../../constants/styles/style.dart';

class TopBar extends StatelessWidget {
  const TopBar(
      {super.key,
      required this.totalAmount,
      required this.taxAmount,
      required this.totalReceipts});
  final String totalAmount;
  final String taxAmount;
  final String totalReceipts;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        height: MediaQuery.of(context).size.height * 0.25,
        child: Stack(
          children: [
            Positioned(
                top: 0,
                left: 0,
                width: MediaQuery.of(context).size.width,
                // height: MediaQuery.of(context).size.height * 0.21,
                child: Container(
                  padding: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height * .02,
                      bottom: MediaQuery.of(context).size.height * .06),
                  decoration: const BoxDecoration(
                      color: ApplicationStyles.realAppColor,
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(30),
                          bottomRight: Radius.circular(30))),
                  // height: 300,
                  width: double.infinity,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: IconButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            icon: const Icon(
                              Icons.arrow_back_ios_new,
                              color: Colors.white,
                            )),
                      ),
                    ],
                  ),
                )),
            Positioned(
                width: MediaQuery.of(context).size.width,
                // height: MediaQuery.of(context).size.height * .20,
                top: MediaQuery.of(context).size.height * .1,
                left: 0,
                child: Padding(
                  padding:
                      const EdgeInsets.only(left: 10.0, right: 10, top: 20),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Card(
                        shadowColor: ApplicationStyles.realAppColor,
                        elevation: 8,
                        shape: const RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(20))),
                        child: Container(
                          padding: const EdgeInsets.all(6),
                          width: MediaQuery.of(context).size.width / 3 - 16,
                          // height: MediaQuery.of(context).size.height * 0.14,
                          child: Padding(
                            padding: const EdgeInsets.all(6),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Total Receipts",
                                  style: ApplicationStyles.getStyle(
                                      true, 10, null),
                                ),
                                Text(
                                  totalReceipts,
                                  style: ApplicationStyles.getStyle(
                                      true, 16, ApplicationStyles.realAppColor),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Card(
                        shadowColor: ApplicationStyles.realAppColor,
                        elevation: 8,
                        shape: const RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(20))),
                        child: Container(
                          padding: const EdgeInsets.all(6),
                          width: MediaQuery.of(context).size.width / 3 - 16,
                          // height: MediaQuery.of(context).size.height * 0.14,
                          child: Padding(
                            padding: const EdgeInsets.all(6),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Tax Amount",
                                  style: ApplicationStyles.getStyle(
                                      true, 10, null),
                                ),
                                Text(
                                  taxAmount,
                                  style: ApplicationStyles.getStyle(
                                      true, 16, ApplicationStyles.realAppColor),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Card(
                        shadowColor: ApplicationStyles.realAppColor,
                        elevation: 8,
                        shape: const RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(20))),
                        child: Container(
                          padding: const EdgeInsets.all(6),
                          width: MediaQuery.of(context).size.width / 3 - 16,
                          // height: MediaQuery.of(context).size.height * 0.14,
                          child: Padding(
                            padding: const EdgeInsets.all(6),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  "Total Amount",
                                  style: ApplicationStyles.getStyle(
                                      true, 10, null),
                                ),
                                Text(
                                  totalAmount,
                                  style: ApplicationStyles.getStyle(
                                      true, 16, ApplicationStyles.realAppColor),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ))
          ],
        ),
      ),
    );
  }
}
