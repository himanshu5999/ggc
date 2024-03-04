import 'package:flutter/material.dart';
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

class _LeafScreenState extends State<LeafScreen> {
  Artboard? _riveArtboard;
  StateMachineController? mainStateController;

  @override
  void initState() {
    super.initState();
    _load();
  }

  @override
  void dispose() {
    if (mainStateController != null) {
      mainStateController!.dispose();
    }
    super.dispose();
  }

  Future<void> _load() async {
    if (mounted) {
      setState(() {
        _riveArtboard = LeafLogic.riveFile.mainArtboard.instance();
      });
    }

    mainStateController =
        StateMachineController.fromArtboard(_riveArtboard!, "State Machine 1");
    _riveArtboard!.addController(mainStateController!);
    updateProgress(50.0);
  }

  void updateProgress(double val) {
    SMINumber input = mainStateController!.findSMI("input");
    input.change(val);
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
            image: Util.getLocalImage(GameConstants.background),
            fit: BoxFit.fill,
          ),
          // getTreeWidget(),
          upgradeBanner(5, 10),
          Positioned.fill(
              child: Align(
            alignment: Alignment.bottomCenter,
            child: BottomBar(LeafScreen.routeName),
          )),
          const Positioned.fill(
              child: Align(
            alignment: Alignment.topCenter,
            child: CustomAppBar(),
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
        : Transform.scale(
            scale: 1.0,
            child: Container(
              width: Responsive.getDeviceWidth(),
              height: Responsive.getDeviceHeight(),
              margin: EdgeInsets.only(
                  bottom: Responsive.getDefaultHeightDim(BottomBar.height)),
              child: Stack(
                children: [
                  Rive(
                    artboard: _riveArtboard!,
                    enablePointerEvents: true,
                    // useArtboardSize: true,
                    fit: BoxFit.cover,
                  ),
                ],
              ),
            ),
          );
  }

  Widget upgradeBanner(int reqSun, int reqDroplet) {
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
                                "$reqSun",
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
                                "$reqDroplet",
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
            ],
          )
        ],
      ),
    );
  }

  Widget upgradeButton() {
    return GestureDetector(
      onTap: () {
        if (!isButtonEnable()) {
          return;
        }
        // onButtonTap();
      },
      child: Center(
        child: Stack(children: [
          SizedBox(
            width: Responsive.getDefaultWidthDim(1178),
            height: Responsive.getDefaultHeightDim(120),
            child: Image(
              width: Responsive.getDefaultWidthDim(1178),
              height: Responsive.getDefaultHeightDim(120),
              image: !isButtonEnable()
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
                  color:
                      isButtonEnable() ? Colors.white : const Color(0xffAFAFAF),
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

  bool isButtonEnable() {
    return true;
  }
}
