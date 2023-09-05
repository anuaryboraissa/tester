import 'package:erisiti/src/constants/styles/style.dart';
import 'package:flutter/material.dart';

class MoreTopBar extends StatelessWidget {
  const MoreTopBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 5, left: 20, right: 20),
      width: double.infinity,
      decoration: const BoxDecoration(
          boxShadow: [
            BoxShadow(offset: Offset(3, 3), blurRadius: 2, color: Colors.grey)
          ],
          color: ApplicationStyles.realAppColor,
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(50),
              bottomRight: Radius.circular(50))),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        // crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Icon(
            Icons.person_2,
            size: MediaQuery.of(context).size.height * .14,
            color: Colors.white,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Anuary Iddi Issa",
                style: ApplicationStyles.getStyle(true, 12, Colors.white),
              ),
              const SizedBox(
                height: 7,
              ),
              Text(
                "TIN: 124363278323",
                style: ApplicationStyles.getStyle(true, 12, Colors.white),
              ),
              const SizedBox(
                height: 7,
              ),
              Text(
                "Phone: 0673627827",
                style: ApplicationStyles.getStyle(true, 12, Colors.white),
              ),
            ],
          )
        ],
      ),
    );
  }
}
