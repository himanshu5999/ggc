import 'package:flutter/material.dart';

import '../game_constant.dart';
import '../responsive.dart';
import '../util.dart';
import 'bottom_bar.dart';

class ScreenTopBar extends StatelessWidget {
  final double barValue;
  final bool showBack;
  const ScreenTopBar({super.key, required this.barValue, this.showBack = true});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: Responsive.getDefaultHeightDim(200)),
      height: Responsive.getDefaultHeightDim(160),
      width: Responsive.getDeviceWidth(),
      color: Colors.transparent,
      child: Stack(children: [
        if (showBack)
          GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Container(
              margin: EdgeInsets.only(left: Responsive.getValueInPixel(80)),
              width: Responsive.getValueInPixel(80),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image(
                    height: Responsive.getValueInPixel(80),
                    width: Responsive.getValueInPixel(80),
                    image: Util.getLocalImage(GameConstants.backIcon),
                    fit: BoxFit.fill,
                  ),
                ],
              ),
            ),
          ),
        Center(
          child: Container(
            height: Responsive.getDefaultHeightDim(160),
            width: Responsive.getDefaultWidthDim(835),
            color: Colors.transparent,
            child: Stack(children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: Responsive.getDefaultHeightDim(55),
                    width: Responsive.getDefaultWidthDim(825),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(
                            Radius.circular(Responsive.getValueInPixel(60)))),
                    child: Row(
                      children: [
                        Container(
                            height: Responsive.getDefaultHeightDim(55),
                            width:
                                Responsive.getDefaultWidthDim(barValue * 825),
                            decoration: BoxDecoration(
                                gradient: const LinearGradient(
                                    begin: Alignment(0.49999999999999994,
                                        -3.0616171314629196e-17),
                                    end: Alignment(0.49999999999999994,
                                        0.9999999999999999),
                                    colors: [
                                      Color(0xff7ee751),
                                      Color(0xff38c53c)
                                    ]),
                                borderRadius: BorderRadius.all(Radius.circular(
                                    Responsive.getValueInPixel(60))))),
                      ],
                    ),
                  ),
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    margin: EdgeInsets.only(
                        left: Responsive.getDefaultWidthDim(825) / 3),
                    height: Responsive.getDefaultHeightDim(55),
                    width: Responsive.getValueInPixel(1),
                    color: Colors.black,
                  ),
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    margin: EdgeInsets.only(
                        left: 2 * Responsive.getDefaultWidthDim(825) / 3),
                    height: Responsive.getDefaultHeightDim(55),
                    width: Responsive.getValueInPixel(1),
                    color: Colors.black,
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(),
                  Container(
                    margin:
                        EdgeInsets.only(bottom: Responsive.getValueInPixel(40)),
                    child: Image(
                        height: Responsive.getValueInPixel(150),
                        width: Responsive.getValueInPixel(150),
                        image: Util.getLocalImage(GameConstants.giftIcon)),
                  )
                ],
              ),
            ]),
          ),
        )
      ]),
    );
  }
}

class ScreenBottomBar extends StatelessWidget {
  final String buttonText;
  final Function onButtonTap;
  final int item;
  const ScreenBottomBar(
      {super.key,
      required this.buttonText,
      required this.onButtonTap,
      this.item = 1});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: Responsive.getDefaultHeightDim(BottomBar.height),
      width: Responsive.getDeviceWidth(),
      color: Colors.white,
      child: GestureDetector(
        onTap: () {
          onButtonTap();
        },
        child: Center(
          child: Stack(children: [
            SizedBox(
              width: Responsive.getDefaultWidthDim(1178),
              height: Responsive.getDefaultHeightDim(158),
              child: Image(
                width: Responsive.getDefaultWidthDim(1178),
                height: Responsive.getDefaultHeightDim(158),
                image: item == 0
                    ? Util.getLocalImage(GameConstants.disableButton)
                    : Util.getLocalImage(GameConstants.listButton),
                fit: BoxFit.fill,
              ),
            ),
            SizedBox(
              width: Responsive.getDefaultWidthDim(1178),
              height: Responsive.getDefaultHeightDim(158),
              child: Center(
                child: Text(
                  buttonText,
                  style: TextStyle(
                    decoration: TextDecoration.none,
                    color: item == 0 ? Color(0xffAFAFAF) : Colors.white,
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
      ),
    );
  }
}
