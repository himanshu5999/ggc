import 'package:flutter/material.dart';
import 'package:ggc/ui/app_bar.dart';

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
                const CustomAppBar(),
                const Expanded(child: ProgressionList()),
                BottomBar(HomeScreen.routeName),
              ],
            ),
          )),
          doYouKnowWidget(),
        ]),
      ),
    );
  }

  Widget doYouKnowWidget() {
    return Container(
      margin: EdgeInsets.only(top: Responsive.getDefaultHeightDim(350)),
      height: Responsive.getDefaultHeightDim(340),
      padding:
          EdgeInsets.symmetric(horizontal: Responsive.getDefaultWidthDim(50)),
      child: Stack(
        children: [
          Image(
            image: Util.getLocalImage(GameConstants.doYouKnow),
          ),
          Container(
            height: Responsive.getDefaultHeightDim(300),
            width: 0.7 * Responsive.getDeviceWidth(),
            margin: EdgeInsets.only(left: Responsive.getValueInPixel(50)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "DO YOU KNOW?",
                  style: TextStyle(
                    decoration: TextDecoration.none,
                    color: const Color(0xffF0DAFF),
                    fontWeight: FontWeight.w500,
                    fontStyle: FontStyle.normal,
                    fontFamily: GameConstants.fontFamily,
                    fontSize: Responsive.getFontSize(60),
                  ),
                  textScaleFactor: 1.0,
                  textAlign: TextAlign.start,
                ),
                Container(
                  height: Responsive.getValueInPixel(10),
                ),
                Text(
                  "A reusable bag needs to be used at least 131 times",
                  style: TextStyle(
                    decoration: TextDecoration.none,
                    color: const Color(0xffFFFFFF),
                    fontWeight: FontWeight.w500,
                    fontStyle: FontStyle.normal,
                    fontFamily: GameConstants.fontFamily,
                    fontSize: Responsive.getFontSize(70),
                  ),
                  textScaleFactor: 1.0,
                  textAlign: TextAlign.start,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class ScrollButtonModel extends ChangeNotifier {
  bool isVisible = false;
  bool disabled = false;
  late AnimationController animationController;
  late Animation<double> fadeAnimation;

  ScrollButtonModel(TickerProvider vsync) {
    animationController = AnimationController(
        vsync: vsync, duration: const Duration(milliseconds: 200));
    fadeAnimation = Tween(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: animationController,
        curve: const Interval(
          0.0,
          1.0,
          curve: Curves.easeInOut,
        ),
      ),
    );
  }
  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  void show() {
    if (isVisible) {
      return;
    }
    isVisible = true;
    animationController.forward();
  }

  void hide({bool force = false}) {
    if (!isVisible) {
      return;
    }
    animationController.reverse();
  }
}

class ScrollButton extends StatelessWidget {
  const ScrollButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
