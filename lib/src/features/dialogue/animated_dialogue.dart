import 'package:flutter/material.dart';

class AnimatedDialogueBox {
  static Future showCustomAlertBox({
    required BuildContext context,
    required Widget yourWidget,
    required Widget firstButton,
  }) {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(15)),
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                yourWidget,
              ],
            ),
            actions: <Widget>[firstButton],
            elevation: 10,
          );
        });
  }

  static Future showScaleAlertBox({
    required BuildContext context,
    required Widget yourWidget,
    Widget? title,
    required Widget firstButton,
    Widget? secondButton,
  }) {
    return showGeneralDialog(
        barrierColor: Colors.black.withOpacity(0.7),
        transitionBuilder: (context, a1, a2, widget) {
          return Transform.scale(
            scale: a1.value,
            child: Opacity(
              opacity: a1.value,
              child: AlertDialog(
                actionsAlignment: MainAxisAlignment.spaceEvenly,
                shape: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15.0)),
                title: title,
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Container(
                      height: 10,
                    ),
                    yourWidget
                  ],
                ),
                actions: <Widget>[
                  firstButton,
                  secondButton!,
                ],
              ),
            ),
          );
        },
        transitionDuration: const Duration(milliseconds: 200),
        barrierDismissible: true,
        barrierLabel: '',
        context: context,
        pageBuilder: (context, animation1, animation2) {
          return const Text("data");
        });
  }

  static Future showInOutDialog({
    required BuildContext context,
    required Widget yourWidget,
    Widget? icon,
    Widget? title,
    required Widget firstButton,
    Widget? secondButton,
  }) {
    return showGeneralDialog(
        barrierColor: Colors.black.withOpacity(0.7),
        transitionBuilder: (context, a1, a2, widget) {
          final curvedValue = Curves.fastOutSlowIn.transform(a1.value) - 1.0;
          return Transform(
            transform: Matrix4.translationValues(0.0, curvedValue * 200, 0.0),
            child: Opacity(
              opacity: a1.value,
              child: AlertDialog(
                shape: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16.0)),
                title: title,
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Container(
                      height: 10,
                    ),
                    yourWidget
                  ],
                ),
                actions: <Widget>[firstButton, secondButton!],
              ),
            ),
          );
        },
        transitionDuration: const Duration(milliseconds: 200),
        barrierDismissible: true,
        barrierLabel: '',
        context: context,
        pageBuilder: (context, animation1, animation2) {
          return const Text("data");
        });
  }
}
