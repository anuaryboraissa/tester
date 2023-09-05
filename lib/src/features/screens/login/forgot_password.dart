import 'package:erisiti/src/constants/styles/style.dart';
import 'package:erisiti/src/features/screens/registration/bloc/register_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'Login.dart';

class ForgetPassword extends StatefulWidget {
  const ForgetPassword({Key? key, required this.tinNumber}) : super(key: key);
  final String tinNumber;

  @override
  State<ForgetPassword> createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {
  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _repeatPasswordController =
      TextEditingController();
  bool _isPasswordVisible = false;

  @override
  void dispose() {
    _newPasswordController.dispose();
    _repeatPasswordController.dispose();
    super.dispose();
  }

  RegisterBloc registerBloc = RegisterBloc();
  // ignore: prefer_typing_uninitialized_variables
  var passwordValid;
  // ignore: prefer_typing_uninitialized_variables
  var passwordMatch;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: BlocConsumer<RegisterBloc, RegisterState>(
          bloc: registerBloc,
          listener: (context, state) {
            print("current state is ${state.runtimeType}");
            if (state is ValidatePasswordState) {
              passwordValid = state.valid;
            } else if (state is ValidatePasswordMatchState) {
              print("current state match is ${state.valid}");
              passwordMatch = state.valid;
            }
            if (state is PasswordResetState && state.successfully) {
              Fluttertoast.showToast(msg: "Password reset successfully !! ");
              Navigator.of(context).popUntil((route) => route.isFirst);
              Navigator.of(context).pushReplacement(MaterialPageRoute(
                builder: (context) => const Login(),
              ));
            } else if (state is PasswordResetState) {
              Fluttertoast.showToast(msg: "Unable to reset your password");
            }
          },
          builder: (context, state) {
            return Container(
              margin: const EdgeInsets.only(
                  left: 20, right: 20, bottom: 20, top: 45),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height * .04,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 15.0),
                    child: SvgPicture.asset(
                      "assets/images/undraw_safe_re_kiil.svg",
                      semanticsLabel: "gift",
                      width: 220,
                      height: 220,
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * .05,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 8),
                        child: Text(
                          'New Password',
                          style: ApplicationStyles.getStyle(true, 18, null),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 8.0, right: 8, bottom: 8),
                        child: TextFormField(
                          onChanged: (value) {
                            registerBloc.add(ValidatePasswordEvent(value));
                          },
                          controller: _newPasswordController,
                          decoration: InputDecoration(
                            contentPadding: const EdgeInsets.only(left: 600.0),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(7),
                                borderSide: BorderSide(
                                    color: passwordValid != null
                                        ? !passwordValid!
                                            ? Colors.red
                                            : ApplicationStyles.realAppColor
                                        : (passwordMatch != null)
                                            ? passwordMatch!
                                                ? ApplicationStyles.realAppColor
                                                : Colors.red
                                            : ApplicationStyles.realAppColor,
                                    width: 3)),
                            hintText: 'xxxxxxxx',
                            border: const OutlineInputBorder(),
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(7),
                                borderSide: BorderSide(
                                    color: passwordValid != null
                                        ? !passwordValid!
                                            ? Colors.red
                                            : ApplicationStyles.realAppColor
                                        : (passwordMatch != null)
                                            ? passwordMatch!
                                                ? ApplicationStyles.realAppColor
                                                : Colors.red
                                            : ApplicationStyles.realAppColor,
                                    width: 3)),
                            prefixIcon: Container(
                              width: 30,
                              height: 50,
                              margin: const EdgeInsets.only(right: 8),
                              decoration: BoxDecoration(
                                border: passwordValid != null
                                    ? passwordValid!
                                        ? null
                                        : Border.all(color: Colors.red)
                                    : (passwordMatch != null)
                                        ? passwordMatch!
                                            ? null
                                            : Border.all(color: Colors.red)
                                        : null,
                                color: ApplicationStyles.realAppColor,
                                borderRadius: const BorderRadius.only(
                                    bottomLeft: Radius.circular(8.0),
                                    topLeft: Radius.circular(8.0)),
                              ),
                              child: const Icon(
                                Icons.lock,
                                color: Colors.white,
                              ),
                            ),
                            suffixIcon: IconButton(
                              onPressed: () {
                                setState(() {
                                  _isPasswordVisible = !_isPasswordVisible;
                                });
                              },
                              icon: Icon(
                                _isPasswordVisible
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                                color: Colors.black,
                              ),
                            ),
                          ),
                          obscureText: !_isPasswordVisible,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 15),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 8),
                        child: Text(
                          'Repeat Password',
                          style: ApplicationStyles.getStyle(true, 18, null),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 8.0, right: 8, bottom: 8),
                        child: TextFormField(
                          onChanged: (value) {
                            registerBloc.add(ValidatePasswordMatchEvent(
                                _newPasswordController.text, value));
                          },
                          controller: _repeatPasswordController,
                          decoration: InputDecoration(
                            contentPadding: const EdgeInsets.only(left: 600.0),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(7),
                                borderSide: BorderSide(
                                    color: passwordMatch != null
                                        ? !passwordMatch!
                                            ? Colors.red
                                            : ApplicationStyles.realAppColor
                                        : ApplicationStyles.realAppColor,
                                    width: 3)),
                            hintText: 'xxxxxxxx',
                            border: const OutlineInputBorder(),
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(7),
                                borderSide: BorderSide(
                                    color: passwordMatch != null
                                        ? !passwordMatch!
                                            ? Colors.red
                                            : ApplicationStyles.realAppColor
                                        : ApplicationStyles.realAppColor,
                                    width: 3)),
                            prefixIcon: Container(
                              width: 30,
                              height: 50,
                              margin: const EdgeInsets.only(right: 8),
                              decoration: BoxDecoration(
                                border: passwordMatch != null
                                    ? passwordMatch!
                                        ? null
                                        : Border.all(color: Colors.red)
                                    : null,
                                color: ApplicationStyles.realAppColor,
                                borderRadius: const BorderRadius.only(
                                    bottomLeft: Radius.circular(8.0),
                                    topLeft: Radius.circular(8.0)),
                              ),
                              child: const Icon(
                                Icons.lock,
                                color: Colors.white,
                              ),
                            ),
                            suffixIcon: IconButton(
                              onPressed: () {
                                setState(() {
                                  _isPasswordVisible = !_isPasswordVisible;
                                });
                              },
                              icon: Icon(
                                _isPasswordVisible
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                                color: Colors.black,
                              ),
                            ),
                          ),
                          obscureText: !_isPasswordVisible,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * .02,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(15),
                    child: Center(
                      child: ElevatedButton(
                        onPressed:
                            (passwordValid != null && passwordMatch != null) &&
                                    passwordMatch &&
                                    passwordValid
                                ? () {
                                    registerBloc.add(ResetPasswordEvent(
                                        widget.tinNumber,
                                        _newPasswordController.text,
                                        _repeatPasswordController.text));
                                  }
                                : null,
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20)),
                          backgroundColor: ApplicationStyles.realAppColor,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Text(
                            'SUBMIT',
                            style: ApplicationStyles.getStyle(
                                true, 15, Colors.white),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
