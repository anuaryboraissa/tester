import 'package:flutter/material.dart';

// ignore: must_be_immutable
class InputLabelsWidgets extends StatelessWidget {
  String label;

  InputLabelsWidgets({super.key, required this.label});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0, right: 8, top: 8),
      child: Text(
        label,
        style: const TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
      ),
    );
  }
}
