import 'package:flutter/material.dart';

import '../game_constant.dart';
import '../responsive.dart';
import '../util.dart';
import 'bottom_bar.dart';
import 'progression_list.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  static String routeName = "/home";
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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
          Positioned.fill(
              child: Align(
            alignment: Alignment.bottomCenter,
            child: Column(
              children: [
                Expanded(child: ProgressionList()),
                Container(height: Responsive.getValueInPixel(100)),
                BottomBar(HomeScreen.routeName),
              ],
            ),
          ))
        ]),
      ),
    );
  }
}
