part of 'receipt_page_bloc.dart';

@immutable
sealed class ReceiptPageEvent {}

class SearchReceiptEvent extends ReceiptPageEvent {
  final String query;
  final List receipts;
  SearchReceiptEvent({
    required this.query,
    required this.receipts
  });
}

class ValidateDateEvent extends ReceiptPageEvent {
  final String date;
  ValidateDateEvent({required this.date});
}

class ValidateDateDifference extends ReceiptPageEvent {
  final String startDate;
  final String endDate;

  ValidateDateDifference({required this.startDate, required this.endDate});
}

final class ValidateOption extends ReceiptPageEvent {
  final String option;
  ValidateOption(this.option);
}

class SubmitDateEvent extends ReceiptPageEvent {
  final BuildContext context;
  final String startDate;
  final String endDate;
  final String tinNumber;
  SubmitDateEvent(
      {required this.tinNumber,
      required this.startDate,
      required this.endDate,
      required this.context});
}
