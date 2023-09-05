// ignore_for_file: library_prefixes

import 'package:erisiti/business/productList/helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../registerProducts/registerProducts.dart';
import 'widgets.dart/productsActionButton.dart';

class ProductList extends StatefulWidget {
  const ProductList({super.key});

  @override
  State<ProductList> createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
  @override
  void initState() {
    super.initState();
    readJSON();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.cyan,
        title: const Text(
          "The Business",
          style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 21),
        ),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const RegisterProduct(),
                    ));
              },
              icon: const Icon(
                CupertinoIcons.add,
                color: Colors.white,
              )),
        ],
      ),
      body: productList.isEmpty
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : ListView.builder(
              itemCount: productList.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 21),
                    decoration: BoxDecoration(
                        color: Colors.cyan.shade700,
                        borderRadius: BorderRadius.circular(21),
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.black,
                            blurRadius: 7.0,
                          )
                        ]),
                    child: Column(
                      children: [
                        ListTile(
                          leading: CircleAvatar(
                            backgroundColor: Colors.white,
                            child: Text(
                              "${index + 1}",
                              style: const TextStyle(
                                  color: Colors.cyan,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 21),
                            ),
                          ),
                          title: Text(
                            productList[index]['name'].toString(),
                            style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 21),
                          ),
                          trailing: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text(
                                "${productList[index]['currency'].toString()} ${productList[index]['price'].toString()}",
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14),
                              ),
                              Text(
                                "Per ${productList[index]['unit'].toString()}",
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14),
                              ),
                            ],
                          ),
                        ),
                        const productsActionButtons(),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }

  List<dynamic> productList = [];
  readJSON() {
    ProductHelper.getProducts().then((value) {
      setState(() {
        productList = value;
      });
    });
  }
}
