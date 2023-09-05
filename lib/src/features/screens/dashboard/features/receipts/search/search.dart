import 'package:erisiti/src/constants/styles/style.dart';
import 'package:erisiti/src/features/bloc/global_bloc.dart';
import 'package:erisiti/src/features/screens/dashboard/features/receipts/bloc/receipt_page_bloc.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';

import 'helper.dart';

class SearchReceiptPage extends StatefulWidget {
  const SearchReceiptPage({super.key});

  @override
  State<SearchReceiptPage> createState() => _SearchReceiptPageState();
}

class _SearchReceiptPageState extends State<SearchReceiptPage> {
  TextEditingController startDate = TextEditingController();
  TextEditingController endDate = TextEditingController();

  ReceiptPageBloc receiptPageBloc = ReceiptPageBloc();
  List<String> ranges = ["Weekly", "Monthly", "Yearly", "Other"];
  String selected = "";
  @override
  Widget build(BuildContext context) {
    final globalState = context.read<GlobalBloc>().state;
    return Scaffold(
        body: SingleChildScrollView(
      child: BlocBuilder<ReceiptPageBloc, ReceiptPageState>(
        bloc: receiptPageBloc,
        builder: (context, state) {
          print("current state is ${state.runtimeType}");
          if (state is ValidatedDateState) {
            if (!(state).valid) {
              Fluttertoast.showToast(msg: "Date is Not valid");
            }
          } else if (state is ValidateOptionState) {
            selected = state.option;
            print("option emitted ${state.option}");
          }

          if (state is SubmitDateSuccessState) {
            startDate.clear();
            endDate.clear();
            Fluttertoast.showToast(msg: "submit successfully");
          }
          return Container(
            margin: const EdgeInsets.only(bottom: 25, left: 25, right: 25),
            padding: const EdgeInsets.only(top: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: SvgPicture.asset(
                    "assets/images/undraw_web_search_re_efla.svg",
                    semanticsLabel: "search",
                    width: ApplicationStyles.getScreenWidth(context) * .35,
                    height: ApplicationStyles.getScreenHeight(context) * .34,
                  ),
                ),
                Text(
                  "FIND YOUR RECEIPT",
                  style: ApplicationStyles.getStyle(
                      true, 22, ApplicationStyles.realAppColor),
                ),
                const SizedBox(
                  height: 20,
                ),
                Container(
                  padding: const EdgeInsets.all(10),
                  width: double.infinity,
                  decoration: BoxDecoration(
                      border: Border.all(color: ApplicationStyles.realAppColor),
                      borderRadius: BorderRadius.circular(20)),
                  child: DropdownButtonFormField(
                    // alignment: Alignment.center,
                    hint: const Text("Choose an option"),
                    decoration: const InputDecoration.collapsed(hintText: ""),
                    items: ranges
                        .map((index) => DropdownMenuItem(
                              value: index,
                              child: Text(index),
                            ))
                        .toList(),
                    onChanged: (value) {
                      receiptPageBloc.add(ValidateOption(value!));
                    },
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                if (selected == ranges[3])
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Start Date",
                            style: ApplicationStyles.getStyle(true, 18, null),
                          ),
                          SizedBox(
                            height: ApplicationStyles.getScreenHeight(context) *
                                .11,
                            width:
                                ApplicationStyles.getScreenWidth(context) * .41,
                            child: TextFormField(
                              onChanged: (value) {
                                ReceiptDateSearchHelper.sendChangeAction(
                                    startDate.text,
                                    endDate.text,
                                    receiptPageBloc);
                              },
                              controller: startDate,
                              decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(21)),
                                  prefixIcon: IconButton(
                                      onPressed: () async {
                                        DateTime? startPickedDate =
                                            await showDatePicker(
                                                builder: (context, child) {
                                                  return Theme(
                                                    data: Theme.of(context)
                                                        .copyWith(
                                                      colorScheme:
                                                          const ColorScheme
                                                              .light(
                                                        primary: ApplicationStyles
                                                            .realAppColor, // <-- SEE HERE
                                                        onPrimary: Colors
                                                            .white, // <-- SEE HERE
                                                        onSurface: Color.fromARGB(
                                                            255,
                                                            66,
                                                            125,
                                                            145), // <-- SEE HERE
                                                      ),
                                                      textButtonTheme:
                                                          TextButtonThemeData(
                                                        style: TextButton
                                                            .styleFrom(
                                                          primary: ApplicationStyles
                                                              .realAppColor, // button text color
                                                        ),
                                                      ),
                                                    ),
                                                    child: child!,
                                                  );
                                                },
                                                context: context,
                                                initialDate: DateTime.now(),
                                                firstDate: DateTime.parse(
                                                    "2022-01-01"),
                                                lastDate: DateTime(2100));
                                        if (startPickedDate != null) {
                                          String formattedDate =
                                              DateFormat('yyyy-MM-dd')
                                                  .format(startPickedDate);
                                          setState(() {
                                            startDate.text =
                                                formattedDate; //set output date to TextField value.
                                          });
                                          ReceiptDateSearchHelper
                                              .sendChangeAction(
                                                  startDate.text,
                                                  endDate.text,
                                                  receiptPageBloc);
                                        }
                                      },
                                      icon: const Icon(Icons.calendar_month))),
                            ),
                          )
                        ],
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "End Date",
                            style: ApplicationStyles.getStyle(true, 18, null),
                          ),
                          SizedBox(
                            height: ApplicationStyles.getScreenHeight(context) *
                                .11,
                            width:
                                ApplicationStyles.getScreenWidth(context) * .4,
                            child: TextFormField(
                              onChanged: (value) {
                                ReceiptDateSearchHelper.sendChangeAction(
                                    startDate.text,
                                    endDate.text,
                                    receiptPageBloc);
                              },
                              controller: endDate,
                              decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(21)),
                                  prefixIcon: IconButton(
                                      onPressed: () async {
                                        DateTime? startPickedDate =
                                            await showDatePicker(
                                          context: context,
                                          initialDate: DateTime.now(),
                                          firstDate:
                                              DateTime.parse("2022-01-02"),
                                          lastDate: DateTime(2100),
                                          builder: (context, child) {
                                            return Theme(
                                              data: Theme.of(context).copyWith(
                                                colorScheme:
                                                    const ColorScheme.light(
                                                  primary: ApplicationStyles
                                                      .realAppColor, // <-- SEE HERE
                                                  onPrimary: Colors
                                                      .white, // <-- SEE HERE
                                                  onSurface: Color.fromARGB(
                                                      255,
                                                      66,
                                                      125,
                                                      145), // <-- SEE HERE
                                                ),
                                                textButtonTheme:
                                                    TextButtonThemeData(
                                                  style: TextButton.styleFrom(
                                                    primary: ApplicationStyles
                                                        .realAppColor, // button text color
                                                  ),
                                                ),
                                              ),
                                              child: child!,
                                            );
                                          },
                                        );
                                        if (startPickedDate != null) {
                                          String formattedDate =
                                              DateFormat('yyyy-MM-dd')
                                                  .format(startPickedDate);
                                          setState(() {
                                            endDate.text =
                                                formattedDate; //set output date to TextField value.
                                          });
                                          ReceiptDateSearchHelper
                                              .sendChangeAction(
                                                  startDate.text,
                                                  endDate.text,
                                                  receiptPageBloc);
                                        }
                                      },
                                      icon: const Icon(Icons.calendar_month))),
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                const SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        shadowColor: Colors.grey,
                        fixedSize: Size(
                            ApplicationStyles.getScreenWidth(context) * .5,
                            ApplicationStyles.getScreenHeight(context) * .08),
                        minimumSize: const Size(100, 60),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                        backgroundColor: ApplicationStyles.realAppColor,
                        elevation: 5,
                        padding: const EdgeInsets.all(15)),
                    onPressed: selected.isNotEmpty && selected != ranges[3] ||
                            (startDate.text.isNotEmpty &&
                                endDate.text.isNotEmpty)
                        ? () {
                            if (state is ValidatedDateDifferenceState) {
                              if ((state).valid) {
                                receiptPageBloc.add(SubmitDateEvent(
                                    context: context,
                                    endDate: endDate.text,
                                    startDate: startDate.text,
                                    tinNumber: (globalState
                                            as SuccessInitializationState)
                                        .loggedUser!
                                        .tinNumber));
                              } else {
                                Fluttertoast.showToast(
                                    msg: "Date is Not valid");
                              }
                            } else {
                              Fluttertoast.showToast(
                                  msg: "Something wrong  ${state.runtimeType}");
                            }
                          }
                        : null,
                    child: Text(
                      "SUBMIT",
                      style: ApplicationStyles.getStyle(true, 22, Colors.white),
                    ))
              ],
            ),
          );
        },
      ),
    ));
  }
}
