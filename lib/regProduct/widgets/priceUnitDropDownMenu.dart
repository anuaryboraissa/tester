import 'package:flutter/material.dart';

class PriceUnit extends StatefulWidget {
  const PriceUnit({super.key});

  @override
  State<PriceUnit> createState() => _PriceUnitState();
}

class _PriceUnitState extends State<PriceUnit> {
  String _isSelected = "";
  var unit = [
    'Select Product Unit',
    'Kilogram',
    'Litre',
    'Number',
  ];
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: DropdownButtonFormField(
        value: unit[0],
        items: unit.map((String unit) {
          return DropdownMenuItem(value: unit, child: Text(unit));
        }).toList(),
        onChanged: (value) {
          setState(() {
            _isSelected = value as String;
            print("Selected Unit is : $_isSelected");
          });
        },
        decoration: InputDecoration(
            border: OutlineInputBorder(),
            enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.cyan, width: 3),
                borderRadius: BorderRadius.circular(21)),
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.cyan,
                  width: 3,
                ),
                borderRadius: BorderRadius.circular(21))),
      ),
    );
  }
}
