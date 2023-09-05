import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RegisterProduct extends StatefulWidget {
  const RegisterProduct({super.key});

  @override
  State<RegisterProduct> createState() => _RegisterProductState();
}

class _RegisterProductState extends State<RegisterProduct> {
  bool isRationalProduct = false;
  var items = ["Kilogram", "Litre", "Number"];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.cyan,
        title: Text(
          "Register Product",
          style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 21),
        ),
      ),
      body: Form(
        child: Column(
          children: [
            TextFormField(
              decoration: InputDecoration(
                label: Text(
                  "Product Name"
                ),
                border: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.cyan
                  )
                )
              ),
            ),
            DropdownButton(
              hint: Text('Choose Unit Measurement'),
              items: items.map((String items) {
                return DropdownMenuItem(value: items, child: Text(items));
              }).toList(),
              onChanged: (value) {},
            ),
            Row(
              children: [
                Checkbox(
                  activeColor: Colors.cyan,
                  value: isRationalProduct,
                  onChanged: (value) {
                    setState(() {
                      isRationalProduct = !isRationalProduct;
                    });
                  },
                ),
                Text(
                  "Product Unit may be fractional"
                )
              ],
            ),
            TextFormField(
              decoration: InputDecoration(
                hintText: "Product Price",
              ),
            ),
          ],
        ),
      ),
    );
  }
}
