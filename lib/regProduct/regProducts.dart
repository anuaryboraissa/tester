import 'package:erisiti/regProduct/widgets/priceUnitDropDownMenu.dart';
import 'package:erisiti/regProduct/widgets/productInputWidget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:supercharged/supercharged.dart';

import '../src/constants/styles/style.dart';
import 'widgets/decimalProductWidget.dart';

class RegProducts extends StatefulWidget {
  const RegProducts({super.key});

  @override
  State<RegProducts> createState() => _RegProductsState();
}

class _RegProductsState extends State<RegProducts> {
  bool validForm = false;
  late String pName;
  late double pPrice;
  void validate() {
    if (pName.isNotEmpty && pPrice != null) {
      validForm = true;
    } else if (pName.isEmpty || pPrice.toString().isEmpty) {
      validForm = false;
    }
  }

  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Container(
          padding: const EdgeInsets.all(20),
          alignment: Alignment.bottomLeft,
          child: const Text("Register Products"),
        ),
        titleTextStyle: const TextStyle(
          fontFamily: 'Popins',
          fontSize: 20.0,
          fontWeight: FontWeight.w900,
        ),
        backgroundColor: ApplicationStyles.realAppColor,
        toolbarHeight: 70.0,
        elevation: 5.0,
        titleSpacing: 7.0,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(30),
          ),
        ),
      ),
      body: Container(
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  onChanged: (value) {
                    setState(() {
                      pName = value;
                      validate();
                    });
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please Fill this field broh';
                    }
                  },
                  decoration: InputDecoration(
                      label: Text("Product Name"),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(width: 3, color: Colors.cyan),
                          borderRadius: BorderRadius.circular(21)),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          width: 3,
                          color: Colors.cyan,
                        ),
                        borderRadius: BorderRadius.circular(21),
                      )),
                ),
              ),
              PriceUnit(),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  keyboardType: TextInputType.number,
                  onChanged: (value) {
                    setState(() {
                      pPrice = value.toDouble()!;
                      validate();
                    });
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please Fill this field';
                    }
                  },
                  decoration: InputDecoration(
                      label: Text("Product Price"),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(width: 3, color: Colors.cyan),
                          borderRadius: BorderRadius.circular(21)),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          width: 3,
                          color: Colors.cyan,
                        ),
                        borderRadius: BorderRadius.circular(21),
                      )),
                ),
              ),
              decimalProduct(),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: validForm ? Colors.cyan : Colors.grey,
        onPressed: () {
          if (_formKey.currentState!.validate()) {
            print("Valid");
          }
        },
        child: validForm
            ? Icon(
                CupertinoIcons.add,
                color: Colors.white,
              )
            : Icon(
                CupertinoIcons.hammer,
                color: Colors.white,
              ),
      ),
    );
  }
}
