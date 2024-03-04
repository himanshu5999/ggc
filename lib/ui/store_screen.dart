import 'package:flutter/material.dart';
import 'package:ggc/ui/app_bar.dart';

import '../game_constant.dart';
import '../responsive.dart';
import '../util.dart';
import 'bottom_bar.dart';

class StoreScreen extends StatefulWidget {
  const StoreScreen({super.key});
  static String routeName = "/store";

  @override
  State<StoreScreen> createState() => _StoreScreenState();
}

class _StoreScreenState extends State<StoreScreen> {
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
            child: Container(
              margin: EdgeInsets.only(top: Responsive.getDefaultHeightDim(100)),
              height: Responsive.getDefaultHeightDim(1431),
              width: Responsive.getDefaultWidthDim(1037),
              child: Stack(
                children: [
                  Image(
                    height: Responsive.getDefaultHeightDim(1431),
                    width: Responsive.getDefaultWidthDim(1037),
                    image: Util.getLocalImage(GameConstants.storeBag),
                    fit: BoxFit.fill,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: Responsive.getValueInPixel(50)),
                        margin: EdgeInsets.only(
                            bottom: Responsive.getValueInPixel(100)),
                        child: Text(
                          "Green131 Tote Bag",
                          style: TextStyle(
                            decoration: TextDecoration.none,
                            color: const Color.fromARGB(255, 255, 255, 255),
                            fontWeight: FontWeight.w500,
                            fontStyle: FontStyle.normal,
                            fontFamily: GameConstants.fontFamily,
                            fontSize: Responsive.getFontSize(65),
                          ),
                          textScaleFactor: 1.0,
                          textAlign: TextAlign.center,
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: Responsive.getValueInPixel(50)),
                        margin: EdgeInsets.only(
                            bottom: Responsive.getValueInPixel(30)),
                        child: Text(
                          "Time to turn this bag into a no-plastic hero!",
                          style: TextStyle(
                            decoration: TextDecoration.none,
                            color: const Color.fromARGB(255, 255, 255, 255),
                            fontWeight: FontWeight.w400,
                            fontStyle: FontStyle.normal,
                            fontFamily: GameConstants.fontFamily,
                            fontSize: Responsive.getFontSize(60),
                          ),
                          textScaleFactor: 1.0,
                          textAlign: TextAlign.center,
                        ),
                      ),
                      Center(
                        child: Container(
                          margin: EdgeInsets.only(
                              bottom: Responsive.getValueInPixel(70)),
                          width: Responsive.getValueInPixel(966),
                          height: Responsive.getValueInPixel(158),
                          child: Stack(children: [
                            Image(
                              width: Responsive.getValueInPixel(966),
                              height: Responsive.getValueInPixel(158),
                              image:
                                  Util.getLocalImage(GameConstants.listButton),
                              fit: BoxFit.fill,
                            ),
                            Center(
                              child: Text(
                                "BUY FOR ₹300 NOW!",
                                style: TextStyle(
                                  decoration: TextDecoration.none,
                                  color:
                                      const Color.fromARGB(255, 255, 255, 255),
                                  fontWeight: FontWeight.w500,
                                  fontStyle: FontStyle.normal,
                                  fontFamily: GameConstants.fontFamily,
                                  fontSize: Responsive.getFontSize(50),
                                ),
                                textScaleFactor: 1.0,
                                textAlign: TextAlign.center,
                              ),
                            )
                          ]),
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
          const Positioned.fill(
              child: Align(
            alignment: Alignment.topCenter,
            child: CustomAppBar(),
          )),
          Positioned.fill(
              child: Align(
            alignment: Alignment.bottomCenter,
            child: BottomBar(StoreScreen.routeName),
          ))
        ]),
      ),
    );
  }
}
