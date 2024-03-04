import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:ggc/logic/game_logic.dart';
import 'package:ggc/ui/app_bar.dart';
import 'package:rive/rive.dart';

import '../game_constant.dart';
import '../logic/leaf_logic.dart';
import '../responsive.dart';
import '../util.dart';
import 'bottom_bar.dart';

class LeafScreen extends StatefulWidget {
  const LeafScreen({super.key});
  static String routeName = "/leaf";

  @override
  State<LeafScreen> createState() => _LeafScreenState();
}

class _LeafScreenState extends State<LeafScreen> with TickerProviderStateMixin {
  Artboard? _riveArtboard;
  StateMachineController? mainStateController;
  bool showTree = false;
  late AnimationController fadeController;
  late Animation<double> fadeAnimation;

  @override
  void initState() {
    super.initState();
    fadeController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 250));
    fadeAnimation = Tween(begin: 0.0, end: 1.0).animate(CurvedAnimation(
      parent: fadeController,
      curve: Curves.easeInOut,
    ));
    WidgetsBinding.instance.addPostFrameCallback((_) {
      BottomBar.jewelNotifModel.hideNotif(LeafScreen.routeName);
    });

    _load();
  }

  @override
  void dispose() {
    if (mainStateController != null) {
      mainStateController!.dispose();
    }
    fadeController.dispose();
    super.dispose();
  }

  Future<void> _load() async {
    showTree = LeafLogic.getCurrTreeLevel() > 0;
    _riveArtboard = LeafLogic.riveFile.mainArtboard.instance();
    mainStateController =
        StateMachineController.fromArtboard(_riveArtboard!, "State Machine 1");
    _riveArtboard!.addController(mainStateController!);
    updateProgress(LeafLogic.currLevelTriggerVal());
    if (mounted) {
      setState(() {});
    }
    SchedulerBinding.instance.addPostFrameCallback((_) {
      Timer(const Duration(milliseconds: 200), () {
        if (showTree) {
          fadeController.forward();
        }
      });
    });
  }

  void updateProgress(double val) {
    SMINumber input = mainStateController!.findSMI("input");
    input.change(val);
  }

  void handleUpgrade() {
    if (!LeafLogic.canUpgradeTree()) {
      return;
    }
    LeafLogic.currnecyDecrement();
    double trigger = LeafLogic.nextLevelTriggerVal();
    LeafLogic.completeLevel();
    updateProgress(trigger);
    if (!showTree) {
      showTree = true;
      fadeController.forward();
    }
  }

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
            image: Util.getLocalImage(GameConstants.leafBack),
            fit: BoxFit.fill,
          ),
          FadeTransition(opacity: fadeAnimation, child: getTreeWidget()),
          if (!LeafLogic.isEOC()) upgradeBanner(),
          Positioned.fill(
              child: Align(
            alignment: Alignment.bottomCenter,
            child: BottomBar(LeafScreen.routeName),
          )),
          Positioned.fill(
              child: Align(
            alignment: Alignment.topCenter,
            child: CustomAppBar(
              sunCurrency: GameLogic.gameData.sunCurrency,
              dropletCurrency: GameLogic.gameData.dropletCurrency,
            ),
          ))
        ]),
      ),
    );
  }

  Widget getTreeWidget() {
    return _riveArtboard == null
        ? Container(
            color: Colors.red.withOpacity(0.0),
          )
        : Transform.translate(
            offset: const Offset(0, 0.0),
            child: Container(
              width: Responsive.getDeviceWidth(),
              height: Responsive.getDeviceHeight(),
              margin: EdgeInsets.only(
                  bottom:
                      Responsive.getDefaultHeightDim(BottomBar.height * 0.3)),
              child: Stack(
                children: [
                  Rive(
                    artboard: _riveArtboard!,
                    enablePointerEvents: true,
                    fit: BoxFit.cover,
                  ),
                ],
              ),
            ),
          );
  }

  Widget upgradeBanner() {
    return Container(
      padding:
          EdgeInsets.symmetric(horizontal: Responsive.getDefaultWidthDim(70)),
      margin: EdgeInsets.only(top: Responsive.getDefaultHeightDim(400)),
      height: Responsive.getDefaultHeightDim(500),
      child: Stack(
        children: [
          Image(
            image: Util.getLocalImage(GameConstants.leafToaster),
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                width: Responsive.getDeviceWidth() * 0.65,
                height: Responsive.getDefaultHeightDim(400),
                margin:
                    EdgeInsets.only(left: Responsive.getDefaultHeightDim(50)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "NEXT UPGRADE AT",
                      style: TextStyle(
                        decoration: TextDecoration.none,
                        color: Color.fromARGB(255, 255, 255, 255),
                        fontWeight: FontWeight.w500,
                        fontStyle: FontStyle.normal,
                        fontFamily: GameConstants.fontFamily,
                        fontSize: Responsive.getFontSize(50),
                      ),
                      textScaleFactor: 1.0,
                      textAlign: TextAlign.start,
                    ),
                    Row(
                      children: [
                        Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Image(
                                  height: Responsive.getValueInPixel(90),
                                  width: Responsive.getValueInPixel(100),
                                  image: Util.getLocalImage(
                                      GameConstants.sunIcon)),
                              Container(
                                width: Responsive.getValueInPixel(20),
                              ),
                              Text(
                                "${LeafLogic.nextLevelSunNeeded()}",
                                style: TextStyle(
                                  decoration: TextDecoration.none,
                                  color: const Color(0xffF19B38),
                                  fontWeight: FontWeight.w600,
                                  fontStyle: FontStyle.normal,
                                  fontFamily: GameConstants.fontFamily,
                                  fontSize: Responsive.getFontSize(65),
                                ),
                                textScaleFactor: 1.0,
                                textAlign: TextAlign.start,
                              ),
                            ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(
                              left: Responsive.getValueInPixel(200)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Image(
                                  height: Responsive.getValueInPixel(90),
                                  width: Responsive.getValueInPixel(100),
                                  image: Util.getLocalImage(
                                      GameConstants.droplet)),
                              Container(
                                width: Responsive.getValueInPixel(20),
                              ),
                              Text(
                                "${LeafLogic.nextLevelWaterNeeded()}",
                                style: TextStyle(
                                  decoration: TextDecoration.none,
                                  color: const Color(0xff53AEF0),
                                  fontWeight: FontWeight.w600,
                                  fontStyle: FontStyle.normal,
                                  fontFamily: GameConstants.fontFamily,
                                  fontSize: Responsive.getFontSize(65),
                                ),
                                textScaleFactor: 1.0,
                                textAlign: TextAlign.start,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    upgradeButton()
                  ],
                ),
              ),
              Container(
                margin:
                    EdgeInsets.only(left: Responsive.getDefaultWidthDim(100)),
                child: Image(
                  height: Responsive.getValueInPixel(470),
                  image: Util.getLocalImage(GameConstants.line),
                ),
              ),
              Container(
                height: Responsive.getDefaultHeightDim(400),
                width: Responsive.getValueInPixel(120),
                margin:
                    EdgeInsets.only(left: Responsive.getDefaultWidthDim(50)),
                child: Image(
                  height: Responsive.getValueInPixel(120),
                  width: Responsive.getValueInPixel(120),
                  image: Util.getLocalImage(GameConstants.shareIcon),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget upgradeButton() {
    return GestureDetector(
      onTap: () {
        if (!LeafLogic.canUpgradeTree()) {
          ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Not enough sun or water')));

          return;
        }
        handleUpgrade();
        setState(() {});
      },
      child: Center(
        child: Stack(children: [
          SizedBox(
            width: Responsive.getDefaultWidthDim(1178),
            height: Responsive.getDefaultHeightDim(120),
            child: Image(
              width: Responsive.getDefaultWidthDim(1178),
              height: Responsive.getDefaultHeightDim(120),
              image: !LeafLogic.canUpgradeTree()
                  ? Util.getLocalImage(GameConstants.disableButton)
                  : Util.getLocalImage(GameConstants.listButton),
              fit: BoxFit.fill,
            ),
          ),
          SizedBox(
            width: Responsive.getDefaultWidthDim(1178),
            height: Responsive.getDefaultHeightDim(120),
            child: Center(
              child: Text(
                "UPGRADE NOW",
                style: TextStyle(
                  decoration: TextDecoration.none,
                  color: LeafLogic.canUpgradeTree()
                      ? Colors.white
                      : const Color(0xffAFAFAF),
                  fontWeight: FontWeight.w500,
                  fontStyle: FontStyle.normal,
                  fontFamily: GameConstants.fontFamily,
                  fontSize: Responsive.getFontSize(60),
                ),
                textScaleFactor: 1.0,
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ]),
      ),
    );
  }
}
