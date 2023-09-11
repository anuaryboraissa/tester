part of 'register_service_bloc.dart';

@immutable
sealed class RegisterServiceState {}

final class RegisterServiceInitial extends RegisterServiceState {}

final class RegisterBusinessState extends RegisterServiceState {
  final String message;
  final bool registered;

  RegisterBusinessState(this.message, this.registered);
}

final class RegistrationProcessState extends RegisterServiceState {
  final double progress;

  RegistrationProcessState(this.progress);
}

final class BusinessByTinState extends RegisterServiceState {
  final List businesses;
  final bool error;
  final String message;

  BusinessByTinState(this.businesses, this.error, this.message);
}

final class FindProductsByBusinessNumberState extends RegisterServiceState {
  final List items;
  final bool error;
  final String message;

  FindProductsByBusinessNumberState(this.items, this.error, this.message);
}

final class FindUserReceiptByTinState extends RegisterServiceState {
  final Map<String, dynamic> receipts;
  final bool error;
  final String message;
  FindUserReceiptByTinState(this.receipts, this.error, this.message);
}

final class FindBusinessReceiptsByBusinessIdState extends RegisterServiceState {
  final List receipts;
  final bool error;
  final String message;
  FindBusinessReceiptsByBusinessIdState(
      this.receipts, this.error, this.message);
}

final class GenerateReceiptState extends RegisterServiceState {
  final bool generated;
  final String message;
  final String receiptNumber;
  GenerateReceiptState(this.generated, this.message, this.receiptNumber);
}

final class FindReceiptByNumberState extends RegisterServiceState {
  final Map receipt;
  final bool exist;
  final String message;

  FindReceiptByNumberState(this.receipt, this.exist, this.message);
}

final class AddBusinessItemState extends RegisterServiceState {
  final String message;
  final bool registered;

  AddBusinessItemState(this.message, this.registered);
}
