import 'package:flutter/material.dart';

class AnimatedWidgetAction {
  late Animation animation, delayedAnimation;
  late AnimationController animationController;

  final TickerProvider provider;

  AnimatedWidgetAction({required this.provider});

  Map animate() {
    animationController = AnimationController(
        duration: const Duration(seconds: 3), vsync: provider);
    animation = Tween(begin: -1.0, end: 0.0).animate(CurvedAnimation(
        parent: animationController, curve: Curves.fastOutSlowIn));

    delayedAnimation = Tween(begin: 1.0, end: 0.0).animate(CurvedAnimation(
        parent: animationController,
        curve: const Interval(0.2, 0.6, curve: Curves.fastOutSlowIn)));
    animationController.forward();

    Map map = {"controller": animationController, "delayed": delayedAnimation};
    return map;
  }

  dispose() {
    animationController.dispose();
  }
}
