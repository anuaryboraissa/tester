import 'package:flutter/material.dart';

class HomeBusinessTopBar extends StatelessWidget {
  const HomeBusinessTopBar({super.key, required this.size});
  final Size size;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5),
      child: Column(
        children: [
          const Text(
            "Pro Tips for Getting the Most Out of Your Receipt App",
            style: TextStyle(fontSize: 23, fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: size.height * .01,
          ),
          const Text(
              "Lets control our finances through the app's features and guidance!"),
        ],
      ),
    );
  }
}
