import 'package:erisiti/src/features/screens/dashboard/features/home/bloc/home_bloc.dart';
import 'package:erisiti/src/features/screens/dashboard/features/home/components/topbar.dart';
import 'package:erisiti/src/features/screens/dashboard/features/more/components/body.dart';
import 'package:erisiti/src/features/screens/dashboard/features/more/components/topbar.dart';
import 'package:flutter/material.dart';

import '../../../../services/database/modalHelpers/login_user.dart';

class MorePage extends StatefulWidget {
  const MorePage({super.key});

  @override
  State<MorePage> createState() => _MorePageState();
}

class _MorePageState extends State<MorePage> {
  @override
  void initState() {
    getLoginUser();
    super.initState();
  }

  Map<String, dynamic> loggedUser = {};

  getLoginUser() {
    LoginUserHelper().queryById(1).then((value) {
      final user = {
        "fullName": value!.fullName,
        "phoneNumber": value.phoneNumber,
        "tinNumber": value.tinNumber,
        "userType": value.userType
      };
      setState(() {
        loggedUser = user;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            HomeTopBar(
              loggedUser: loggedUser,
              homeBloc: HomeBloc(),
              title: "Profile,",
            ),
            const MoreBody()
          ],
        ),
      ),
    );
  }
}
