part of 'login_bloc.dart';

@immutable
sealed class LoginEvent {}

final class ValidateLoginTinNumberEvent extends LoginEvent {
  final String tinNumber;

  ValidateLoginTinNumberEvent(this.tinNumber);
}

final class ValidateMothersSurname extends LoginEvent {
  final String surname;

  ValidateMothersSurname(this.surname);
}

final class LoginProcessEvent extends LoginEvent {
  final String tinNumber;
  final String password;
  final BuildContext context;

  LoginProcessEvent(this.tinNumber, this.password, this.context);
}

final class VerifyForgotPasswordEvent extends LoginEvent {
  final String tinNumber;
  final String lastName;

  VerifyForgotPasswordEvent(this.tinNumber, this.lastName);
}

class InitializeLoadingEvent extends LoginEvent {
  final bool loading;

  InitializeLoadingEvent(this.loading);
}
