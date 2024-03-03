import 'package:flutter/material.dart';
import 'package:ggc/game_constant.dart';
import 'package:ggc/model/game_logic.dart';
import 'package:ggc/responsive.dart';

import '../util.dart';

class CustomAppBar extends StatelessWidget {
  final int? sunCurrency;
  final int? dropletCurrency;
  const CustomAppBar({super.key, this.sunCurrency, this.dropletCurrency});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: Responsive.getDefaultHeightDim(150)),
      height: Responsive.getDefaultHeightDim(200),
      width: Responsive.getDeviceWidth(),
      color: Colors.transparent,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          sunWidget(),
          dropWidget(),
        ],
      ),
    );
  }

  Widget sunWidget() {
    return Container(
      margin: EdgeInsets.only(right: Responsive.getDefaultWidthDim(190)),
      width: Responsive.getValueInPixel(250),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Image(
              height: Responsive.getValueInPixel(100),
              width: Responsive.getValueInPixel(100),
              image: Util.getLocalImage(GameConstants.sunIcon)),
          Container(
            width: Responsive.getValueInPixel(20),
          ),
          Text(
            sunCurrency == null
                ? "${GameLogic.gameData.sunCurrency}"
                : "$sunCurrency",
            style: TextStyle(
              decoration: TextDecoration.none,
              color: const Color(0xffF19B38),
              fontWeight: FontWeight.w600,
              fontStyle: FontStyle.normal,
              fontFamily: GameConstants.fontFamily,
              fontSize: Responsive.getFontSize(75),
            ),
            textScaleFactor: 1.0,
            textAlign: TextAlign.start,
          ),
        ],
      ),
    );
  }

  Widget dropWidget() {
    return Container(
      margin: EdgeInsets.only(right: Responsive.getDefaultWidthDim(80)),
      width: Responsive.getValueInPixel(250),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Image(
              height: Responsive.getValueInPixel(100),
              width: Responsive.getValueInPixel(100),
              image: Util.getLocalImage(GameConstants.droplet)),
          Container(
            width: Responsive.getValueInPixel(20),
          ),
          Text(
            dropletCurrency == null
                ? "${GameLogic.gameData.dropletCurrency}"
                : "$dropletCurrency",
            style: TextStyle(
              decoration: TextDecoration.none,
              color: const Color(0xff53AEF0),
              fontWeight: FontWeight.w600,
              fontStyle: FontStyle.normal,
              fontFamily: GameConstants.fontFamily,
              fontSize: Responsive.getFontSize(75),
            ),
            textScaleFactor: 1.0,
            textAlign: TextAlign.start,
          ),
        ],
      ),
    );
  }
}
