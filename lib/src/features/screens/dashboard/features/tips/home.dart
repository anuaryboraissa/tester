import 'components/body.dart';
import 'components/topBar.dart';
import 'package:flutter/material.dart';

class TipsHome extends StatefulWidget {
  const TipsHome({super.key});

  @override
  State<TipsHome> createState() => _TipsHomeState();
}

class _TipsHomeState extends State<TipsHome> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            margin: const EdgeInsets.only(top: 15, left: 15, right: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                HomeBusinessTopBar(
                  size: size,
                ),
                HomeTipsBody(size: size)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
