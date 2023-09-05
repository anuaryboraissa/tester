import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:erisiti/src/features/services/database/modalHelpers/login_user.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:meta/meta.dart';

import '../../../../../services/enpoints/dashboard.dart';
import '../../../../login/Login.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeInitial()) {
    on<HomeEvent>(homeEvent);
    on<LogoutEvent>(logoutEvent);
    on<ConfirmLoginEvent>(confirmLoginEvent);
    on<HomeInitializeEvent>(homeInitializeEvent);
  }

  FutureOr<void> homeEvent(HomeEvent event, Emitter<HomeState> emit) {}

  FutureOr<void> logoutEvent(LogoutEvent event, Emitter<HomeState> emit) {
    emit(LogoutState());
  }

  FutureOr<void> confirmLoginEvent(
      ConfirmLoginEvent event, Emitter<HomeState> emit) async {
    print("step 1");
    await LoginUserHelper().delete(1);
    print("step 2");
    Navigator.pop(event.context);
    print("step 3");
    Navigator.of(event.context).popUntil((route) => route.isFirst);

    Navigator.of(event.context).pushReplacement(MaterialPageRoute(
      builder: (context) => const Login(),
    ));
    print("step 4");
  }

  FutureOr<void> homeInitializeEvent(
      HomeInitializeEvent event, Emitter<HomeState> emit) async {
    var response = await DashboardService().dashboard(event.tinNumber);

    if (response['status'] == "success") {
      emit(HomeInitializeState(
          response['noOfReceipts'],
          response['taxAmount'].toString(),
          response['totalAmount'].toString(),
          true));
    } else if (response['message']
        .toString()
        .contains("Network is unreachable")) {
      Fluttertoast.showToast(msg: "Network unreachable");
      emit(HomeInitializeState("", "", "", false));
    }
  }
}
