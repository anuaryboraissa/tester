import 'package:erisiti/src/features/screens/dashboard/dashboard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../bloc/global_bloc.dart';

class LoginServiceHelper {
  static moveToDashboard(BuildContext context, String firstName,
      String lastName, String tinNumber) {
    final user = {
      "firstName": firstName,
      "lastName": lastName,
      "tinNumber": tinNumber
    };
    context.read<GlobalBloc>().add(InitializeEvent());
    Navigator.of(context).popUntil((route) => route.isFirst);
    Navigator.of(context).pushReplacement(MaterialPageRoute(
      builder: (context) => DashboardPage(
        loggedUser: user,
      ),
    ));
  }
}
