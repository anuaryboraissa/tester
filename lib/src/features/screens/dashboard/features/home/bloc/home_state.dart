part of 'home_bloc.dart';

@immutable
sealed class HomeState {}

final class HomeInitial extends HomeState {}

final class LogoutState extends HomeState {}

final class HomeInitializeState extends HomeState {
  final String numberOfReceipts;
  final String taxAmount;
  final String totalAmount;
  final bool networkActive;

  HomeInitializeState(this.numberOfReceipts, this.taxAmount, this.totalAmount,
      this.networkActive);
}
