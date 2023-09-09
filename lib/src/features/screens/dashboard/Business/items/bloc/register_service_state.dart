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
