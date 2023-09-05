import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:erisiti/src/constants/data/receipts.dart';
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
    List<Receipt> allReceipts = AvailableReceipts.receipts
        .map((e) => Receipt(
            issuer: e["issuer"]!, address: e['address']!, phone: e["Phone"]!))
        .toList();
    List<Receipt> matchedReceipts = allReceipts
        .where((element) =>
            (element.address.toLowerCase().contains(query.toLowerCase())) ||
            (element.issuer.toLowerCase().contains(query.toLowerCase())) ||
            (element.phone.toLowerCase().contains(query.toLowerCase())))
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
      final response = await SearchReceiptService()
          .searchReceipt(event.tinNumber, event.startDate, event.endDate);
      Map receiptOverview;
      print("response is ${response['message']}");
      if (response['status'] == 'success') {
        receiptOverview = {
          "totalReceipts": response['noOfReceipts'],
          "taxAmount": response['taxAmount'],
          "totalAmount": response['totalAmount']
        };
        // ignore: use_build_context_synchronously
        Navigator.of(event.context).push(MaterialPageRoute(
          builder: (context) => ReceiptPage(receiptsOverview: receiptOverview),
        ));
        emit(SubmitDateSuccessState());
      } else if (response['message']
          .toString()
          .contains("Network is unreachable")) {
        Fluttertoast.showToast(msg: "Unable to process request");
        Fluttertoast.showToast(msg: "Network is unreachable");
      } else {
        receiptOverview = {
          "totalReceipts": "0",
          "taxAmount": "0",
          "totalAmount": "0"
        };
        // ignore: use_build_context_synchronously
        Navigator.of(event.context).push(MaterialPageRoute(
          builder: (context) => ReceiptPage(receiptsOverview: receiptOverview),
        ));
        emit(SubmitDateSuccessState());
      }

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
