import 'package:erisiti/business/businessList/widget/businessList.dart';

import 'package:erisiti/src/features/screens/dashboard/Business/RegisterBusiness/register.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../src/features/screens/dashboard/Business/items/bloc/register_service_bloc.dart';

class BusinessList extends StatefulWidget {
  const BusinessList({super.key, required this.tinNumber});
  final String tinNumber;

  @override
  State<BusinessList> createState() => _BusinessListState();
}

RegisterServiceBloc myBloc = RegisterServiceBloc();

class _BusinessListState extends State<BusinessList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: const Text(
          "My Business",
          style: TextStyle(
              color: Colors.black, fontWeight: FontWeight.bold, fontSize: 21),
        ),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(
                  builder: (context) => RegisterBusiness(
                      tinNumber: widget.tinNumber, initially: false),
                ))
                    .then((value) {
                  myBloc.add(FindBusinessEvent(widget.tinNumber));
                });
              },
              icon: const Icon(
                CupertinoIcons.add,
                color: Color(0xFF0081A0),
              )),
        ],
      ),
      body: UserBusinessListWidget(
        tinNumber: widget.tinNumber,
        businessBloc: (RegisterServiceBloc bloc) {
          myBloc = bloc;
        },
      ),
    );
  }
}
