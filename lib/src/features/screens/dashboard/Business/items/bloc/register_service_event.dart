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
