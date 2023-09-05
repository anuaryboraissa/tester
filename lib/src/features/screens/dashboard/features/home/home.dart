import 'package:erisiti/src/features/screens/dashboard/features/home/bloc/home_bloc.dart';
import 'package:erisiti/src/features/screens/dashboard/features/home/components/topbar.dart';
import 'package:flutter/material.dart';

import 'components/body.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.loggedUser});
  final Map loggedUser;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  HomeBloc homeBloc = HomeBloc();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            HomeTopBar(
              loggedUser: widget.loggedUser,
              homeBloc: homeBloc, title: "Welcome,",
            ),
            HomeBody(
              tinNumber: widget.loggedUser['tinNumber'],
              homeBloc: homeBloc,
            )
          ],
        ),
      ),
    );
  }
}
