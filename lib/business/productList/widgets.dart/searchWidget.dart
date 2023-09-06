import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SearchWidget extends StatelessWidget {
  final String hintText;
  const SearchWidget({
    super.key,
    required this.result,
    required this.hintText,
  });
  final Function(String query) result;

  @override
  Widget build(BuildContext context) {
    String searchData = "";
    return Padding(
      padding: const EdgeInsets.only(right: 15, left: 15),
      child: TextFormField(
        initialValue: searchData,
        onChanged: (value) {
          result(value);
        },
        decoration: InputDecoration(
            enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(width: 0, color: Colors.grey),
              borderRadius: BorderRadius.circular(21),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(width: 3, color: Color(0xFF0081A0)),
              borderRadius: BorderRadius.circular(21),
            ),
            hintText: hintText,
            border: const OutlineInputBorder(),
            prefixIcon: const Icon(
              CupertinoIcons.search,
              color: Color(0xFF0081A0),
            ),
            suffixIcon: searchData.isNotEmpty
                ? IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      CupertinoIcons.clear,
                      color: Color(0xFF0081A0),
                    ))
                : null),
      ),
    );
  }
}
