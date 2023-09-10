import 'package:flutter/material.dart';

// ignore: must_be_immutable
class RowMaker extends StatelessWidget {
  String JSONKey;
  String JSONValue;
  RowMaker({
    required this.JSONKey,
    required this.JSONValue,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const
      EdgeInsets.all(7),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            JSONKey,
            style: const TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              // fontSize: 18,
            ),
          ),
          Text(
            JSONValue,
            style: const TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.normal,
              // fontSize: 18,
            ),
          ),
        ],
      ),
    );
  }
}
