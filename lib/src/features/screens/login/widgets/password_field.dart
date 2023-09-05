import 'package:erisiti/src/constants/styles/style.dart';

import 'package:flutter/material.dart';

class LoginPasswordField extends StatefulWidget {
  const LoginPasswordField(
      {super.key, required this.userPassword, required this.passwordEditing});

  final Function(String password) userPassword;
  final TextEditingController passwordEditing;

  @override
  State<LoginPasswordField> createState() => _LoginPasswordFieldState();
}

class _LoginPasswordFieldState extends State<LoginPasswordField> {
  bool showPassword = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0, right: 8, bottom: 8),
      child: TextField(
        controller: widget.passwordEditing,
        obscureText: showPassword ? false : true,
        decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(
                width: 3, color: ApplicationStyles.realAppColor),
            borderRadius: BorderRadius.circular(7),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(
                width: 3, color: ApplicationStyles.realAppColor),
            borderRadius: BorderRadius.circular(7),
          ),
          hintText: "Enter your password",
          contentPadding: const EdgeInsets.only(left: 600.0),
          border: const OutlineInputBorder(),
          prefixIcon: Container(
            height: 50.0,
            width: 30.0,
            margin: const EdgeInsets.only(right: 8),
            decoration: const BoxDecoration(
              color: ApplicationStyles.realAppColor,
              borderRadius: BorderRadius.only(
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
          widget.userPassword(password);
        },
      ),
    );
  }
}
