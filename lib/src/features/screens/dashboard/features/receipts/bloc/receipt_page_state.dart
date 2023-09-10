part of 'receipt_page_bloc.dart';

@immutable
sealed class ReceiptPageState {}

final class ReceiptPageInitial extends ReceiptPageState {}

final class ReceiptSearchState extends ReceiptPageState {
  final List receipts;
  final String query;
  ReceiptSearchState(this.query, {required this.receipts});
}

final class ValidatedDateState extends ReceiptPageState {
  final bool valid;
  ValidatedDateState({required this.valid});
}

final class ValidatedDateDifferenceState extends ReceiptPageState {
  final bool valid;
  ValidatedDateDifferenceState({required this.valid});
}

final class SubmitDateSuccessState extends ReceiptPageState {}

final class ValidateOptionState extends ReceiptPageState {
  final String option;

  ValidateOptionState(this.option);
}
