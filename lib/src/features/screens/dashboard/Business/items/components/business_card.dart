import 'package:erisiti/src/constants/styles/style.dart';
import 'package:flutter/material.dart';

class BusinessListCard extends StatelessWidget {
  const BusinessListCard(
      {super.key,
      required this.title,
      required this.businessNo,
      required this.registered,
      required this.tapped});
  final String title;
  final String businessNo;
  final bool registered;
  final Function() tapped;

  @override
  Widget build(BuildContext context) {
    return Material(
      child: InkWell(
        onTap: tapped,
        child: Container(
          margin: const EdgeInsets.only(left: 10, right: 10, bottom: 4),
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(10)),
          child: ListTile(
            title: Text(title
                // style: const TextStyle(fontWeight: FontWeight.bold),
                ),
            subtitle: Text(
              businessNo,
              style: const TextStyle(
                color: ApplicationStyles.realAppColor,
              ),
            ),
            trailing: Icon(
              !registered ? Icons.arrow_forward_ios_outlined : Icons.check,
              size: 20,
            ),
          ),
        ),
      ),
    );
  }
}
