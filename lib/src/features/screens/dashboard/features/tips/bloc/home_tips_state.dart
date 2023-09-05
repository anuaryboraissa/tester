part of 'home_tips_bloc.dart';

@immutable
sealed class HomeTipsState {}

final class HomeBusinessInitial extends HomeTipsState {}

final class SearchTipsState extends HomeTipsState {
  final List<Map> tips;

  SearchTipsState(this.tips);
}
