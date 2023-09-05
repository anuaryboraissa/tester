import 'package:erisiti/src/constants/styles/style.dart';
import 'package:erisiti/src/features/screens/registration/bloc/register_bloc.dart';
import 'package:flutter/material.dart';

class PasswordFieldWidget extends StatefulWidget {
  const PasswordFieldWidget(
      {super.key,
      required this.userPassword,
      required this.registerBloc,
      required this.primaryPassword,
      this.currentPassword,
      this.passwordValid,
      this.passwordMatch,
      this.confirmPassword,
      required this.login,
      required this.passwordEditing});

  final Function(String password) userPassword;
  final RegisterBloc registerBloc;
  final bool primaryPassword;
  final bool login;
  final String? currentPassword;
  final bool? passwordValid;
  final bool? passwordMatch;
  final String? confirmPassword;
  final TextEditingController passwordEditing;

  @override
  State<PasswordFieldWidget> createState() => _PasswordFieldWidgetState();
}

class _PasswordFieldWidgetState extends State<PasswordFieldWidget> {
  bool showPassword = false;

  @override
  Widget build(BuildContext context) {
    final state = widget.registerBloc.state;

    return Padding(
      padding: const EdgeInsets.only(left: 8.0, right: 8, bottom: 8),
      child: TextField(
        controller: widget.passwordEditing,
        obscureText: showPassword ? false : true,
        decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
                width: 3,
                color: widget.passwordValid != null
                    ? !widget.passwordValid!
                        ? Colors.red
                        : ApplicationStyles.realAppColor
                    : (widget.passwordMatch != null && !widget.primaryPassword)
                        ? widget.passwordMatch!
                            ? ApplicationStyles.realAppColor
                            : Colors.red
                        : ApplicationStyles.realAppColor),
            borderRadius: BorderRadius.circular(7),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
                width: 3,
                color: widget.passwordValid != null
                    ? !widget.passwordValid!
                        ? Colors.red
                        : ApplicationStyles.realAppColor
                    : (widget.passwordMatch != null && !widget.primaryPassword)
                        ? widget.passwordMatch!
                            ? ApplicationStyles.realAppColor
                            : Colors.red
                        : ApplicationStyles.realAppColor),
            borderRadius: BorderRadius.circular(7),
          ),
          hintText: widget.login
              ? "Enter your password"
              : widget.primaryPassword
                  ? "Not less than 8 characters"
                  : "Confirm your password",
          contentPadding: const EdgeInsets.only(left: 600.0),
          border: const OutlineInputBorder(),
          prefixIcon: Container(
            height: 50.0,
            width: 30.0,
            margin: const EdgeInsets.only(right: 8),
            decoration: BoxDecoration(
              border: widget.passwordValid != null
                  ? widget.passwordValid!
                      ? null
                      : Border.all(color: Colors.red)
                  : (widget.passwordMatch != null && !widget.primaryPassword)
                      ? widget.passwordMatch!
                          ? null
                          : Border.all(color: Colors.red)
                      : null,
              color: ApplicationStyles.realAppColor,
              borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(7.0),
                  topLeft: Radius.circular(7.0)),
            ),
            child: const Icon(
              Icons.lock,
              color: Colors.white,
            ),
          ),
          suffixIcon: Container(
            height: 50.0,
            width: 30.0,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(7.0),
                  topRight: Radius.circular(7.0)),
            ),
            child: IconButton(
              onPressed: () {
                setState(() {
                  showPassword = !showPassword;
                });
              },
              icon: showPassword
                  ? const Icon(Icons.visibility_off)
                  : const Icon(Icons.visibility),
              color: Colors.black,
            ),
          ),
        ),
        onChanged: (password) {
          if (!widget.login) {
            if (widget.primaryPassword) {
              widget.registerBloc.add(ValidatePasswordEvent(password));

              if (widget.confirmPassword != null &&
                  widget.passwordValid != null &&
                  widget.passwordValid! &&
                  (state is ValidatePasswordState)) {
                print("imepitaa!!");
                widget.registerBloc.add(ValidatePasswordMatchEvent(
                    widget.currentPassword == null
                        ? ""
                        : widget.currentPassword!,
                    widget.confirmPassword!));
              }
            } else {
              widget.registerBloc.add(ValidatePasswordMatchEvent(
                  widget.currentPassword == null ? "" : widget.currentPassword!,
                  password));
            }
          }

          widget.userPassword(password);
        },
      ),
    );
  }
}
