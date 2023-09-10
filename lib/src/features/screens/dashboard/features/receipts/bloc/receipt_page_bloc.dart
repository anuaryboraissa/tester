import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:erisiti/src/constants/data/receipts.dart';
import 'package:erisiti/src/features/services/enpoints/get_user_receipt_by_tin.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:intl/intl.dart';
import 'package:meta/meta.dart';

import '../../../../../services/enpoints/search_receipt.dart';
import '../modal/receipt.dart';
import '../receipt.dart';

part 'receipt_page_event.dart';
part 'receipt_page_state.dart';

class ReceiptPageBloc extends Bloc<ReceiptPageEvent, ReceiptPageState> {
  ReceiptPageBloc() : super(ReceiptPageInitial()) {
    on<ReceiptPageEvent>((event, emit) {});
    on<SearchReceiptEvent>(searchReceiptEvent);
    on<ValidateDateEvent>(validateDateEvent);

    on<ValidateDateDifference>(validateDateDifference);
    on<SubmitDateEvent>(submitDateEvent);
    on<ValidateOption>(validateOption);
  }

  FutureOr<void> searchReceiptEvent(
      SearchReceiptEvent event, Emitter<ReceiptPageState> emit) {
    String query = event.query;
    List allReceipts = event.receipts;
    List matchedReceipts = allReceipts
        .where((element) => element['receiptNumber']
            .toString()
            .toLowerCase()
            .contains(query.toLowerCase()))
        .toList();

    emit(ReceiptSearchState(query, receipts: matchedReceipts));
  }

  FutureOr<void> validateDateEvent(
      ValidateDateEvent event, Emitter<ReceiptPageState> emit) {
    try {
      print("date to validate  ${event.date} *****************");
      DateTime date = DateTime.parse(event.date.replaceAll(" ", ""));

      print("valid step 1>>>>>>>>>>>>>> $date");
      var now = DateFormat("yyyy-MM-yy").format(DateTime.now());
      final duration =
          DateTime.parse(now).difference(DateTime.parse(event.date));
      if (duration.inDays >= 0) {
        print("valid step 2>>>>>>>>>>>>>>");
        emit(ValidatedDateState(valid: true));
      } else {
        print("invalid step 22 >>>>>>>>>>>>>>");
        emit(ValidatedDateState(valid: false));
      }
    } catch (e) {
      emit(ValidatedDateState(valid: false));
      print("invalid step 11 >>>>>>>>>>>>>>");
    }
  }

  FutureOr<void> validateDateDifference(
      ValidateDateDifference event, Emitter<ReceiptPageState> emit) {
    try {
      final duration = DateTime.parse(event.endDate)
          .difference(DateTime.parse(event.startDate));
      if (duration.inDays >= 0) {
        emit(ValidatedDateDifferenceState(valid: true));
      } else {
        emit(ValidatedDateDifferenceState(valid: false));
      }
    } catch (e) {
      emit(ValidatedDateDifferenceState(valid: false));
    }
  }

  FutureOr<void> submitDateEvent(
      SubmitDateEvent event, Emitter<ReceiptPageState> emit) async {
    try {
      print("tin number is ${event.tinNumber}");
      final result = await FindUserReceiptService.getUserReceiptByTin(
          int.parse(event.tinNumber));
      if (result['code'] == 5000) {
        List receipts = result['data'];
        print("before ${receipts.length}");
        List filteredReceipts = receipts
            .where((e) =>
                DateTime.parse(e['createdAt'].toString().replaceRange(
                            e['createdAt'].toString().indexOf("T"),
                            e['createdAt'].toString().length,
                            ""))
                        .difference(DateTime.parse(event.startDate))
                        .inDays >=
                    0 &&
                DateTime.parse(event.endDate)
                        .difference(DateTime.parse(e['createdAt']
                            .toString()
                            .replaceRange(
                                e['createdAt'].toString().indexOf("T"),
                                e['createdAt'].toString().length,
                                "")))
                        .inDays >=
                    0)
            .toList();
        print("response 2 ${filteredReceipts.length}");
        int totalNumberOfReceipts = filteredReceipts.length;
        print("s 1");
        int taxAmount = 0;
        int totalAmount = 0;
        filteredReceipts.forEach((element) {
          print("s 2");
          taxAmount = element['tozo'] + taxAmount;
          print("s kn");
          totalAmount = element['amount'] + totalAmount;
          print("s k");
        });
        print("s 4");
        Map receiptOverview = {
          "totalReceipts": totalNumberOfReceipts,
          "taxAmount": taxAmount,
          "totalAmount": totalAmount,
          "receipts": filteredReceipts
        };
        print("map $receiptOverview");
        // ignore: use_build_context_synchronously
        Navigator.of(event.context).push(MaterialPageRoute(
          builder: (context) => ReceiptPage(receiptsOverview: receiptOverview),
        ));
        emit(SubmitDateSuccessState());
        // emit(FindUserReceiptByTinState(result['data'], false, "Success"));
      } else {
        // emit(FindUserReceiptByTinState(const [], true, result['messages']));
        Fluttertoast.showToast(msg: "Unable to process request");
      }

      // final response = await SearchReceiptService()
      //     .searchReceipt(event.tinNumber, event.startDate, event.endDate);
      // Map receiptOverview;
      // print("response is ${response['message']}");
      // if (response['status'] == 'success') {
      //   receiptOverview = {
      //     "totalReceipts": response['noOfReceipts'],
      //     "taxAmount": response['taxAmount'],
      //     "totalAmount": response['totalAmount']
      //   };
      // ignore: use_build_context_synchronously
      // } else if (response['message']
      //     .toString()
      //     .contains("Network is unreachable")) {
      //   Fluttertoast.showToast(msg: "Unable to process request");
      //   Fluttertoast.showToast(msg: "Network is unreachable");
      // } else {
      //   receiptOverview = {
      //     "totalReceipts": "0",
      //     "taxAmount": "0",
      //     "totalAmount": "0"
      //   };
      //   // ignore: use_build_context_synchronously
      //   Navigator.of(event.context).push(MaterialPageRoute(
      //     builder: (context) => ReceiptPage(receiptsOverview: receiptOverview),
      //   ));
      //   emit(SubmitDateSuccessState());
      // }

      // ignore: use_build_context_synchronously
    } catch (e) {
      Fluttertoast.showToast(msg: "An Error Occurred");
      Fluttertoast.showToast(msg: "$e");
    }
  }

  FutureOr<void> validateOption(
      ValidateOption event, Emitter<ReceiptPageState> emit) {
    emit(ValidateOptionState(event.option));
  }
}
