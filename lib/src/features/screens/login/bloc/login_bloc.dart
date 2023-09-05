import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:erisiti/src/features/screens/login/helpers/helper.dart';
import 'package:erisiti/src/features/services/database/modalHelpers/login_user.dart';
import 'package:erisiti/src/features/services/database/modals/login_user.dart';
import 'package:erisiti/src/features/services/enpoints/forgetPassword/security_verify.dart';
import 'package:erisiti/src/features/services/enpoints/login.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:meta/meta.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginInitial()) {
    on<LoginEvent>(loginEvent);
    on<ValidateLoginTinNumberEvent>(validateLoginTinNumberEvent);
    on<LoginProcessEvent>(loginProcessEvent);
    on<VerifyForgotPasswordEvent>(verifyForgotPasswordEvent);
    on<ValidateMothersSurname>(validateMothersSurname);
  }

  FutureOr<void> loginEvent(LoginEvent event, Emitter<LoginState> emit) {}

  bool isInteger(num value) => value is int || value == value.roundToDouble();

  FutureOr<void> validateLoginTinNumberEvent(
      ValidateLoginTinNumberEvent event, Emitter<LoginState> emit) {
    try {
      num value = int.parse(event.tinNumber);
      if (isInteger(value) && event.tinNumber.length == 9) {
        emit(ValidateLoginTinNumberState(true, event.tinNumber));
      } else {
        emit(ValidateLoginTinNumberState(false, event.tinNumber));
      }
    } catch (e) {
      emit(ValidateLoginTinNumberState(false, event.tinNumber));
    }
  }

  FutureOr<void> loginProcessEvent(
      LoginProcessEvent event, Emitter<LoginState> emit) async {
    var ans = await LoginService().login(event.tinNumber, event.password);

    if (ans['status'] == 'success') {
      LoginUser user = LoginUser(
          firstName: ans['firstName'],
          lastName: ans['lastName'],
          tinNumber: event.tinNumber);

      int inserted = await LoginUserHelper().insert(user);

      if (inserted > 0) {
        LoginUser? loggedUser = await LoginUserHelper().queryById(1);

        // ignore: use_build_context_synchronously
        LoginServiceHelper.moveToDashboard(event.context, loggedUser!.firstName,
            loggedUser.lastName, loggedUser.tinNumber);
      } else {
        Fluttertoast.showToast(msg: "fail to save user");
      }
    } else if (ans['message'].toString().contains("Network is unreachable")) {}
    Fluttertoast.showToast(msg: ans['message']);
  }

  FutureOr<void> verifyForgotPasswordEvent(
      VerifyForgotPasswordEvent event, Emitter<LoginState> emit) async {
    final response = await ForgetPasswordVerify.verifyForgetPassword(
        event.tinNumber, event.lastName);
    if (response['status'] == "success" &&
        response['message'] == "Correct name") {
      emit(PasswordVerificationState(true, event.tinNumber));
    } else {
      emit(PasswordVerificationState(false, event.tinNumber));
    }
  }

  FutureOr<void> validateMothersSurname(
      ValidateMothersSurname event, Emitter<LoginState> emit) {
    if (event.surname.isNotEmpty) {
      emit(MothersSurnameValidationState(true));
    } else {
      emit(MothersSurnameValidationState(false));
    }
  }
}

class Data {
  final String status;
  final String message;

  Data(this.status, this.message);
}
