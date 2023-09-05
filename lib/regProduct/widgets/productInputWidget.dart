import 'package:flutter/material.dart';

// ignore: must_be_immutable
class ProductInputWidget extends StatefulWidget {
  String label;
  ProductInputWidget({super.key, required this.label});

  @override
  State<ProductInputWidget> createState() => _ProductInputWidgetState();
}

class _ProductInputWidgetState extends State<ProductInputWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please Fill this field';
          }
        },
        decoration: InputDecoration(
            label: Text(widget.label),
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(width: 3, color: Colors.cyan),
                borderRadius: BorderRadius.circular(21)),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                width: 3,
                color: Colors.cyan,
              ),
              borderRadius: BorderRadius.circular(21),
            )),
      ),
    );
  }
}
