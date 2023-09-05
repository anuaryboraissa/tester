import 'package:flutter/material.dart';

// ignore: must_be_immutable
class ListTileWidget extends StatelessWidget {
  // Instance Variables of the class
  String title, subTitle;
  IconData leadingIcon, trailingIcon;
  Color? listTileColor, iconColor;

  //Constructor
  ListTileWidget({super.key, 
    required this.title,
    required this.subTitle,
    this.leadingIcon = Icons.label,
    this.trailingIcon = Icons.add,
    this.listTileColor,
    this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: iconColor,
          child: Icon(leadingIcon),
        ),
        title: Text(title),
        subtitle: Text(subTitle),
        trailing: Icon(trailingIcon),
        onTap: () {},
        tileColor: listTileColor,
      ),
    );
  }
}
