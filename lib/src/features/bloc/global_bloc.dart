import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:erisiti/src/features/services/database/modalHelpers/login_user.dart';
import 'package:meta/meta.dart';

import '../services/database/modals/login_user.dart';

part 'global_event.dart';
part 'global_state.dart';

class GlobalBloc extends Bloc<GlobalEvent, GlobalState> {
  GlobalBloc() : super(GlobalInitial()) {
    on<GlobalEvent>(globalEvent);
    on<InitializeEvent>(initializeEvent);
  }

  FutureOr<void> globalEvent(GlobalEvent event, Emitter<GlobalState> emit) {}

  FutureOr<void> initializeEvent(
      InitializeEvent event, Emitter<GlobalState> emit) async {
    LoginUser? user = await LoginUserHelper().queryById(1);
    emit(SuccessInitializationState(user));
  }
}
