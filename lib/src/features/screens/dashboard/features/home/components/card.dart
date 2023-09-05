import 'package:flutter/material.dart';

import '../../../../../../constants/styles/style.dart';

class ItemCard extends StatelessWidget {
  const ItemCard(
      {super.key,
      required this.title,
      required this.amount,
      required this.icon});
  final String title;
  final String amount;
  final Icon icon;

  @override
  Widget build(BuildContext context) {
    return Card(
      shadowColor: Colors.white,
      elevation: 8,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20))),
      child: Container(
        padding: const EdgeInsets.all(15),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          // crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    title,
                    style: ApplicationStyles.getStyle(true, 16, null),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    amount,
                    style: ApplicationStyles.getStyle(
                        true, 23, ApplicationStyles.realAppColor),
                  ),
                )
              ],
            ),
            IconButton(onPressed: () {}, icon: icon)
          ],
        ),
      ),
    );
  }
}
