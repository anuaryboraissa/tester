import 'package:flutter/material.dart';
class HorizontalLine extends StatelessWidget {
  const HorizontalLine({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Divider(
      color: Color(0xFF0081A0),
      thickness: 1,
      height: 14,
      endIndent: 0,
      indent: 0,
    );
  }
}