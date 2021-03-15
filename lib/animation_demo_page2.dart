import 'dart:math';
import 'dart:ui';
import 'package:flutter/material.dart';

class AnimationDemoPage2 extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return AnimationDemoPage2State();
  }
}

class AnimationDemoPage2State extends State<AnimationDemoPage2>
    with SingleTickerProviderStateMixin {
  AnimationController controller;
  Animation animation;

  @override
  void initState() {
    // TODO: implement initState

    controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 500));
    animation = CurvedAnimation(
      parent: controller,
      curve: Curves.easeInSine,
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    
  }
}
