import 'package:erisiti/src/constants/styles/style.dart';
import 'package:erisiti/src/features/dialogue/animated_dialogue.dart';
import 'package:erisiti/src/features/dialogue/fade_animations.dart';

import 'package:erisiti/src/features/screens/dashboard/features/home/bloc/home_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../Business/welcome.dart';

class HomeTopBar extends StatefulWidget {
  const HomeTopBar(
      {super.key,
      required this.loggedUser,
      required this.homeBloc,
      required this.title});
  final Map loggedUser;
  final HomeBloc homeBloc;
  final String title;

  @override
  State<HomeTopBar> createState() => _HomeTopBarState();
}

class _HomeTopBarState extends State<HomeTopBar>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;

  @override
  void initState() {
    controller = AnimationController(
        duration: const Duration(seconds: 3),
        vsync: this,
        animationBehavior: AnimationBehavior.preserve);
    controller.forward();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeBloc, HomeState>(
      bloc: widget.homeBloc,
      listener: (context, state) {
        if (state is LogoutState) {
          AnimatedDialogueBox.showScaleAlertBox(
              context: context,
              yourWidget: const Text("Are you sure you want to logout!"),
              firstButton: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      backgroundColor: ApplicationStyles.realAppColor),
                  onPressed: () {
                    widget.homeBloc.add(ConfirmLoginEvent(context));
                  },
                  child: const Text("yes")),
              secondButton: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      backgroundColor: ApplicationStyles.realAppColor),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text("No")));
        }
      },
      builder: (context, state) {
        return Container(
          margin:
              const EdgeInsets.only(top: 10, bottom: 20, left: 20, right: 20),
          padding: const EdgeInsets.all(10),
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.title,
                        style: ApplicationStyles.getStyle(true, 20, null),
                      ),
                      const SizedBox(
                        height: 1,
                      ),
                      Text(
                        widget.loggedUser['firstName'] == null
                            ? "loading...."
                            : "${widget.loggedUser['firstName']} ${widget.loggedUser['lastName']}",
                        style: ApplicationStyles.getStyle(
                            false, 15, ApplicationStyles.realAppColor),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      IconButton(
                          onPressed: () {},
                          icon: const Icon(
                            Icons.notifications,
                            color: ApplicationStyles.realAppColor,
                            size: 24,
                          )),
                      PopupMenuButton(
                        onOpened: () {
                          print("opened");
                        },
                        onSelected: (value) {
                          print("selected $value");
                          if (value == 1) {
                            widget.homeBloc.add(LogoutEvent());
                          } else {
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => const WelcomePage(
                                tinNumber: "",
                              ),
                            ));
                            //business navigate
                          }
                        },
                        icon: const CircleAvatar(
                          backgroundColor: ApplicationStyles.realAppColor,
                          child: Icon(
                            Icons.person,
                            color: Colors.white,
                            size: 24,
                          ),
                        ),
                        position: PopupMenuPosition.under,
                        itemBuilder: (context) => [
                          const PopupMenuItem(
                            value: 1,
                            // row with 2 children
                            child: FadeAnimation(
                                delay: 0.5, child: Text("Logout")),
                          ),
                          const PopupMenuItem(
                            value: 2,
                            // row with 2 children
                            child: FadeAnimation(
                                delay: 2, child: Text("Language")),
                          ),
                        ],
                      ),
                    ],
                  )
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}

enum ColorLabel {
  blue('Blue', Colors.blue),
  pink('Pink', Colors.pink),
  green('Green', Colors.green),
  yellow('Yellow', Colors.yellow),
  grey('Grey', Colors.grey);

  const ColorLabel(this.label, this.color);
  final String label;
  final Color color;
}
