part of 'global_bloc.dart';

@immutable
abstract class GlobalEvent {}

final class InitializeEvent extends GlobalEvent {
  InitializeEvent();
}
