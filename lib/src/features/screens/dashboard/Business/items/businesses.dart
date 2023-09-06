import 'package:erisiti/src/features/screens/dashboard/Business/RegisterBusiness/components/top_bar.dart';
import 'package:flutter/material.dart';

class RegisteredBusiness extends StatefulWidget {
  const RegisteredBusiness({super.key});

  @override
  State<RegisteredBusiness> createState() => _RegisteredBusinessState();
}

class _RegisteredBusinessState extends State<RegisteredBusiness> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Column(
        children: [
          BusinessTopBar(
              title: "Products",
              image: "assets/images/product.png",
              subTitle: "Registered Businesses")
        ],
      ),
    );
  }
}
