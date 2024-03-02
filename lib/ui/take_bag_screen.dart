import 'package:flutter/material.dart';

import '../game_constant.dart';
import '../responsive.dart';
import '../util.dart';
import 'common_widgets.dart';

class TakeBagScreen extends StatefulWidget {
  static String routeName = "/takeBag";
  const TakeBagScreen({super.key});

  @override
  State<TakeBagScreen> createState() => _TakeBagScreenState();
}

class _TakeBagScreenState extends State<TakeBagScreen> {
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
              child: Image(
                  width: Responsive.getDefaultWidthDim(1040),
                  height: Responsive.getDefaultHeightDim(1352),
                  image: Util.getLocalImage(GameConstants.takeBag)),
            ),
            Positioned(
                child: Align(
              alignment: Alignment.topCenter,
              child: Column(
                children: [
                  const ScreenTopBar(barValue: 0.4),
                  addItemsWidget(),
                ],
              ),
            )),
            Positioned(
                child: Align(
              alignment: Alignment.bottomCenter,
              child: ScreenBottomBar(
                  buttonText: "GOT THE BAG", onButtonTap: onBottomButtonTap),
            )),
          ])),
    );
  }

  Widget addItemsWidget() {
    return Container(
      height: Responsive.getValueInPixel(100),
      width: Responsive.getDeviceWidth(),
      margin: EdgeInsets.only(left: Responsive.getValueInPixel(90)),
      child: Text(
        "Get your recycle bag",
        style: TextStyle(
          decoration: TextDecoration.none,
          color: const Color(0xff4B4B4B),
          fontWeight: FontWeight.w600,
          fontStyle: FontStyle.normal,
          fontFamily: GameConstants.fontFamily,
          fontSize: Responsive.getFontSize(75),
        ),
        textScaleFactor: 1.0,
        textAlign: TextAlign.start,
      ),
    );
  }

  void onBottomButtonTap() {}
}
