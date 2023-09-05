import 'package:flutter/material.dart';

// ignore: must_be_immutable
class actionButton extends StatelessWidget {
  String title;
  Color bgColor;
  actionButton({
    super.key,
    required this.animate,
    required this.title,
    required this.bgColor
  });

  final bool animate;

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      duration: const Duration(milliseconds: 1500),
      opacity: animate ? 1.0 : 0.0,
      child: ElevatedButton(
        style: ButtonStyle(
          elevation: MaterialStatePropertyAll(7),
          backgroundColor: MaterialStatePropertyAll(bgColor),
        ),
        onPressed: () {},
        child: Text(title),
      ),
    );
  }
}
