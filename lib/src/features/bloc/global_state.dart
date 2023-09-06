part of 'global_bloc.dart';

@immutable
abstract class GlobalState {}

class GlobalInitial extends GlobalState {}

class SuccessInitializationState extends GlobalState {
  final LoginUser? loggedUser;
  SuccessInitializationState(this.loggedUser);
}
