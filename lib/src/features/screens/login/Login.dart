import 'package:erisiti/src/constants/styles/style.dart';
import 'package:erisiti/src/features/screens/login/verification/verifyTin.dart';
import 'package:erisiti/src/features/screens/login/widgets/password_field.dart';
import 'package:erisiti/src/features/screens/login/widgets/tin_number.dart';
import 'package:erisiti/src/features/screens/registration/CreateAccount.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'bloc/login_bloc.dart';
import 'widgets/inputLabelsWidget.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  // ignore: prefer_typing_uninitialized_variables
  var tinNumberValid;
  String userPassword = '';
  TextEditingController tinNumberEditing = TextEditingController();
  TextEditingController passwordEditing = TextEditingController();
  bool loading = false;
  @override
  Widget build(BuildContext context) {
    LoginBloc loginBloc = LoginBloc();
    return Scaffold(
      appBar: AppBar(
        title: Container(
          // height: 180.0,
          // width: 250.0,
          padding: const EdgeInsets.all(20),
          // margin: const EdgeInsets.all(7.0),
          alignment: Alignment.bottomLeft,
          child: const Text("Welcome Back"),
        ),
        titleTextStyle: const TextStyle(
          fontFamily: 'Popins',
          fontSize: 20.0,
          fontWeight: FontWeight.w900,
        ),
        backgroundColor: ApplicationStyles.realAppColor,
        toolbarHeight: 70.0,
        elevation: 5.0,
        titleSpacing: 7.0,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(30),
          ),
        ),
      ),
      body: BlocConsumer<LoginBloc, LoginState>(
        bloc: loginBloc,
        listener: (context, state) {
          if (state is ValidateLoginTinNumberState) {
            tinNumberValid = state.valid;
            print("current state is ${state.valid}");
          }
        },
        builder: (context, state) {
          return Container(
            padding: const EdgeInsets.all(21.0),
            child: ListView(
              children: [
                InputLabelsWidgets(label: "Tin Number"),
                LoginTinNumber(
                    tinNumberValid: tinNumberValid,
                    tinNumberEditing: tinNumberEditing,
                    loginBloc: loginBloc,
                    placeHolder: "000-000-000-000",
                    inputIcon: Icons.tag_outlined,
                    inputColor: ApplicationStyles.realAppColor,
                    borderRadius: 7,
                    passwordStyle: false),
                const SizedBox(
                  height: 8,
                ),
                InputLabelsWidgets(label: "Password"),
                LoginPasswordField(
                    userPassword: (password) {
                      userPassword = password;
                    },
                    passwordEditing: passwordEditing),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    alignment: AlignmentDirectional.bottomEnd,
                    child: TextButton(
                        onPressed: () {
                          // Navigator.of(context).popUntil((route) => route.isFirst);
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            return const VerifyTinNumber();
                          }));
                        },
                        child: const Text(
                          "Forgot account ?",
                          style: TextStyle(
                            color: ApplicationStyles.realAppColor,
                            fontFamily: 'Popins',
                            fontSize: 15.0,
                            fontWeight: FontWeight.w900,
                          ),
                        )),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Directionality(
                    textDirection: TextDirection.rtl,
                    child: ElevatedButton.icon(
                      label: loading
                          ? const CircularProgressIndicator(
                              color: Colors.white,
                            )
                          : const Text("LOGIN"),
                      icon: const Icon(Icons.login),
                      onPressed: tinNumberValid != null && tinNumberValid
                          ? () {
                              
                              loginBloc.add(LoginProcessEvent(
                                  tinNumberEditing.text,
                                  passwordEditing.text,
                                  context));
                            }
                          : null,
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0)),
                        textStyle: const TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                        backgroundColor: ApplicationStyles.realAppColor,
                        foregroundColor: Colors.white,
                        minimumSize: const Size(200.0, 60.0),
                      ),
                    ),
                  ),
                ),
                const Center(
                  child: Text(
                    'OR',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20.0,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).popUntil((route) => route.isFirst);
                      Navigator.of(context).pushReplacement(MaterialPageRoute(
                        builder: (context) => const CreateAccount(),
                      ));
                    },
                    style: ElevatedButton.styleFrom(
                      side: const BorderSide(
                          color: ApplicationStyles.realAppColor),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0)),
                      textStyle: const TextStyle(
                          fontSize: 20, fontWeight: FontWeight.bold),
                      backgroundColor: Colors.white,
                      foregroundColor: Colors.black,
                      minimumSize: const Size(200.0, 60.0),
                    ),
                    child: const Text('SIGN UP'),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
