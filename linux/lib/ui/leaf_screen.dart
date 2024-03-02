import 'package:flutter/material.dart';

import '../game_constant.dart';
import '../responsive.dart';
import '../util.dart';
import 'bottom_bar.dart';

class LeafScreen extends StatefulWidget {
  const LeafScreen({super.key});
  static String routeName = "/leaf";

  @override
  State<LeafScreen> createState() => _LeafScreenState();
}

class _LeafScreenState extends State<LeafScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: Responsive.getDeviceWidth(),
        height: Responsive.getDeviceHeight(),
        child: Stack(fit: StackFit.expand, children: [
          Image(
            width: Responsive.getDeviceWidth(),
            height: Responsive.getDeviceHeight(),
            image: Util.getLocalImage(GameConstants.background),
            fit: BoxFit.fill,
          ),
          Center(
            child: Text(
              "LeafScreen",
            ),
          ),
          Positioned.fill(
              child: Align(
            alignment: Alignment.bottomCenter,
            child: BottomBar(LeafScreen.routeName),
          ))
        ]),
      ),
    );
  }
}
