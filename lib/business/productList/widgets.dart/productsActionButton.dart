import 'package:flutter/material.dart';

import 'actionButton.dart';

class productsActionButtons extends StatefulWidget {
  const productsActionButtons({
    super.key,
  });

  @override
  State<productsActionButtons> createState() => _productsActionButtonsState();
}

class _productsActionButtonsState extends State<productsActionButtons> {
  bool animate = false;
  Future startAnimation() async {
    await Future.delayed(Duration(milliseconds: 0));
    setState(() {
      animate = true;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    startAnimation();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        actionButton(animate: animate, title: "Edit", bgColor: Colors.green),
        actionButton(animate: animate, title: "Delete", bgColor: Colors.red),
        actionButton(animate: animate, title: "More", bgColor: Colors.cyan),
      ],
    );
  }
}
