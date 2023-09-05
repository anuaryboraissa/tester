import 'package:flutter/material.dart';

class decimalProduct extends StatefulWidget {
  const decimalProduct({
    super.key,
  });

  @override
  State<decimalProduct> createState() => _decimalProductState();
}

class _decimalProductState extends State<decimalProduct> {
  bool isDecimal = false;
  @override
  Widget build(BuildContext context) {
    return CheckboxListTile(
      title: Text("Product may quantity may be in decimals"),
      value: isDecimal,
      activeColor: Colors.cyan,
      onChanged: (value) {
        setState(() {
          isDecimal = !isDecimal;
          print("The product is decimal : $isDecimal");
        });
      },
    );
  }
}
