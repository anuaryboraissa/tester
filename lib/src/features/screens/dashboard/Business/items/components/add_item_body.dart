import 'package:flutter/material.dart';

import '../../../../../../constants/styles/animation.dart';

class RegisterItemBody extends StatefulWidget {
  const RegisterItemBody(
      {super.key,
      required this.itemName,
      required this.itemUnit,
      required this.itemPrice,
      required this.itemCurrency,
      required this.acceptDecimal});

  final Function(String name) itemName;
  final Function(String unit) itemUnit;

  final Function(String price) itemPrice;
  final Function(String currency) itemCurrency;
  final Function(bool decimal) acceptDecimal;
  @override
  State<RegisterItemBody> createState() => _RegisterItemBodyState();
}

class _RegisterItemBodyState extends State<RegisterItemBody>
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
  }

  @override
  void dispose() {
    action.dispose();
    super.dispose();
  }

  bool acceptDecimal = false;

  List<String> units = ["KG", "Item"];

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
                  Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: TextField(
                      onChanged: (value) {
                        widget.itemName(value);
                      },
                      decoration: const InputDecoration(
                          hintText: "Item Name",
                          contentPadding: EdgeInsets.all(20),
                          border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)))),
                    ),
                  ),
                  DropdownButtonFormField(
                    padding: const EdgeInsets.all(5),
                    hint: const Text("Item Unit"),
                    decoration: const InputDecoration(
                      contentPadding: EdgeInsets.all(20),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                    ),
                    items: units
                        .map((e) => DropdownMenuItem(
                              value: e,
                              child: Text(e),
                            ))
                        .toList(),
                    onChanged: (value) {
                      widget.itemUnit(value!);
                    },
                  ),
                  DropdownButtonFormField(
                    padding: const EdgeInsets.all(5),
                    hint: const Text("Item Currency"),
                    decoration: const InputDecoration(
                      contentPadding: EdgeInsets.all(20),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                    ),
                    items: ["Tshs", "Rand"]
                        .map((e) => DropdownMenuItem(
                              value: e,
                              child: Text(e),
                            ))
                        .toList(),
                    onChanged: (value) {
                      widget.itemCurrency(value!);
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: TextField(
                      onChanged: (value) {
                        widget.itemPrice(value);
                      },
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                          hintText: "Item Price",
                          contentPadding: EdgeInsets.all(20),
                          border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)))),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      //SizedBox
                      const Text(
                        'Item Quantity accept decimal ?: ',
                        style: TextStyle(fontSize: 17.0),
                      ), //Text

                      Checkbox(
                        value: acceptDecimal,
                        onChanged: (bool? value) {
                          setState(() {
                            acceptDecimal = value!;
                            widget.acceptDecimal(value);
                          });
                        },
                      ), //Checkbox
                    ], //<Widget>[]
                  ),
                ],
              ),
            ),
          );
        });
  }
}
