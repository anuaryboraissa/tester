import 'package:erisiti/src/constants/styles/style.dart';
import 'package:erisiti/src/features/bloc/global_bloc.dart';
import 'package:erisiti/src/features/screens/dashboard/Business/items/bloc/register_service_bloc.dart';
import 'package:erisiti/src/features/screens/dashboard/dashboard.dart';
import 'package:erisiti/src/features/screens/dashboard/features/home/bloc/home_bloc.dart';
import 'package:erisiti/src/features/screens/dashboard/features/receipts/bloc/receipt_page_bloc.dart';
import 'package:erisiti/src/features/screens/dashboard/features/tips/bloc/home_tips_bloc.dart';
import 'package:erisiti/src/features/screens/login/bloc/login_bloc.dart';
import 'package:erisiti/src/features/screens/onboarding/pages/mainPage.dart';
import 'package:erisiti/src/features/screens/registration/bloc/register_bloc.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'src/features/services/database/modalHelpers/login_user.dart';
import 'src/features/services/database/modals/login_user.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  LoginUser? user = await LoginUserHelper().queryById(1);
  runApp(Erisiti(
    loginUser: user,
  ));
}

class Erisiti extends StatefulWidget {
  const Erisiti({super.key, required this.loginUser});
  final LoginUser? loginUser;
  @override
  State<Erisiti> createState() => _ErisitiState();
}

class _ErisitiState extends State<Erisiti> {
  GlobalBloc globalBloc = GlobalBloc();

  var loggedInUser = {};

  @override
  void initState() {
    globalBloc.add(InitializeEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        const SystemUiOverlayStyle(statusBarColor: Colors.transparent));
    return MultiBlocProvider(
      providers: [
        BlocProvider<GlobalBloc>(
            create: (BuildContext context) => GlobalBloc()),
        BlocProvider<ReceiptPageBloc>(
            create: (BuildContext context) => ReceiptPageBloc()),
        BlocProvider<RegisterBloc>(
            create: (BuildContext context) => RegisterBloc()),
        BlocProvider<LoginBloc>(
          create: (context) => LoginBloc(),
        ),
        BlocProvider<HomeBloc>(
          create: (context) => HomeBloc(),
        ),
        BlocProvider(
          create: (context) => HomeTipsBloc(),
        ),
        BlocProvider(
          create: (context) => RegisterServiceBloc(),
        )
      ],
      child: BlocBuilder<GlobalBloc, GlobalState>(
        bloc: globalBloc,
        builder: (context, state) {
          context.read<GlobalBloc>().add(InitializeEvent());
          return Builder(builder: (context) {
            return MaterialApp(
              color: ApplicationStyles.realAppColor,
              debugShowCheckedModeBanner: false,
              title: 'e-Risiti',
              home: widget.loginUser != null
                  ? DashboardPage(loggedUser: {
                      "fullName": widget.loginUser!.fullName,
                      "tinNumber": widget.loginUser!.tinNumber,
                      "phone": widget.loginUser!.phoneNumber,
                      "userType": widget.loginUser!.userType,
                      "token": widget.loginUser!.token,
                      "refreshToken": widget.loginUser!.refreshToken
                    })
                  : const Onboarding(),
            );
          });
        },
      ),
    );
  }
}
