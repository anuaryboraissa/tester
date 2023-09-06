import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BusinessWidget extends StatelessWidget {
  final String businessName;
  final String brelaNo;
  const BusinessWidget({
    required this.businessName,
    required this.brelaNo,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 15, right: 15),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Card(
            shadowColor: Colors.white,
            elevation: 8,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(20)),
            ),
            child: Container(
              padding: const EdgeInsets.all(15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          businessName,
                          style: const TextStyle(
                              fontFamily: "Popins",
                              color: Color(0xFF0081A0),
                              fontSize: 21,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          brelaNo,
                          style: const TextStyle(
                              fontFamily: "Popins",
                              color: Colors.black,
                              fontSize: 14,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                  const Icon(
                    CupertinoIcons.forward,
                    color: Color(0xFF0081A0),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
