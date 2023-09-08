import 'package:erisiti/src/constants/styles/animation.dart';
import 'package:flutter/material.dart';

class RegisterBody extends StatefulWidget {
  const RegisterBody(
      {super.key,
      required this.businessName,
      required this.registrationNumber,
      required this.businessType,
      required this.businessTerms});

  final Function(String businessName) businessName;
  final Function(String businessRegNumber) registrationNumber;
  final Function(String type) businessType;
  final Function(String terms) businessTerms;

  @override
  State<RegisterBody> createState() => _RegisterBodyState();
}

class _RegisterBodyState extends State<RegisterBody>
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

  List<String> items = [
    "Retail",
    "E-commerce",
    "Health service",
    "Hospitality and Tourism"
  ];

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
                    padding: const EdgeInsets.all(5),
                    hint: const Text("Business (service) type"),
                    decoration: const InputDecoration(
                      contentPadding: EdgeInsets.all(20),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                    ),
                    items: items
                        .map((e) => DropdownMenuItem(
                              value: e,
                              child: Text(e),
                            ))
                        .toList(),
                    onChanged: (value) {
                      widget.businessType(value!);
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: TextField(
                      onChanged: (value) {
                        widget.businessName(value);
                      },
                      decoration: const InputDecoration(
                          hintText: "Business (Company) Name",
                          contentPadding: EdgeInsets.all(20),
                          border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)))),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: TextField(
                      onChanged: (value) {
                        widget.registrationNumber(value);
                      },
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                          hintText: "Business Registration Number",
                          contentPadding: EdgeInsets.all(20),
                          border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)))),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: TextField(
                      onChanged: (value) {
                        widget.businessTerms(value);
                      },
                      decoration: const InputDecoration(
                          hintText: "Business terms (Optional)",
                          contentPadding: EdgeInsets.all(20),
                          border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)))),
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }
}
