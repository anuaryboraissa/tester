part of 'home_tips_bloc.dart';

@immutable
sealed class HomeTipsEvent {}

final class SearchTipsEvent extends HomeTipsEvent {
  final String query;

  SearchTipsEvent(this.query);
}
