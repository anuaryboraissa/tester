import 'package:erisiti/src/constants/styles/style.dart';
import 'package:erisiti/src/features/screens/login/bloc/login_bloc.dart';
import 'package:erisiti/src/features/screens/registration/bloc/register_bloc.dart';

import 'package:flutter/material.dart';

// ignore: must_be_immutable
class InputWidget extends StatelessWidget {
  // Instance Variables of the class
  String placeHolder;
  IconData inputIcon;
  Color inputColor;
  double borderRadius;
  bool passwordStyle = false;
  RegisterBloc registerBloc;
  LoginBloc loginBloc;
  bool login;
  Function(String tinNumber) tinNumberField;
  TextEditingController tinNumberEditing;

  bool? tinNumberValid;

  InputWidget({
    super.key,
    required this.tinNumberEditing,
    this.tinNumberValid,
    required this.login,
    required this.loginBloc,
    required this.registerBloc,
    required this.tinNumberField,
    required this.placeHolder,
    required this.inputIcon,
    required this.inputColor,
    required this.borderRadius,
    required this.passwordStyle,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0, right: 8, bottom: 8),
      child: TextField(
        controller: tinNumberEditing,
        keyboardType: TextInputType.number,
        onChanged: (value) {
          if (!login) {
            registerBloc.add(ValidateTinNumberEvent(value));
          } else {
            loginBloc.add(ValidateLoginTinNumberEvent(value));
          }
          tinNumberField(value);
        },
        obscureText: passwordStyle,
        decoration: InputDecoration(
          suffixIcon: tinNumberValid == null
              ? null
              : tinNumberValid!
                  ? const Icon(
                      Icons.check,
                      color: ApplicationStyles.realAppColor,
                      size: 15,
                    )
                  : const Icon(
                      Icons.warning,
                      color: Colors.red,
                      size: 15,
                    ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
                width: 3,
                color: tinNumberValid != null
                    ? !tinNumberValid!
                        ? Colors.red
                        : inputColor
                    : inputColor),
            borderRadius: BorderRadius.circular(borderRadius),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
                width: 3,
                color: tinNumberValid != null
                    ? !tinNumberValid!
                        ? Colors.red
                        : inputColor
                    : inputColor),
            borderRadius: BorderRadius.circular(borderRadius),
          ),
          hintText: placeHolder,
          contentPadding: const EdgeInsets.only(left: 600.0),
          border: const OutlineInputBorder(),
          prefixIcon: Container(
            margin: const EdgeInsets.only(right: 8),
            height: 50.0,
            width: 30.0,
            decoration: BoxDecoration(
              border: tinNumberValid != null
                  ? tinNumberValid!
                      ? null
                      : Border.all(color: Colors.red)
                  : null,
              color: inputColor,
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(borderRadius),
                  topLeft: Radius.circular(borderRadius)),
            ),
            child: Icon(
              inputIcon,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
