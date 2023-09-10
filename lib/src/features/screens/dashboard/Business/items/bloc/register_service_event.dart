part of 'register_service_bloc.dart';

@immutable
sealed class RegisterServiceEvent {}

final class RegisterBusinessEvent extends RegisterServiceEvent {
  final List<Map<String, dynamic>> businesses;
  RegisterBusinessEvent(this.businesses);
}

final class FindBusinessEvent extends RegisterServiceEvent {
  final String tinNumber;

  FindBusinessEvent(this.tinNumber);
}

final class FindProductsByBusinessNumberEvent extends RegisterServiceEvent {
  final String businessNumber;

  FindProductsByBusinessNumberEvent(this.businessNumber);
}

final class FindUserReceiptByTinEvent extends RegisterServiceEvent {
  final String tinNumber;

  FindUserReceiptByTinEvent(this.tinNumber);
}

final class FindBusinessReceiptsByBusinessIdEvent extends RegisterServiceEvent {
  final int businessId;

  FindBusinessReceiptsByBusinessIdEvent(this.businessId);
}

final class GenerateReceiptEvent extends RegisterServiceEvent {
  final Map<String, dynamic> item;

  GenerateReceiptEvent(this.item);
}
