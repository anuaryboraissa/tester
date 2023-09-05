import 'package:erisiti/src/constants/styles/style.dart';
import 'package:flutter/material.dart';

class MoreBody extends StatefulWidget {
  const MoreBody({super.key});

  @override
  State<MoreBody> createState() => _MoreBodyState();
}

class _MoreBodyState extends State<MoreBody> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Card(
            margin: const EdgeInsets.all(10),
            shadowColor: Colors.white,
            elevation: 8,
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(30))),
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.all(5),
              child: ListTile(
                title: Text(
                  "Change Password",
                  style: ApplicationStyles.getStyle(
                      true, 14, ApplicationStyles.realAppColor),
                ),
                leading: const Icon(
                  Icons.fingerprint,
                  size: 18,
                  color: ApplicationStyles.realAppColor,
                ),
                trailing: const Icon(
                  Icons.arrow_forward_ios_outlined,
                  size: 18,
                  color: ApplicationStyles.realAppColor,
                ),
              ),
            ),
          ),
          Card(
            margin: const EdgeInsets.all(10),
            shadowColor: Colors.white,
            elevation: 8,
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(30))),
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.all(5),
              child: ListTile(
                title: Text(
                  "Web Portal",
                  style: ApplicationStyles.getStyle(
                      true, 14, ApplicationStyles.realAppColor),
                ),
                leading: const Icon(
                  Icons.camera,
                  size: 18,
                  color: ApplicationStyles.realAppColor,
                ),
                trailing: const Icon(
                  Icons.arrow_forward_ios_outlined,
                  size: 18,
                  color: ApplicationStyles.realAppColor,
                ),
              ),
            ),
          ),
          Card(
            margin: const EdgeInsets.all(10),
            shadowColor: Colors.white,
            elevation: 8,
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(30))),
            child: Container(
              padding: const EdgeInsets.all(5),
              width: double.infinity,
              child: ListTile(
                title: Text(
                  "Whatsapp Assistance",
                  style: ApplicationStyles.getStyle(
                      true, 14, ApplicationStyles.realAppColor),
                ),
                leading: const Icon(
                  Icons.message,
                  size: 18,
                  color: ApplicationStyles.realAppColor,
                ),
                trailing: const Icon(
                  Icons.arrow_forward_ios_outlined,
                  size: 18,
                  color: ApplicationStyles.realAppColor,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
