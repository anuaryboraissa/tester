import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class ProductWidget extends StatelessWidget {
  String productName;
  String productUnit;
  String productCurrency;
  String productAmount;
  ProductWidget({
    required this.productName,
    required this.productUnit,
    required this.productCurrency,
    required this.productAmount,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 15, right: 15),
      child: Card(
        shadowColor: Colors.white,
        elevation: 8,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(21)),
        ),
        child: Container(
          padding: const EdgeInsets.all(15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    productName,
                    style: TextStyle(
                        fontFamily: "Popins",
                        color: Color(0xFF0081A0),
                        fontSize: 21,
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "$productUnit @ $productCurrency $productAmount/=",
                    style: TextStyle(
                        fontFamily: "Popins",
                        color: Colors.black,
                        fontSize: 14,
                        fontWeight: FontWeight.bold),
                  )
                ],
              ),
              Icon(
                CupertinoIcons.backward,
                color: Color(0xFF0081A0),
              )
            ],
          ),
        ),
      ),
    );
  }
}
