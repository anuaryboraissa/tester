import 'package:erisiti/business/productList/helper.dart';
import 'package:flutter/material.dart';

import '../../../../../../constants/styles/animation.dart';

class IssueBody extends StatefulWidget {
  const IssueBody(
      {super.key,
      required this.itemName,
      required this.itemQuantity,
      required this.itemAmount,
      required this.products});
  final Function(String name) itemName;
  final Function(String quantity) itemQuantity;
  final Function(String amount) itemAmount;
  final List products;

  @override
  State<IssueBody> createState() => _IssueBodyState();
}

class _IssueBodyState extends State<IssueBody>
    with SingleTickerProviderStateMixin {
  late Animation animation, delayedAnimation;
  late AnimationController animationController;
  late AnimatedWidgetAction action;

  @override
  void initState() {
    super.initState();
    action = AnimatedWidgetAction(provider: this);
    Map animate = action.animate();
    animationController = animate['controller'];
    delayedAnimation = animate['delayed'];
    getProducts();
    amount.text = "0";
  }

  List items = [];
  getProducts() {
    setState(() {
      items = widget.products;
    });
  }

  @override
  void dispose() {
    action.dispose();
    super.dispose();
  }

  String units = "";

  TextEditingController amount = TextEditingController();
  TextEditingController quantity = TextEditingController();
  String initialAmount = "0";

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    return AnimatedBuilder(
        animation: animationController,
        builder: (context, child) {
          return Transform(
            transform:
                Matrix4.translationValues(delayedAnimation.value * width, 0, 0),
            child: Container(
              margin: const EdgeInsets.all(5),
              padding: const EdgeInsets.all(10),
              decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(10))),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  DropdownButtonFormField(
                    padding: const EdgeInsets.all(2),
                    hint: const Text("Item"),
                    decoration: const InputDecoration(
                      contentPadding: EdgeInsets.all(20),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                    ),
                    items: items
                        .map((e) => DropdownMenuItem(
                              value: e['id'],
                              child: Text(e['productName']),
                            ))
                        .toList(),
                    onChanged: (value) {
                      // widget.businessType(value!);

                      units = items
                          .where((element) => element['id'] == value)
                          .single['unit']
                          .toString();
                      setState(() {
                        quantity.text = "1";
                      });

                      amount.text =
                          "${items.where((element) => element['id'] == value).single['price']} Tshs";
                      initialAmount =
                          "${items.where((element) => element['id'] == value).single['price']} Tshs";
                      widget.itemName(items
                          .where((element) => element['id'] == value)
                          .single['productName']);
                      widget.itemAmount(amount.text);
                      widget.itemQuantity(quantity.text);
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: TextField(
                      controller: quantity,
                      keyboardType: TextInputType.number,
                      onChanged: (value) {
                        widget.itemQuantity(value);
                        amount.text = value.isEmpty
                            ? initialAmount
                            : "${int.parse(amount.text.replaceAll("Tshs", "").replaceAll(" ", "").replaceAll(",", "")) * int.parse(value.isEmpty ? "1" : value)} Tshs";
                        widget.itemAmount(value.isEmpty
                            ? initialAmount
                            : "${int.parse(amount.text.replaceAll("Tshs", "").replaceAll(" ", "").replaceAll(",", "")) * int.parse(value.isEmpty ? "1" : value)} Tshs");
                      },
                      decoration: InputDecoration(
                          prefix: Padding(
                            padding: const EdgeInsets.only(right: 8.0),
                            child: Text(units),
                          ),
                          hintText: "Quantity",
                          contentPadding: const EdgeInsets.all(20),
                          border: const OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)))),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: TextField(
                      controller: amount,
                      // readOnly: true,
                      onChanged: (value) {
                        // widget.registrationNumber(value);
                      },
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                          contentPadding: EdgeInsets.all(20),
                          border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)))),
                    ),
                  ),
                  // Padding(
                  //   padding: const EdgeInsets.all(5.0),
                  //   child: TextField(
                  //     onChanged: (value) {
                  //       // widget.businessTerms(value);
                  //     },
                  //     decoration: const InputDecoration(
                  //         hintText: "Business terms (Optional)",
                  //         contentPadding: EdgeInsets.all(20),
                  //         border: OutlineInputBorder(
                  //             borderRadius:
                  //                 BorderRadius.all(Radius.circular(10)))),
                  //   ),
                  // ),
                ],
              ),
            ),
          );
        });
  }
}
