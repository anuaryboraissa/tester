import 'package:erisiti/src/constants/styles/style.dart';
import 'package:flutter/material.dart';

class TipsCard extends StatelessWidget {
  const TipsCard(
      {super.key,
      required this.image,
      required this.title,
      required this.description,
      required this.size,
      required this.callback,
      required this.itemId});
  final String image;
  final String title;
  final String description;
  final Size size;
  final String itemId;
  final Function(String itemID) callback;

  @override
  Widget build(BuildContext context) {
    return Material(
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: () {
          callback(itemId);
        },
        child: Container(
            margin: const EdgeInsets.only(top: 5),
            padding: const EdgeInsets.all(5),
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(10)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  // height: size.height * .24,
                  // width: size.width * .14,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: Image.asset(
                    image,
                    height: size.height * .14,
                    width: size.width * .21,
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(
                  width: size.width * .56,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: const TextStyle(
                            fontSize: 17, fontWeight: FontWeight.bold),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Text(
                          description,
                          style: const TextStyle(fontSize: 13),
                        ),
                      )
                    ],
                  ),
                ),
                const Icon(
                  Icons.arrow_forward_ios_rounded,
                  size: 15,
                  color: ApplicationStyles.realAppColor,
                )
              ],
            )),
      ),
    );
  }
}
