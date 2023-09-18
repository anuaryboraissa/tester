import 'package:erisiti/src/constants/styles/style.dart';
import 'package:erisiti/src/features/screens/dashboard/features/home/components/card.dart';
import 'package:erisiti/src/features/screens/dashboard/features/home/components/charts/charts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../services/database/modalHelpers/receipt_helper.dart';
import '../../../Business/items/bloc/register_service_bloc.dart';

class HomeBody extends StatefulWidget {
  const HomeBody({super.key, required this.homeBloc, required this.tinNumber});
  final String tinNumber;
  final RegisterServiceBloc homeBloc;

  @override
  State<HomeBody> createState() => _HomeBodyState();
}

class _HomeBodyState extends State<HomeBody> {
  String numberOfReceipts = "0";
  double totalAmount = 0.0;
  double taxAmount = 0.0;

  bool offlineLoaded = false;

  @override
  void initState() {
    widget.homeBloc.add(FindUserReceiptByTinEvent(widget.tinNumber));
    super.initState();
  }

  findOfflineReceipts() {
    ReceiptHelper().queryReceiptByTinNumber(widget.tinNumber).then((value) {
      setState(() {
        numberOfReceipts = value.length.toString();
        offlineLoaded = true;
        value.forEach((element) {
          print("tozo is ${element!.tozo} amount ${element.amount}");
          taxAmount = (element.tozo + taxAmount);
          totalAmount = (element.amount + totalAmount);
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RegisterServiceBloc, RegisterServiceState>(
      bloc: widget.homeBloc,
      listener: (context, state) {
        if (state is FindUserReceiptByTinState) {
          if (state.error && state.message.contains("Network is unreachable")) {
            // print("Network mzeee");
            findOfflineReceipts();
          } else {
            numberOfReceipts = state.receipts['totalReceipts'].toString();
            totalAmount = state.receipts['totalAmount'];
            taxAmount = state.receipts['taxAmount'];
          }
        }
      },
      builder: (context, state) {
        return (state is! FindUserReceiptByTinState)
            ? const CircularProgressIndicator()
            : !state.error || offlineLoaded
                ? Container(
                    margin: const EdgeInsets.only(left: 15, right: 15),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        //graphs

                        ItemCard(
                          amount: numberOfReceipts,
                          icon: const Icon(
                            Icons.receipt_outlined,
                            size: 35,
                            color: ApplicationStyles.realAppColor,
                          ),
                          title: 'Number of receipts',
                        ),
                        ItemCard(
                          amount: taxAmount.toString(),
                          icon: const Icon(
                            Icons.casino_rounded,
                            size: 35,
                            color: ApplicationStyles.realAppColor,
                          ),
                          title: 'Tax Amount',
                        ),
                        ItemCard(
                          amount: totalAmount.toString(),
                          icon: const Icon(
                            Icons.attach_money_rounded,
                            size: 35,
                            color: ApplicationStyles.realAppColor,
                          ),
                          title: 'Total Amount',
                        ),
                        const RecentReceiptDescription()
                      ],
                    ),
                  )
                : Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "Network Error!",
                          style: TextStyle(color: Colors.red),
                        ),
                        TextButton(
                            onPressed: () {
                              // widget.homeBloc
                              //     .add(HomeInitializeEvent(widget.tinNumber));
                            },
                            child: const Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [Icon(Icons.refresh), Text("Refresh")],
                            )),
                      ],
                    ),
                  );
      },
    );
  }
}
