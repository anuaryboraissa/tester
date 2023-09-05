import 'package:erisiti/src/constants/styles/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class OnboardPage extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String description;
  final String label;
  const OnboardPage(
      {super.key,
      required this.imageUrl,
      required this.title,
      required this.description,
      required this.label});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        margin: const EdgeInsets.only(top: 25, left: 25, right: 25),
        padding: const EdgeInsets.only(top: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 20.0, bottom: 15),
              child: SvgPicture.asset(
                imageUrl,
                semanticsLabel: label,
                width: 220,
                height: 220,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 15.0, bottom: 15),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0, bottom: 8),
                    child: Text(
                      title,
                      style: ApplicationStyles.getStyle(true, 21, null),
                    ),
                  ),
                  const SizedBox(
                    height: 6,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0, bottom: 8),
                    child: Text(
                      description,
                      style: ApplicationStyles.getStyle(false, 17, null),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
