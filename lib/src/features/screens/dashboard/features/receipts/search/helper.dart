import 'package:erisiti/src/features/screens/dashboard/features/receipts/bloc/receipt_page_bloc.dart';

class ReceiptDateSearchHelper {
  static void sendChangeAction(
      String startDate, String endDate, ReceiptPageBloc receiptPageBloc) {
    if (startDate.isNotEmpty && endDate.isNotEmpty) {
      receiptPageBloc
          .add(ValidateDateDifference(startDate: startDate, endDate: endDate));
    } else if (startDate.isNotEmpty) {
      receiptPageBloc.add(ValidateDateEvent(date: startDate));
    } else if (endDate.isNotEmpty) {
      receiptPageBloc.add(ValidateDateEvent(date: endDate));
    } else {
      print("nothing");
    }
  }

  static String? validateDate(String? date) {
    return null;
  }
}
